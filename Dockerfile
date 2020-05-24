FROM python:3

LABEL "com.github.actions.name"="Python Code Validator"
LABEL "com.github.actions.description"="Runs black, mypy, pylint, reorder-python-imports and safety"
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="black"

LABEL "repository"="https://github.com/cfedermann/python-code-validator"
LABEL "homepage"="https://github.com/cfedermann/python-code-validator"
LABEL "maintainer"="cfedermann"

RUN pip install black mypy pylint-fail-under reorder-python-imports safety

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
