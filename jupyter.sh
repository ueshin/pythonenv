#!/bin/bash

_ROOT="$(cd "$(dirname "$0")"; pwd)"
_BASE_NAME=$(basename "${_ROOT}")

source "${_ROOT}"/_opts.sh

source "${_ROOT}"/_env.sh

if [ -z "${CONDA_ENV_PREFIX}" ]; then
    export CONDA_ENV_PREFIX="${_BASE_NAME}"
fi

source "${_ROOT}"/_activate.sh

if [ -z "${_WORKTREE}" ]; then
    export SPARK_HOME="${_ROOT}"/"${SOURCE_PATH}"
else
    export SPARK_HOME="$(cd "${_WORKTREE}"; pwd)"
fi

find "${SPARK_HOME}" -name '*.pyc' | xargs rm

export SPARK_PREPEND_CLASSES=true
export PYTHONPATH="$(find "${SPARK_HOME}/python/lib" -name 'py4j-*-src.zip' -type f | uniq)":"${SPARK_HOME}/python"

jupyter notebook "${_ROOT}"/notebooks
