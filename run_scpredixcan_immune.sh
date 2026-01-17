#!/bin/bash

# stop if any command fails
set -e

# Initialize conda
source ~/miniconda3/etc/profile.d/conda.sh
conda activate imlabtools

PHECODE=172
POP=META
CELL_TYPE=immune
SCRIPT=~/aou_sc_predixcan/03run_predixcan.py

REFS=(
  CD14-positive_monocyte
)

for REF in "${REFS[@]}"; do
  echo "=========================================="
  echo "Running scPrediXcan for immune cell: $REF"
  echo "=========================================="

  python $SCRIPT \
    --phecode $PHECODE \
    --pop $POP \
    --ref $REF \
    --cell_type $CELL_TYPE

  echo "Finished $REF"
  echo
done

echo "All immune cell scPrediXcan runs completed."
