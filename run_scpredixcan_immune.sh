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
  CD16-negative_CD56-bright_natural_killer_cell_human
  CD4-positive_alpha-beta_cytotoxic_T_cell
  CD4-positive_alpha-beta_T_cell
  CD8-positive_alpha-beta_T_cell
  central_memory_CD4-positive_alpha-beta_T_cell
  central_memory_CD8-positive_alpha-beta_T_cell
  conventional_dendritic_cell
  dendritic_cell
  double_negative_thymocyte
  effector_memory_CD4-positive_alpha-beta_T_cell
  effector_memory_CD8-positive_alpha-beta_T_cell
  erythrocyte
  gamma-delta_T_cell
  hematopoietic_precursor_cell
  innate_lymphoid_cell
  memory_B_cell
  mucosal_invariant_T_cell
  naive_thymus-derived_CD4-positive_alpha-beta_T_cell
  naive_thymus-derived_CD8-positive_alpha-beta_T_cell
  natural_killer_cell
  peripheral_blood_mononuclear_cell
  plasmablast
  plasmacytoid_dendritic_cell
  platelet
  regulatory_T_cell
  transitional_stage_B_cell
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
