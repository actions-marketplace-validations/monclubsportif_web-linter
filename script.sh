#!/bin/sh -e

cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit
export ESLINT_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

TEMP_PATH="$(mktemp -d)"
PATH="${TEMP_PATH}:$PATH"

RUNNER="${INPUT_ESLINT_INSTALLER}"

if [ "${RUNNER}" = "detect" ]; then
  if [ -f './yarn.lock' ]; then
    RUNNER="yarn"
  else
    RUNNER="npm"
  fi
fi

if [ "${INPUT_SKIP_INSTALL}" = "false" ]; then
  echo "Installing everything"
  ${RUNNER} install
  echo "Finished install"
fi

echo 'Running eslint'
eslint_rc=0
${RUNNER} eslint ${INPUT_ESLINT_FILES} --max-warnings ${INPUT_MAX_WARNINGS} ${INPUT_ESLINT_FLAGS} || eslint_rc=$?
if [ "${INPUT_FAIL_ON_ERROR}" = "false" ]; then
  eslint_rc=0
fi
echo 'Finished eslint'

exit $eslint_rc
