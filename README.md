# To Run run_predixcan_islet_sequential.sh
This scripts runs Sc-PrediXcan on islet cell types for Skin Cancer (Phecode:172) on AoS.

Installing pipeline in All of Us:
`git clone https://github.com/Toobarizwan/Sc_PrediXcan_172`
 
````
chmod +x ~/Sc_PrediXcan_172/run_predixcan_islet_sequential.sh
````

````
. ~/Sc_PrediXcan_172/run_predixcan_islet_sequential.sh
````

#### Monitor:
````tail -f islet_run.log````

------------------------------------------------------------------------------------------------------


# Creating Gene × Cell Type Matrix from Sc-PrediXcan Results for ACAT

This script generates a gene-by-cell type p-value matrix from Sc-PrediXcan output files across immune cell types.
The resulting matrix can be used as input for downstream gene-level aggregation methods such as ACAT to distinguish between cell-type-specific and cell-type-enriched associations.

### Input

The input to this pipeline consists of Sc-PrediXcan result .csv files for each immune cell type.
Each file must contain the following columns:
gene (Ensembl ID), gene_name and pvalue

Each file should follow the naming format:
`META_predixcan_output_172_immune_cell_<cell_type>.csv`

## Step 1: Define Immune Cell Types
cell_types <- c(
  "CD14-low_CD16-positive_monocyte",
  "CD14-positive_monocyte",
  "CD16-negative_CD56-bright_natural_killer_cell_human",
  "CD4-positive_alpha-beta_cytotoxic_T_cell",
  "CD4-positive_alpha-beta_T_cell",
  "CD8-positive_alpha-beta_T_cell",
  "central_memory_CD4-positive_alpha-beta_T_cell",
  "central_memory_CD8-positive_alpha-beta_T_cell",
  "conventional_dendritic_cell",
  "dendritic_cell",
  "double_negative_thymocyte",
  "effector_memory_CD4-positive_alpha-beta_T_cell",
  "effector_memory_CD8-positive_alpha-beta_T_cell",
  "erythrocyte",
  "gamma-delta_T_cell",
  "hematopoietic_precursor_cell",
  "innate_lymphoid_cell",
  "memory_B_cell",
  "mucosal_invariant_T_cell",
  "naive_thymus-derived_CD4-positive_alpha-beta_T_cell",
  "naive_thymus-derived_CD8-positive_alpha-beta_T_cell",
  "natural_killer_cell",
  "peripheral_blood_mononuclear_cell",
  "plasmablast",
  "plasmacytoid_dendritic_cell",
  "platelet",
  "regulatory_T_cell",
  "transitional_stage_B_cell"
)

## Step 2: Read and Extract Required Columns
``
cell_list <- list()

for(cell in cell_types){
  
  file_name <- paste0("META_predixcan_output_172_immune_cell_", cell, ".csv")
  
  temp <- read.csv(file_name)
  
  temp_small <- temp[, c("gene", "gene_name", "pvalue")]
  
  colnames(temp_small)[3] <- cell
  
  cell_list[[cell]] <- temp_small
}
``

Each dataframe now contains:

'| gene | gene_name | cell_type_pvalue |'

## Step 3: Merge All Cell Type Dataframes

Since genes may appear in different orders (or be missing) across cell types, we perform a full outer join across all dataframes using both gene and gene_name as identifiers.
``
merged_matrix <- cell_list[[1]]

for(i in 2:length(cell_list)) {
  
  merged_matrix <- merge(merged_matrix,
                         cell_list[[i]],
                         by = c("gene", "gene_name"),
                         all = TRUE)
}
``

This creates a matrix where:
- Rows represent genes
- Columns represent immune cell types
- Entries represent Sc-PrediXcan p-values

Missing values (NA) indicate genes not present in that cell type model.

## Step 4: Export Matrix
``
write.csv(merged_matrix,
          "Immune_ACAT_matrix.csv",
          row.names = FALSE)
``
