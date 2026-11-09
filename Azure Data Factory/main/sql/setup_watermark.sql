
-- CREATE TABLE
/****** Object:  Table [dbo].<WatermarkTableName>    Script Date: 10/26/2026 06:45:26 PM ******/

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

-- 1. Create the table only if it does not exist
IF OBJECT_ID(N'dbo.<WatermarkTableName>', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.<WatermarkTableName>
    (
        Schema_Name VARCHAR(50) NULL,
        Table_Name  VARCHAR(50) NULL,
        Year_Batch  VARCHAR(50) NULL,
        Month_Batch VARCHAR(2)  NULL,
        Row_Count   INT         NULL,
        Raw_Status  VARCHAR(50) NULL
    );
END;
GO

--Create Stored_Proc
/****** Object:  StoredProcedure [dbo].<StoredProc>    Script Date: 11/04/2026 05:04:34 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.<StoredProc>', 'P') IS NULL
BEGIN
    EXEC('
        CREATE PROCEDURE [dbo].<StoredProc>
          @sp_param_schema_name varchar(50),
          @sp_param_table_name varchar(50),
          @sp_param_year varchar(50),
          @sp_param_month varchar(2),
          @sp_param_status varchar(50),
          @sp_param_row_count int
        AS
        BEGIN
            UPDATE dbo.<WatermarkTableName>
            SET 
                Raw_Status = @sp_param_status,
                Row_Count = @sp_param_row_count
            WHERE
                Schema_Name = @sp_param_schema_name
                AND Table_Name = @sp_param_table_name
                AND Year_Batch = @sp_param_year
                AND Month_Batch = @sp_param_month;
        END;
    ');
END;
GO


--DELETE BACKFILL Database
DELETE FROM [dbo].<WatermarkTableName>;
GO

-- INSERT BACKFILL Database

INSERT INTO [dbo].<WatermarkTableName>
    ([Schema_Name], [Table_Name], [Year_Batch], [Month_Batch], [Row_Count], [Raw_Status])
VALUES
('sales', 'dtl_order',    '2023', '01', 0, 'Pending'),
('sales', 'dtl_payment',  '2023', '01', 0, 'Pending'),
('sales', 'hdr_invoice',  '2023', '01', 0, 'Pending'),
('sales', 'dtl_order',    '2023', '02', 0, 'Pending'),
('sales', 'dtl_payment',  '2023', '02', 0, 'Pending'),
('sales', 'hdr_invoice',  '2023', '02', 0, 'Pending'),
('sales', 'dtl_order',    '2023', '03', 0, 'Pending'),
('sales', 'dtl_payment',  '2023', '03', 0, 'Pending'),
('sales', 'hdr_invoice',  '2023', '03', 0, 'Pending'),
('sales', 'dtl_order',    '2023', '04', 0, 'Pending'),
('sales', 'dtl_payment',  '2023', '04', 0, 'Pending'),
('sales', 'hdr_invoice',  '2023', '04', 0, 'Pending'),
('sales', 'dtl_order',    '2023', '05', 0, 'Pending'),
('sales', 'dtl_payment',  '2023', '05', 0, 'Pending'),
('sales', 'hdr_invoice',  '2023', '05', 0, 'Pending'),
('sales', 'dtl_order',    '2023', '06', 0, 'Pending'),
('sales', 'dtl_payment',  '2023', '06', 0, 'Pending'),
('sales', 'hdr_invoice',  '2023', '06', 0, 'Pending'),
('sales', 'dtl_order',    '2023', '07', 0, 'Pending'),
('sales', 'dtl_payment',  '2023', '07', 0, 'Pending'),
('sales', 'hdr_invoice',  '2023', '07', 0, 'Pending'),
('sales', 'dtl_order',    '2023', '08', 0, 'Pending'),
('sales', 'dtl_payment',  '2023', '08', 0, 'Pending'),
('sales', 'hdr_invoice',  '2023', '08', 0, 'Pending'),
('sales', 'dtl_order',    '2023', '09', 0, 'Pending'),
('sales', 'dtl_payment',  '2023', '09', 0, 'Pending'),
('sales', 'hdr_invoice',  '2023', '09', 0, 'Pending'),
('sales', 'dtl_order',    '2023', '10', 0, 'Pending'),
('sales', 'dtl_payment',  '2023', '10', 0, 'Pending'),
('sales', 'hdr_invoice',  '2023', '10', 0, 'Pending'),
('sales', 'dtl_order',    '2023', '11', 0, 'Pending'),
('sales', 'dtl_payment',  '2023', '11', 0, 'Pending'),
('sales', 'hdr_invoice',  '2023', '11', 0, 'Pending'),
('sales', 'dtl_order',    '2023', '12', 0, 'Pending'),
('sales', 'dtl_payment',  '2023', '12', 0, 'Pending'),
('sales', 'hdr_invoice',  '2023', '12', 0, 'Pending'),
('sales', 'dtl_order',    '2024', '01', 0, 'Pending'),
('sales', 'dtl_payment',  '2024', '01', 0, 'Pending'),
('sales', 'hdr_invoice',  '2024', '01', 0, 'Pending'),
('sales', 'dtl_order',    '2024', '02', 0, 'Pending'),
('sales', 'dtl_payment',  '2024', '02', 0, 'Pending'),
('sales', 'hdr_invoice',  '2024', '02', 0, 'Pending'),
('sales', 'dtl_order',    '2024', '03', 0, 'Pending'),
('sales', 'dtl_payment',  '2024', '03', 0, 'Pending'),
('sales', 'hdr_invoice',  '2024', '03', 0, 'Pending'),
('sales', 'dtl_order',    '2024', '04', 0, 'Pending'),
('sales', 'dtl_payment',  '2024', '04', 0, 'Pending'),
('sales', 'hdr_invoice',  '2024', '04', 0, 'Pending'),
('sales', 'dtl_order',    '2024', '05', 0, 'Pending'),
('sales', 'dtl_payment',  '2024', '05', 0, 'Pending'),
('sales', 'hdr_invoice',  '2024', '05', 0, 'Pending'),
('sales', 'dtl_order',    '2024', '06', 0, 'Pending'),
('sales', 'dtl_payment',  '2024', '06', 0, 'Pending'),
('sales', 'hdr_invoice',  '2024', '06', 0, 'Pending'),
('sales', 'dtl_order',    '2024', '07', 0, 'Pending'),
('sales', 'dtl_payment',  '2024', '07', 0, 'Pending'),
('sales', 'hdr_invoice',  '2024', '07', 0, 'Pending'),
('sales', 'dtl_order',    '2024', '08', 0, 'Pending'),
('sales', 'dtl_payment',  '2024', '08', 0, 'Pending'),
('sales', 'hdr_invoice',  '2024', '08', 0, 'Pending'),
('sales', 'dtl_order',    '2024', '09', 0, 'Pending'),
('sales', 'dtl_payment',  '2024', '09', 0, 'Pending'),
('sales', 'hdr_invoice',  '2024', '09', 0, 'Pending'),
('sales', 'dtl_order',    '2024', '10', 0, 'Pending'),
('sales', 'dtl_payment',  '2024', '10', 0, 'Pending'),
('sales', 'hdr_invoice',  '2024', '10', 0, 'Pending'),
('sales', 'dtl_order',    '2024', '11', 0, 'Pending'),
('sales', 'dtl_payment',  '2024', '11', 0, 'Pending'),
('sales', 'hdr_invoice',  '2024', '11', 0, 'Pending'),
('sales', 'dtl_order',    '2024', '12', 0, 'Pending'),
('sales', 'dtl_payment',  '2024', '12', 0, 'Pending'),
('sales', 'hdr_invoice',  '2024', '12', 0, 'Pending'),
('sales', 'dtl_order',    '2025', '01', 0, 'Pending'),
('sales', 'dtl_payment',  '2025', '01', 0, 'Pending'),
('sales', 'hdr_invoice',  '2025', '01', 0, 'Pending'),
('sales', 'dtl_order',    '2025', '02', 0, 'Pending'),
('sales', 'dtl_payment',  '2025', '02', 0, 'Pending'),
('sales', 'hdr_invoice',  '2025', '02', 0, 'Pending'),
('sales', 'dtl_order',    '2025', '03', 0, 'Pending'),
('sales', 'dtl_payment',  '2025', '03', 0, 'Pending'),
('sales', 'hdr_invoice',  '2025', '03', 0, 'Pending'),
('sales', 'dtl_order',    '2025', '04', 0, 'Pending'),
('sales', 'dtl_payment',  '2025', '04', 0, 'Pending'),
('sales', 'hdr_invoice',  '2025', '04', 0, 'Pending'),
('sales', 'dtl_order',    '2025', '05', 0, 'Pending'),
('sales', 'dtl_payment',  '2025', '05', 0, 'Pending'),
('sales', 'hdr_invoice',  '2025', '05', 0, 'Pending'),
('sales', 'dtl_order',    '2025', '06', 0, 'Pending'),
('sales', 'dtl_payment',  '2025', '06', 0, 'Pending'),
('sales', 'hdr_invoice',  '2025', '06', 0, 'Pending'),
('sales', 'dtl_order',    '2025', '07', 0, 'Pending'),
('sales', 'dtl_payment',  '2025', '07', 0, 'Pending'),
('sales', 'hdr_invoice',  '2025', '07', 0, 'Pending'),
('sales', 'dtl_order',    '2025', '08', 0, 'Pending'),
('sales', 'dtl_payment',  '2025', '08', 0, 'Pending'),
('sales', 'hdr_invoice',  '2025', '08', 0, 'Pending'),
('sales', 'dtl_order',    '2025', '09', 0, 'Pending'),
('sales', 'dtl_payment',  '2025', '09', 0, 'Pending'),
('sales', 'hdr_invoice',  '2025', '09', 0, 'Pending'),
('sales', 'dtl_order',    '2025', '10', 0, 'Pending'),
('sales', 'dtl_payment',  '2025', '10', 0, 'Pending'),
('sales', 'hdr_invoice',  '2025', '10', 0, 'Pending'),
('sales', 'dtl_order',    '2025', '11', 0, 'Pending'),
('sales', 'dtl_payment',  '2025', '11', 0, 'Pending'),
('sales', 'hdr_invoice',  '2025', '11', 0, 'Pending'),
('sales', 'dtl_order',    '2025', '12', 0, 'Pending'),
('sales', 'dtl_payment',  '2025', '12', 0, 'Pending'),
('sales', 'hdr_invoice',  '2025', '12', 0, 'Pending');
