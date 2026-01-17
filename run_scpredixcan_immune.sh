#!/bin/bash
set -e

# Activate environment
source ~/.bashrc
conda activate imlabtools

# Common parameters
PHECODE=172
POP=META
CELL_TYPE=immune

# Immune cell references (OneK1K dataset)
IMMUNE_REFS=(
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

# Run SPrediXcan for each immune cell type
for REF in "${IMMUNE_REFS[@]}"; do
  echo "=============================="
  echo "Running immune cell: $REF"
  echo "=============================="

  python ~/aou_sc_predixcan/03run_predixcan.py \
    --phecode ${PHECODE} \
    --pop ${POP} \
    --ref ${REF} \
    --cell_type ${CELL_TYPE}

  echo "Finished ${REF}"
done

echo "All immune cell PrediXcan runs completed."

