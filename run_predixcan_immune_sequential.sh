#!/bin/bash
set -e

#source ~/.bashrc
#conda activate imlabtools

python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref CD14-positive_monocyte --cell_type immune

python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref CD16-negative_CD56-bright_natural_killer_cell_human --cell_type immune

python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref CD4-positive_alpha-beta_cytotoxic_T_cell --cell_type immune

python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref CD4-positive_alpha-beta_T_cell --cell_type immune

python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref CD8-positive_alpha-beta_T_cell --cell_type immune

python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref central_memory_CD4-positive_alpha-beta_T_cell --cell_type immune

python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref central_memory_CD8-positive_alpha-beta_T_cell --cell_type immune

python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref conventional_dendritic_cell --cell_type immune
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref dendritic_cell --cell_type immune
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref double_negative_thymocyte --cell_type immune
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref effector_memory_CD4-positive_alpha-beta_T_cell --cell_type immune
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref effector_memory_CD8-positive_alpha-beta_T_cell --cell_type immune
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref erythrocyte --cell_type immune
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref gamma-delta_T_cell --cell_type immune
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref hematopoietic_precursor_cell --cell_type immune
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref innate_lymphoid_cell --cell_type immune
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref memory_B_cell --cell_type immune
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref mucosal_invariant_T_cell --cell_type immune
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref naive_thymus-derived_CD4-positive_alpha-beta_T_cell --cell_type immune
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref naive_thymus-derived_CD8-positive_alpha-beta_T_cell --cell_type immune
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref natural_killer_cell --cell_type immune
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref peripheral_blood_mononuclear_cell --cell_type immune
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref plasmablast --cell_type immune
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref plasmacytoid_dendritic_cell --cell_type immune
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref platelet --cell_type immune
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref regulatory_T_cell --cell_type immune
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref transitional_stage_B_cell --cell_type immune
