#!/bin/bash
set -e

# Load environment
source ~/.bashrc
conda activate imlabtools

# Acinar (wrapper)
bash ~/aou_sc_predixcan/00wrapper.sh --phecode 172 --pop META --ref Acinar --cell_type islet
echo "Finished Acinar"

python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref Activated_stellate --cell_type islet
echo "Finished Activated_stellate"

python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref Alpha --cell_type islet
echo "Finished Alpha"

python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref Beta --cell_type islet
echo "Finished Beta"

python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref Delta --cell_type islet
echo "Finished Delta"

python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref Ductal --cell_type islet
echo "Finished Ductal"

python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref Endothelial --cell_type islet
echo "Finished Endothelial"

python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref Epsilon --cell_type islet
echo "Finished Epsilon"

python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref Gamma --cell_type islet
echo "Finished Gamma"

python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref Immune --cell_type islet
echo "Finished Immune"

python ~/aou_sc_predixcan/03run_predixcan.py --phecode 172 --pop META --ref Quiescent_stellate --cell_type islet
echo "Finished Quiescent_stellate"

echo "Finished ALL islet PrediXcan runs"
