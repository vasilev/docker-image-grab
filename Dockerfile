FROM python:3.8-alpine AS builder

RUN apk add build-base curl-dev libxslt-dev \
 && pip install grab


FROM python:3.8-alpine
RUN apk add --no-cache libxslt \
 && export SPPATH=`python -c 'import site; print(site.getsitepackages()[0])'`

COPY --from=builder ${SPPATH} ${SPPATH}

ENTRYPOINT ["/bin/sh"]
