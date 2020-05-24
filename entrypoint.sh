#!/bin/sh -e

pip install -r requirements.txt

black -S -l 75 --check .
find . -name "*.py" | xargs mypy
find . -name "*.py" | xargs pylint-fail-under --fail_under $PYLINT_THRESHOLD
find . -name "*.py" | xargs reorder-python-imports --diff-only
cat requirements.txt | safety check --stdin
