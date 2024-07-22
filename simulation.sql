-- Step 1
-- Create TestDB database
CREATE DATABASE Simulation;
GO

-- Use the new database
USE Simulation;
GO

-- Create a sample table
CREATE TABLE SampleTable (
    ID INT PRIMARY KEY,
    Name NVARCHAR(50)
);
GO

--Step 2

-- Insert initial data
INSERT INTO SampleTable (ID, Name)
VALUES (1, 'Alice'), (2, 'Bob');
GO

--Step 3
-- Full Backup
BACKUP DATABASE Simulation
TO DISK = 'B:\SQL\TestDB_Full.bak'
WITH FORMAT,
NAME = 'Full Backup of TestDB';
GO

--Step 4
-- Insert more data
INSERT INTO SampleTable (ID, Name)
VALUES (3, 'Charlie'), (4, 'David');
GO

--Step 5
-- Differential Backup
BACKUP DATABASE Simulation
TO DISK = 'B:\SQL\TestDB_Diff.bak'
WITH DIFFERENTIAL,
NAME = 'Differential Backup of TestDB';
GO

--Step 6
-- Insert even more data
INSERT INTO SampleTable (ID, Name)
VALUES (5, 'Eve'), (6, 'Frank');
GO

-- Step 7
-- Transaction Log Backup
BACKUP LOG Simulation
TO DISK = 'B:\SQL\TestDB_Log.trn'
WITH NAME = 'Transaction Log Backup of TestDB';
GO

-- Restore DB
-- Drop the TestDB database
USE master;
GO
ALTER DATABASE Simulation
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

USE master;
GO
DROP DATABASE Simulation;
GO



-- Full Backup
-- Restore Full Backup
RESTORE DATABASE Simulation
FROM DISK = 'B:\SQL\TestDB_Full.bak'
WITH NORECOVERY;
GO

--Restore Differential 
-- Restore Differential Backup
RESTORE DATABASE Simulation
FROM DISK = 'B:\SQL\TestDB_Diff.bak'
WITH NORECOVERY;
GO

--Restore Transaction Log
-- Restore Transaction Log Backup
RESTORE LOG Simulation
FROM DISK = 'B:\SQL\TestDB_Log.trn'
WITH RECOVERY;
GO

-- Verify the restore data
-- Use the restored database
USE Simulation;
GO

-- Select data to verify restoration
SELECT * FROM SampleTable;
GO
