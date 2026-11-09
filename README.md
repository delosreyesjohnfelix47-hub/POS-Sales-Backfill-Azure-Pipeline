# POS-Sales-Backfill-Azure-Pipeline
Ingesting On-Premises SQL Server 2023 to 2026 data using Azure Data Factory, Adls Gen2, Azure Databricks Unity Catalog with CI/CD

Azure Services Used:
| Tool | Purpose |
|------|---------|
| Azure Data Factory | Extracts data from SQL Server and tracks batch progress |
| ADLS Gen2 | Stores data for each Medallion layer (Raw - Parquet, Bronze - Delta, Silver - Delta, Gold - Delta) |
| Azure Databricks | Transforms data through the Medallion layers |
| Azure Databricks Access Connector | Allows Databricks to securely access ADLS Gen2 |
| Unity Catalog | Governs external Delta tables stored in ADLS Gen2 |
| Azure Key Vault | Manages secrets securely |
| Azure SQL Database | Stores the watermark table to track backfill status |
| Azure DevOps | Manages CI/CD deployment to DEV and QA environments |



Source SQL Server On-Prem:

Schema:
sales

Tables:
dtl_order,
dtl_payment,
hdr_invoice

Azure SQL Water Mark Table:


| Schema_Name | Table_Name | Year_Batch | Month_Batch | Row_Count | Raw_Status |
|-------------|------------|------------|------------|-----------|------------|
| sales | dtl_order | 2024 | 02 | 692 | Success |
| sales | dtl_payment | 2024 | 02 | 319 | Success |
| sales | hdr_invoice | 2024 | 02 | 134 | Success |

Azure Key Vault:

Secret: On-prem SqlServer password

Azure Data Factory Process:
1. Look Up Activity Azure Sql Watermark Table to get tables that are still pending for specific year month.
2. For Each Activity loops through the 3 tables in parallel (dtl_order, dtl_payment, hdr_invoice)
3. Look Up Activity to check how many row does the on-prem table have.
4. If Condition Activity. Check look up activity of on-prem table if have rows.
  - if true
      run watermark stored procedure to make Raw_status as Processing
      Copy Data Activity to ingest on-prem sql server data to raw container as parquet.
      run watermark stored procedure to Raw_status as Success or Failed if there are errors.
  - if false
      run watermark stored procedure to make Raw_status as No Data.
5. If condition Activity. Check look up activity of Azure Sql Watermark if have rows.
  - if true
      run Job Activity Azure Databricks Job.
  - if false
      do nothing.

Azure Data Lake Storage Gen2: Landing zone for raw parquet files, with container of config, bronze, silver and gold.
Adls Gen 2 Structure:

Raw:

├──sales/dtl_order/year=2023/month=01/dtl_order_2025_01.parquet

├──sales/dtl_payment/year=2023/month=01/dtl_payment_2025_01.parquet

└──sales/hdr_invoice/year=2023/month=01/hdr_invoice_2025_01.parquet

Bronze:

├──sales/dtl_order/year=2023/month=01/day=01/.parquet

├──sales/dtl_payment/year=2023/month=01/day=01/.parquet

└──sales/hdr_invoice/year=2023/month=01/day=01/.parquet

Silver:

├──sales/dtl_order/year=2023/month=01/day=01/.parquet

├──sales/dtl_payment/year=2023/month=01/day=01/.parquet

└──sales/hdr_invoice/year=2023/month=01/day=01/.parquet

Gold:

├──sales/dim_date/.parquet

├──sales/dim_orderstatus/.parquet

├──sales/dim_item/.parquet

├──sales/dim_ordertransactiontype/.parquet

├──sales/fact_order/year=2023/month=01/day=01.parquet

├──sales/dim_tender/.parquet

├──sales/dim_paymentstatus/.parquet

├──sales/fact_payment//year=2023/month=01/day=01.parquet

├──sales/dim_invoicestatus/.parquet

├──sales/dim_invoicetransactiontype/.parquet

└──sales/fact_invoice//year=2023/month=01/day=01.parquet


Azure Databricks Structure:
Catalog:
- Unity catalog
- Schema bronze, silver and gold
- Tables are external tables
   
Notebooks:
- Create Unity Catalog: Create Storage Credential, External Location, Create Catalog, Create Schema and Grant Permissions(external location, Catalog and Schemas)
- Raw To Bronze: Process Raw container parquets into bronze delta
- Bronze To Silver: Process bronze delta then clean and transform it to silver delta
- Silver To Gold: Process silver delta to create dimension and fact tables for gold
  
Job (Possales_Backfill_Job):
  Create Unity Catalog > Raw To Bronze > Bronze To Silver > Silver To Gold

Azure Devops CI/CD:

Created Service Connection:
<img width="1074" height="302" alt="image" src="https://github.com/user-attachments/assets/eb90db3a-de9c-49e4-8418-e888d71a36d8" />

Created approval when deploy to QA:
<img width="1070" height="351" alt="image" src="https://github.com/user-attachments/assets/3c53b4c2-1fc4-4863-86b8-8e4362e06dce" />

Created Variable Group:
<img width="1067" height="435" alt="image" src="https://github.com/user-attachments/assets/aa954bf0-f3bb-4b3b-8696-435fb1974339" />


Devops Pipeline Azure Data Factory:

ADF QA Approval:
<img width="1061" height="743" alt="image" src="https://github.com/user-attachments/assets/35b71614-4c87-4a1f-9a8c-7089517ccba9" />
ADF Successful Deploy to QA:
<img width="1075" height="744" alt="image" src="https://github.com/user-attachments/assets/6efad5a6-4877-4042-9876-bfc4973d1237" />

Devops Pipeline Azure Databricks:

Azure Databricks QA Approval:
<img width="1073" height="743" alt="image" src="https://github.com/user-attachments/assets/7beef40d-5854-46a0-a598-fd2ee1d97ac9" />
Azure Databricks  Successful Deploy to QA:
<img width="1072" height="744" alt="image" src="https://github.com/user-attachments/assets/cac830f4-0aca-4ae1-9051-07cdda7f98c8" />
