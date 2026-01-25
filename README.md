# To Run run_predixcan_islet_sequential.sh
chmod +x run_predixcan_islet_sequential.sh
./run_predixcan_islet_sequential.sh

#### (Optional background with log — still keep tab open):
nohup ./run_predixcan_islet_sequential.sh > islet_run.log 2>&1 &

#### Monitor:
tail -f islet_run.log

--------------------------------------------------------------------------------
