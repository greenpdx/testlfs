#!/bin/bash

function wrtest() {
    cat << __END_TEST_APP > "$1" 
#!/bin/bash
set -eu
source ${WORK_ROOT}/STEM/projects/kmb-nnruntime/bin/vpu_fullnet.sh
printf "$(pwd)"
export WORK_ROOT="\${HOME}/work"
cd \${WORK_ROOT}
echo "DummyTest"
echo "\$(ls -l)"
echo \$(env)
export TEST_RESULT_LOG="\${BTR_CUR_TEST_LOG_DIR}/test-metrics.txt"
export TEST_NET_NAME="dummy_net"
export NETWORK_COMP_DESC="dummy.json"
export TEST_CRC_RESULT="PASS"
export BLOB_EST_FPS=500
export CLKCYC_FPS=600
export BLOB_EST=25000000
export CLKCYC=6000000
save_results >> \${TEST_RESULT_LOG}
exit 0
__END_TEST_APP
    chmod 775 "$1"

}


test_app="t_dummy_test"
printf "make t_dummy_test $(pwd)\n"

mkdir -p ${WORK_ROOT}/tests
cd ${WORK_ROOT}/tests
touch btr-helper

mkdir logs

#cat << EOF > btr-helper
###!/bin/bash
#EOF
#chmod 775 btr-helper

wrtest "${test_app}" 

mkdir -p level2
cd level2
touch btr-helper
wrtest("t_level2_test")
cd ..

printf "wrote file $(ls -l)\n"

