#!/bin/bash

test_app="t_dummy_test"
printf "make t_dummy_test\n"

mkdir -p ${WORK_ROOT}/tests
cd ${WORK_ROOT}/tests
touch btr-helper

cat << __END_TEST_APP > "${test_app}" 
#!/bin/bash
set -eu
export WORK_ROOT="\${HOME}/work"
cd \${WORK_ROOT}
echo "DummyTest"
echo "$(ls -l)"
export TEST_RESULT_LOG="\${BTR_CUR_TEST_LOG_DIR}/test-metrics.txt"
printf "\${TEST_RESULT_LOG}"
touch \${TEST_RESULT_LOG}
exit(0)
__END_TEST_APP
chmod +x "${test_app}"

printf "wrote file $(ls -l)\n"

