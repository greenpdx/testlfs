#!/bin/bash

test_app="t_dummy_test"
printf "make t_dummy_test\n"

cd ${WORK_ROOT}/test

cat << __END_TEST_APP > "${test_app}" 
#!/bin/bash
set -eu
export WORK_ROOT="${HOME}/work"
TEST_DIR=\${WORK_ROOT}/\${TEST_BASE_DIR}
cd ${TEST_DIR}
echo "DummyTest\n"
echo $(ls -l)

__END_TEST_APP

printf "wrote file"

