#!/bin/bash

set -e

# Initialize conda
source ~/miniconda3/etc/profile.d/conda.sh
conda activate imlabtools

PHECODE=172
POP=META
CELL_TYPE=islet
SCRIPT=~/aou_sc_predixcan/03run_predixcan.py

refs=(
  Acinar
  Activated_stellate
  Alpha
  Beta
  Delta
  Ductal
  Endothelial
  Epsilon
  Gamma
  Immune
  Quiescent_stellate
)

for ref in "${refs[@]}"; do
  echo "Running PrediXcan for islet cell type: $ref"
  python "$SCRIPT" --phecode "$PHECODE" --pop "$POP" --ref "$ref" --cell_type "$CELL_TYPE"
done

echo "All islet cell PrediXcan runs completed."
