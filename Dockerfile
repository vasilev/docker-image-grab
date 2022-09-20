FROM python:3.10-alpine AS builder

ARG PIP_DISABLE_PIP_VERSION_CHECK=1
ARG PIP_NO_CACHE_DIR=1
ARG PIP_ROOT_USER_ACTION=ignore

RUN apk add build-base curl-dev libxslt-dev \
 && pip install grab


FROM python:3.10-alpine
RUN apk add --no-cache libxslt \
 && export SPPATH=`python -c 'import site; print(site.getsitepackages()[0])'`

COPY --from=builder ${SPPATH} ${SPPATH}

ENTRYPOINT ["/bin/sh"]
