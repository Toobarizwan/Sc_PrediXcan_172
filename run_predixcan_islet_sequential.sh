#!/bin/bash
set -e

# Load environment
source ~/.bashrc
conda activate imlabtools

# Acinar uses wrapper
bash ~/aou_sc_predixcan/00wrapper.sh --phecode 172 --pop META --ref Acinar --cell_type islet

# Remaining islet cell types
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref Activated_stellate --cell_type islet
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref Alpha --cell_type islet
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref Beta --cell_type islet
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref Delta --cell_type islet
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref Ductal --cell_type islet
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref Endothelial --cell_type islet
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref Epsilon --cell_type islet
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref Gamma --cell_type islet
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref Immune --cell_type islet
python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref Quiescent_stellate --cell_type islet
