import io
from pathlib import Path
import sys
import unittest
from unittest.mock import patch


ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / ".github" / "workflows" / "formula-check"))
import verify_formula as checker


# Published releases used by the checked-in formulae. These fixed values also
# check that the full templates agree with both existing release generators.
RELEASES = {
    "env-vault": (
        "0.4.1",
        (
            "57f61cc692a1314038993604ad7143093261063e169e82f02d9a4ae7ec653664",
            "a1e43ffa8931a4dd51bb17d61ee768747b1e488e5a61ec1f1ec2988fa89c110f",
            "2470911cc7e6655de29cc32186eef208922408b51dd70ce78cff853e94d02dd3",
            "c28f0011e686686ce9928f81fa494dc3ce56461a113368917f5bb7b4943ae1af",
        ),
    ),
    "macos-user-settings": (
        "0.1.0",
        (
            "2b4ab1ab68ba109c79a72ac5d8bf0194c5743c5a3a6f77c10882256baf125576",
            "3c4d6dca55e37b69254ca81faecdeda33188fb0e85738ef828ba2775d6ed2185",
        ),
    ),
}


class FormulaVerificationTest(unittest.TestCase):
    def formula(self, name):
        # Stable golden files are independent of a later formula release bump.
        return (ROOT / "tests" / "fixtures" / (name + ".rb")).read_bytes()

    def checksums(self, name, version=None):
        released_version, sums = RELEASES[name]
        version = version or released_version
        return {
            "https://github.com/ildarbinanas-design/"
            + name
            + "/releases/download/v"
            + version
            + "/"
            + name
            + "-"
            + target
            + ".tar.gz.sha256": (digest + "  " + name + "-" + target + ".tar.gz\n").encode("ascii")
            for target, digest in zip(checker.TARGETS[name], sums)
        }

    def test_complete_released_formulae_match(self):
        for name, (version, _) in RELEASES.items():
            with self.subTest(formula=name):
                pending = self.checksums(name)
                self.assertEqual(checker.verify(name, self.formula(name), pending.pop), version)
                self.assertEqual(pending, {})

    def test_new_version_uses_only_its_canonical_sidecars(self):
        for name, (version, _) in RELEASES.items():
            with self.subTest(formula=name):
                formula = self.formula(name).replace(version.encode("ascii"), b"12.34.56")
                pending = self.checksums(name, "12.34.56")
                self.assertEqual(checker.verify(name, formula, pending.pop), "12.34.56")
                self.assertEqual(pending, {})

    def test_any_formula_change_is_rejected(self):
        for name, (version, _) in RELEASES.items():
            original = self.formula(name)
            mutations = {
                "comment": original + b"# Additional comment.\n",
                "ruby statement": original + b"puts 'additional statement'\n",
                "indentation": original.replace(b"  on_macos do", b"    on_macos do"),
                "line endings": original.replace(b"\n", b"\r\n"),
                "no final newline": original.rstrip(b"\n"),
                "install method": original.replace(b"    bin.install", b"    libexec.install"),
                "missing target": original.replace(b"    on_arm do", b"    on_missing do"),
                "changed url": original.replace(b"/releases/download/", b"/other/download/"),
                "changed checksum": original.replace(RELEASES[name][1][0].encode("ascii"), b"0" * 64),
                "missing checksum": b"\n".join(line for line in original.split(b"\n") if b"sha256" not in line),
                "duplicate version": original + b'  version "' + version.encode("ascii") + b'"\n',
                "version suffix": original.replace(version.encode("ascii"), (version + "-rc1").encode("ascii")),
                "oversize": original + b" " * checker.MAX_FORMULA_BYTES,
                "non-ascii": original + b"\xff",
            }
            for label, formula in mutations.items():
                with self.subTest(formula=name, change=label):
                    with self.assertRaises(checker.InvalidFormula):
                        checker.verify(name, formula, self.checksums(name).__getitem__)

    def test_published_checksum_must_name_exactly_the_expected_archive(self):
        for name in RELEASES:
            for url, valid in self.checksums(name).items():
                mutations = {
                    "wrong filename": valid.replace(b".tar.gz", b".zip"),
                    "uppercase digest": valid[:64].upper() + valid[64:],
                    "short digest": valid[1:],
                    "one separator": valid.replace(b"  ", b" "),
                    "missing filename": valid[:64] + b"\n",
                    "extra line": valid + valid,
                    "extra blank line": valid + b"\n",
                    "trailing spaces": valid.rstrip(b"\n") + b" \n",
                    "empty": b"",
                }
                for label, sidecar in mutations.items():
                    with self.subTest(formula=name, target=url, change=label):
                        sidecars = self.checksums(name)
                        sidecars[url] = sidecar
                        with self.assertRaises(checker.InvalidFormula):
                            checker.verify(name, self.formula(name), sidecars.__getitem__)

    def test_checksum_without_final_newline_is_accepted(self):
        for name in RELEASES:
            sidecars = {url: data.rstrip(b"\n") for url, data in self.checksums(name).items()}
            self.assertEqual(checker.verify(name, self.formula(name), sidecars.__getitem__), RELEASES[name][0])

    def test_missing_sidecar_fails(self):
        def missing(_):
            raise OSError("sidecar unavailable")

        with self.assertRaises(OSError):
            checker.verify("env-vault", self.formula("env-vault"), missing)

    def test_unsupported_formula_never_fetches(self):
        def unexpected(_):
            self.fail("unsupported formula fetched a checksum")

        with self.assertRaises(checker.InvalidFormula):
            checker.verify("../other", b'  version "1.2.3"\n', unexpected)

    def test_download_is_bounded(self):
        with patch.object(checker, "urlopen", return_value=io.BytesIO(b"x" * (checker.MAX_SIDECAR_BYTES + 1))):
            with self.assertRaises(checker.InvalidFormula):
                checker.download_sidecar("https://example.invalid/checksum")


if __name__ == "__main__":
    unittest.main()
