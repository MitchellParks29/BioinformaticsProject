library(affy)
library(GEOquery)
library(httr2)
cel_dir <- "C:/Users/bmpar/Downloads/GSE2034_RAW(1)"

raw_data <- ReadAffy(celfile.path = cel_dir)

length(sampleNames(raw_data))
normalized_data <- rma(raw_data)

expression_matrix <- exprs(normalized_data)
write.csv(
  expression_matrix,
  "GSE2034_normalized_expression.csv"
)

gse <- getGEO("GSE2034", GSEMatrix = TRUE)
gse_data <- gse[[1]]

metadata <- pData(gse_data)

dim(metadata)
colnames(metadata)
head(metadata)

metadata_df <- as.data.frame(metadata)

metadata_df$sample_id <- rownames(metadata_df)

write.csv(
  metadata_df,
  "GSE2034_metadata.csv",
  row.names = FALSE
)
