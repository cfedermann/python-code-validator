# python-code-validator
Runs black, mypy, pylint, reorder-python-imports and safety

## Configuration
In your `.github/workflows/main.yml`, set environment variable `PYLINT_THRESHOLD` to a value between `0` and `10`, e.g.:

    name: "PythonCodeValidator"
    
    on: [push, pull_request]
    
    jobs:
      formatting:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v2
          - name: Python Code Validator
            uses: cfedermann/python-code-validator@master
            env:
                PYLINT_THRESHOLD: 8
                BLACK_LINE_MAXLEN: 100

You can drop the `env:` section in your `main.yml` file if you want to use the default value `9`.

Set `BLACK_LINE_MAXLEN` to the desired max line length.

In your local repo, it may be useful to add a `validation.sh` script to allow local testing before the GitHub action is run on the server. The following is an example used in a GitHub codespace (where `./venv/` stores the virtual environment):

    #!/bin/sh -e

    pip install black mypy pylint-fail-under reorder-python-imports safety
    pip install -r requirements.txt

    export PYLINT_THRESHOLD=8
    export BLACK_LINE_MAXLEN=100

    black -S -l $BLACK_LINE_MAXLEN --check .
    find . -name "*.py" -not -path "./.venv/*" | xargs mypy
    find . -name "*.py" -not -path "./.venv/*" | xargs pylint-fail-under --fail_under $PYLINT_THRESHOLD
    find . -name "*.py" -not -path "./.venv/*" | xargs reorder-python-imports --diff-only
    cat requirements.txt | safety check --stdin
    
Note that this should match `entrypoint.sh` but you are free to ignore local folders (such as `./.venv/`) if they exist in your dev environment.
