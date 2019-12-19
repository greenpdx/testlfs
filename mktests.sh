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
echo "\$(ls -l)"
export TEST_RESULT_LOG="\${BTR_CUR_TEST_LOG_DIR}/test-metrics.txt"
printf "\${TEST_RESULT_LOG}"
cat << EOF >> \${TEST_RESULT_LOG}
ACTUAL_PERFORMANCE_FPS=30
BLOB_ESTIMATE_FPS=40
CRC_MATCH="PASS"
NN_PERFORMANCE_CLK=100
BLOB_ESTIMATE_us=500
EOF
exit(0)
__END_TEST_APP
chmod +x "${test_app}"

printf "wrote file $(ls -l)\n"

