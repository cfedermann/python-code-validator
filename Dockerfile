FROM python:3

LABEL "com.github.actions.name"="Python Code Validator"
LABEL "com.github.actions.description"="Runs black, mypy, pylint, reorder-python-imports and safety"
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="black"

LABEL "repository"="https://github.com/cfedermann/python-code-validator"
LABEL "homepage"="https://github.com/cfedermann/python-code-validator"
LABEL "maintainer"="cfedermann"

ENV PYLINT_THRESHOLD "9"
ENV BLACK_LINE_MAXLEN "100"

RUN pip install black==21.7b0 mypy==0.900 pylint==2.9.6 pylint-fail-under==0.3.0 reorder-python-imports==2.6.0 safety==1.10.3

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
