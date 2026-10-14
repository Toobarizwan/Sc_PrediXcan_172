#copying file from computer to labserver 
#scp C:\Users\PMLS\Downloads/GCST90479798.h.tsv.gz.tbi tooba@10.22.9.205:/home/tooba/aou_sc_predixcan/
  
# retrieve sum stats from GWAS catalog
wget https://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/GCST90479001-GCST90480000/GCST90479798/harmonised/GCST90479798.h.tsv.gz

ls -lh GCST90479798.h.tsv.gz

# upzip sum stats file
gunzip GCST90479798.h.tsv.gz

head GCST90479798.h.tsv
tail GCST90479798.h.tsv
ls -lh GCST90479798.h.tsv


SPrediXcan.py -h
conda activate imlabtools

#Clone the S-PrediXcan repository and go to the software folder.
git clone https://github.com/hakyimlab/MetaXcan
cd MetaXcan/software

#python /home/tooba/MetaXcan/software/SPrediXcan.py --model_db_path /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_immune_cell_types_from_OneK1K_dataset/CD14-low_CD16-positive_monocyte.db --gwas_file /home/tooba/GCST90479798.h.tsv --gwas_N 635969 --snp_column rsid --effect_allele_column effect_allele --non_effect_allele_column other_allele --or_column odds_ratio --pvalue_column p_value --output_file GCST90479798_predixcan_output_172_immune_CD14-low_CD16-positive_monocyte.demo1.csv 

python /home/tooba/MetaXcan/software/SPrediXcan.py --model_db_path /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_immune_cell_types_from_OneK1K_dataset/CD14-low_CD16-positive_monocyte.db --gwas_file /home/tooba/hg38_SPx_format_GCST90479798.h.tsv --snp_column variant_id --or_column odds_ratio --pvalue_column p_value --output_file GCST90479798_predixcan_output_172_immune_CD14-low_CD16-positive_monocyte.democ.csv 


#Checking how many columns Python sees
head -n 1 /home/tooba/GCST90479798.h.tsv | tr '\t' '\n' | nl

#Checking first few rsids
head -5 /home/tooba/GCST90479798.h.tsv | cut -f9

#python /home/tooba/MetaXcan/software/SPrediXcan.py --model_db_path /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_immune_cell_types_from_OneK1K_dataset/CD14-low_CD16-positive_monocyte.db --gwas_file /home/tooba/GCST90479798.h.tsv --gwas_N 635969 --snp_column rsid --effect_allele_column effect_allele --non_effect_allele_column other_allele --or_column odds_ratio --pvalue_column p_value --output_file /home/tooba/GCST90479798_predixcan_output_172_immune_CD14-low_CD16-positive_monocyte.demo1.csv

# to check for covariance file
ls /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_immune_cell_types_from_OneK1K_dataset/
  
#correct command
python /home/tooba/MetaXcan/software/SPrediXcan.py --model_db_path /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_immune_cell_types_from_OneK1K_dataset/CD14-low_CD16-positive_monocyte.db --covariance /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_immune_cell_types_from_OneK1K_dataset/CD14-low_CD16-positive_monocyte_covariances.txt.gz --gwas_file /home/tooba/GCST90479798.h.tsv --gwas_N 635969 --snp_column rsid --effect_allele_column effect_allele --non_effect_allele_column other_allele --or_column odds_ratio --pvalue_column p_value --output_file /home/tooba/GCST90479798_predixcan_output_172_immune_CD14-low_CD16-positive_monocyte.demoa.csv

#Checking model’s SNP ID format
sqlite3 /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_immune_cell_types_from_OneK1K_dataset/CD14-low_CD16-positive_monocyte.db "SELECT rsid FROM snps LIMIT 5;"

#checking what tables are inside .db file
sqlite3 /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_immune_cell_types_from_OneK1K_dataset/CD14-low_CD16-positive_monocyte.db ".tables"
#construction  extra sample_info   weights  ---- tables found


#checking columns of the weights table
sqlite3 /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_immune_cell_types_from_OneK1K_dataset/CD14-low_CD16-positive_monocyte.db "PRAGMA table_info(weights);"

#there might be format mismatch between rsids from gwas file and db file.
#Checking example IDs from the model
sqlite3 /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_immune_cell_types_from_OneK1K_dataset/CD14-low_CD16-positive_monocyte.db "SELECT rsid, varID FROM weights LIMIT 5;"

#Converting GWAS rsIDs to varID format - chr_pos_ref_alt_b38
awk 'NR==1{print $0"\tvarID"; next} 
     {print $0"\tchr"$1"_"$2"_"$4"_"$3"_b38"}' /home/tooba/GCST90479798.h.tsv > /home/tooba/GCST90479798_formatted.tsv

awk 'NR==1{print $0"\tvarID"; next} {print $0"\tchr"$1"_"$2"_"$3"_"$4"_b38"}' OFS='\t' /home/tooba/GCST90479798.h.tsv > /home/tooba/GCST90479798_formatted2.tsv

awk -F'\t' 'NR==1 {print; next} {
  new_id = "chr"$1"_"$2"_"$3"_"$4"_b38";
  for (i=1; i<NF; i++) printf "%s\t", $i;
  print new_id;
}' GCST90479798.h.tsv > GCST90479798_formatted4.tsv


head GCST90479798_formatted4.tsv

#new command
python /home/tooba/MetaXcan/software/SPrediXcan.py --model_db_path /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_immune_cell_types_from_OneK1K_dataset/CD14-low_CD16-positive_monocyte.db --covariance /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_immune_cell_types_from_OneK1K_dataset/CD14-low_CD16-positive_monocyte_covariances.txt.gz --gwas_file /home/tooba/GCST90479798_b38fixed.tsv --gwas_N 635969  --snp_column variant_id --chromosome_column chromosome --position_column base_pair_location --effect_allele_column effect_allele --non_effect_allele_column other_allele --or_column odds_ratio --pvalue_column p_value --output_file /home/tooba/GCST90479798_predixcan_output_172_immune_CD14-low_CD16-positive_monocyte.demo9.csv

#adding prefix and suffix to variant_id
awk 'BEGIN{FS=OFS="\t"} 
NR==1{print $0} 
NR>1{$NF="chr"$1"_"$2"_"$4"_"$3"_b38"; print $0}' GCST90479798.h.tsv > GCST90479798_b38.tsv

sqlite3 /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_immune_cell_types_from_OneK1K_dataset/CD14-low_CD16-positive_monocyte.db ".schema weights"


# fixing sumstats - flipping alleles
awk 'NR==1 {print $0; next} {print $0 "\tchr"$1"_"$2"_"$4"_"$3"_b38"}' GCST90479798.h.tsv > GCST90479798_b38fixed.tsv


python /home/tooba/MetaXcan/software/SPrediXcan.py --model_db_path /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_immune_cell_types_from_OneK1K_dataset/CD14-low_CD16-positive_monocyte.db --covariance /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_immune_cell_types_from_OneK1K_dataset/CD14-low_CD16-positive_monocyte_covariances.txt.gz --gwas_file /home/tooba/GCST90479798_b38fixed.tsv --gwas_N 635969  --snp_column variant_id --chromosome_column chromosome --position_column base_pair_location --effect_allele_column other_allele --non_effect_allele_column effect_allele --or_column odds_ratio --pvalue_column p_value --output_file /home/tooba/GCST90479798_predixcan_output_172_immune_CD14-low_CD16-positive_monocyte.demo10.csv

#running after Dr. Wheelers harmonization script
python /home/tooba/MetaXcan/software/SPrediXcan.py \
--model_db_path /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_immune_cell_types_from_OneK1K_dataset/CD14-low_CD16-positive_monocyte.db \
--covariance /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_immune_cell_types_from_OneK1K_dataset/CD14-low_CD16-positive_monocyte_covariances.txt.gz \
--gwas_file /home/tooba/hg38_SPx_format_GCST90479798.h.tsv \
--gwas_h2 0.5 \
--gwas_N 635969 \
--snp_column panel_variant_id \
--chromosome_column chromosome \
--or_column odds_ratio \
--effect_allele_column effect_allele \
--non_effect_allele_column non_effect_allele \
--pvalue_column pvalue \
--beta_column effect_size \
--keep_non_rsid \
--model_db_snp_key varID \
--output_file GCST90479798_scpredixcan_immune_CD14-low_CD16-positive_monocyte.demo13.csv

#created nano run_all_predixcan.sh 

#Making it executable
chmod +x run_all_sc_predixcan_immune.sh
chmod +x run_all_sc_predixcan_islet.sh

#this save all messages and errors in the log.txt file
nohup bash run_all_sc_predixcan_immune.sh > immune_batch2_log.txt 2>&1 &
nohup bash run_all_sc_predixcan_islet.sh > islet_batch2_log.txt 2>&1 & 

# single command - immune 
  
python /home/tooba/MetaXcan/software/SPrediXcan.py \
--model_db_path /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_immune_cell_types_from_OneK1K_dataset/CD14-low_CD16-positive_monocyte.db \
--covariance /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_immune_cell_types_from_OneK1K_dataset/CD14-low_CD16-positive_monocyte_covariances.txt.gz \
--gwas_file /home/tooba/hg38_SPx_format_GCST90479798.h.tsv \
--gwas_h2 0.5 \
--gwas_N 635969 \
--snp_column panel_variant_id \
--chromosome_column chromosome \
--or_column odds_ratio \
--effect_allele_column effect_allele \
--non_effect_allele_column non_effect_allele \
--pvalue_column pvalue \
--beta_column effect_size \
--keep_non_rsid \
--model_db_snp_key varID \
--output_file GCST90479798_scpredixcan_immune_CD14-low_CD16-positive_monocyte.demo14.csv

# single command - islet

nohup python /home/tooba/MetaXcan/software/SPrediXcan.py \
--model_db_path /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_islet_cell_types_from_T2D_dataset/Acinar.db \
--covariance /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_islet_cell_types_from_T2D_dataset/Acinar_covariances.txt.gz \
--gwas_file /home/tooba/hg38_SPx_format_GCST90479798.h.tsv \
--gwas_N 635969 \
--snp_column panel_variant_id \
--chromosome_column chromosome \
--or_column odds_ratio \
--effect_allele_column effect_allele \
--non_effect_allele_column non_effect_allele \
--pvalue_column pvalue \
--beta_column effect_size \
--keep_non_rsid \
--model_db_snp_key varID \
--output_file GCST90479798_scpredixcan_h2_islet_Acinar.csv &
  
nohup python /home/tooba/MetaXcan/software/SPrediXcan.py \
--model_db_path /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_islet_cell_types_from_T2D_dataset/Activated_stellate.db \
--covariance /home/wheelerlab3/Data/predictdb_models/scPrediXcan_models/l-ctPred_models_for_islet_cell_types_from_T2D_dataset/Activated_stellate_covariances.txt.gz \
--gwas_file /home/tooba/hg38_SPx_format_GCST90479798.h.tsv \
--gwas_N 635969 \
--snp_column panel_variant_id \
--chromosome_column chromosome \
--or_column odds_ratio \
--effect_allele_column effect_allele \
--non_effect_allele_column non_effect_allele \
--pvalue_column pvalue \
--beta_column effect_size \
--keep_non_rsid \
--model_db_snp_key varID \
--output_file GCST90479798_scpredixcan_islet_Activated_stellate.csv
  
  
