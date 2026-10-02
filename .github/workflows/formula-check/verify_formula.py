#!/usr/bin/env python3
"""Match a whole formula to its template and published release checksums."""

import argparse
from pathlib import Path
import re
from string import Template
import sys
from urllib.error import URLError
from urllib.request import urlopen


CHECKER_DIR = Path(__file__).resolve().parent
ROOT = CHECKER_DIR.parents[2]
TARGETS = {
    "env-vault": ("darwin-arm64", "darwin-amd64", "linux-arm64", "linux-amd64"),
    "macos-user-settings": ("darwin-arm64", "darwin-amd64"),
}
MAX_FORMULA_BYTES = 65536
MAX_SIDECAR_BYTES = 4096


class InvalidFormula(ValueError):
    """A formula or release checksum is outside the accepted format."""


def release_version(formula):
    if len(formula) > MAX_FORMULA_BYTES:
        raise InvalidFormula("formula is too large")
    versions = re.findall(rb'^  version "([0-9]+\.[0-9]+\.[0-9]+)"$', formula, re.M)
    if len(versions) != 1:
        raise InvalidFormula("formula must contain one canonical version line")
    return versions[0].decode("ascii")


def published_checksum(sidecar, archive):
    pattern = rb"([0-9a-f]{64})  " + re.escape(archive.encode("ascii")) + rb"\n?"
    match = re.fullmatch(pattern, sidecar)
    if match is None:
        raise InvalidFormula("invalid published checksum for " + archive)
    return match[1].decode("ascii")


def download_sidecar(url):
    # The caller constructs every URL from an allowlisted project and target.
    # Read only the small sidecar; never download or evaluate the formula's Ruby.
    with urlopen(url, timeout=30) as response:
        sidecar = response.read(MAX_SIDECAR_BYTES + 1)
    if len(sidecar) > MAX_SIDECAR_BYTES:
        raise InvalidFormula("published checksum sidecar is too large")
    return sidecar


def verify(formula_name, formula, fetch=download_sidecar):
    if formula_name not in TARGETS:
        raise InvalidFormula("unsupported formula")
    version = release_version(formula)
    substitutions = {"version": version}
    for target in TARGETS[formula_name]:
        archive = formula_name + "-" + target + ".tar.gz"
        url = (
            "https://github.com/ildarbinanas-design/"
            + formula_name
            + "/releases/download/v"
            + version
            + "/"
            + archive
            + ".sha256"
        )
        substitutions["sha256_" + target.replace("-", "_")] = published_checksum(
            fetch(url), archive
        )
    template_path = CHECKER_DIR / "templates" / (formula_name + ".rb.in")
    template = Template(template_path.read_bytes().decode("ascii"))
    expected = template.substitute(substitutions).encode("ascii")
    if formula != expected:
        raise InvalidFormula("formula differs from the complete release template")
    return version


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("formula", choices=TARGETS)
    args = parser.parse_args()
    try:
        with (ROOT / "Formula" / (args.formula + ".rb")).open("rb") as source:
            formula = source.read(MAX_FORMULA_BYTES + 1)
        version = verify(args.formula, formula)
    except (InvalidFormula, OSError, URLError, UnicodeError) as error:
        print("formula verification failed: " + str(error), file=sys.stderr)
        return 1
    print(args.formula + " v" + version + ": complete formula matches published checksums")
    return 0


if __name__ == "__main__":
    sys.exit(main())
