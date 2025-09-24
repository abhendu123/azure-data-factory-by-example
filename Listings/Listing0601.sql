ALTER PROCEDURE [dbo].[LogPipelineEnd] (
  @RunSeqNo INT
, @RunEndDateTime DATETIME
, @RunStatus VARCHAR(20)
, @FilesRead INT
, @RowsRead INT
, @RowsCopied INT
) AS

UPDATE dbo.PipelineExecution
SET RunEndDateTime = @RunEndDateTime
  , RunStatus = @RunStatus
  , FilesRead = @FilesRead
  , RowsRead = @RowsRead
  , RowsCopied = @RowsCopied
WHERE RunSeqNo = @RunSeqNo;

IF EXISTS (
  SELECT * FROM dbo.Sales_LOAD
  WHERE [Product] IS NULL
) 
RAISERROR('Unexpected NULL in dbo.Sales_LOAD.[Product]', 11, 1)  ;


--IF EXISTS (SELECT * FROM dbo.Sales_LOAD WHERE CustomerID IS NULL)
--    RAISERROR('Unexpected NULL in [CustomerID]', 11, 1);

--IF EXISTS (SELECT * FROM dbo.Sales_LOAD WHERE OrderDate IS NULL)
--    RAISERROR('Unexpected NULL in [OrderDate]', 11, 1);



--Dynamic SQL to check all columns

--DECLARE @sql NVARCHAR(MAX) = N'';

--SELECT @sql = @sql + 
--    'IF EXISTS (SELECT 1 FROM dbo.Sales_LOAD WHERE [' + c.name + '] IS NULL)
--        RAISERROR(''Unexpected NULL in dbo.Sales_LOAD.[' + c.name + ']'', 11, 1);
--    ' + CHAR(13)
--FROM sys.columns c
--WHERE c.object_id = OBJECT_ID('dbo.Sales_LOAD')
--  AND c.is_nullable = 0; -- only check NOT NULL columns (optional)

--EXEC sp_executesql @sql;
