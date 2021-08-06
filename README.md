# python-code-validator
Runs black, mypy, pylint, reorder-python-imports and safety

## Validation strategy

1. Run `black -S -l $BLACK_LINE_MAXLEN` version `21.7b0`
2. Run `mypy` version `0.900`
3. Run `pylint` version `2.9.6`, failing if `score < $PYLINT_THRESHOLD`
4. Run `reorder-python-imports` version `2.6.0`
5. Run `safety` version `1.10.3`

## Default settings

- `BLACK_LINE_MAXLEN = 100`
- `PYLINT_THRESHOLD = 9`

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

    pip install black==21.7b0 mypy==0.900 pylint==2.9.6 pylint-fail-under==0.3.0 reorder-python-imports==2.6.0 safety==1.10.3
    pip install -r requirements.txt

    black -S -l $BLACK_LINE_MAXLEN --check .
    find . -name "*.py" -not -path "./.venv/*" | xargs mypy
    find . -name "*.py" -not -path "./.venv/*" | xargs pylint-fail-under --fail_under $PYLINT_THRESHOLD
    find . -name "*.py" -not -path "./.venv/*" | xargs reorder-python-imports --diff-only
    cat requirements.txt | safety check --stdin
    
Note that this should match `entrypoint.sh` but you are free to ignore local folders (such as `./.venv/`) if they exist in your dev environment.
