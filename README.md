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
