-- =====================================
-- Q.3.1: CREATE USERS IN PDB (Fix for ORA-65096)
-- Run as SYS/SYSTEM AS SYSDBA in XEPDB1 Container
-- =====================================

-- Switch to the correct pluggable database (PDB)
ALTER SESSION SET CONTAINER = XEPDB1;

-- Verify the current container
SELECT SYS_CONTEXT('USERENV', 'CON_NAME') AS Current_Container FROM DUAL;

-- =====================================
-- Create User: John
-- =====================================
CREATE USER John IDENTIFIED BY Johnch2024
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON USERS;

-- Grant basic roles
GRANT CREATE SESSION TO John; -- minimum privilege to connect
GRANT RESOURCE TO John;       -- allows object creation

-- Grant specific privilege
GRANT SELECT ANY TABLE TO John;

-- =====================================
-- Create User: Hannah
-- =====================================
CREATE USER Hannah IDENTIFIED BY Hannahch2024
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON USERS;

-- Grant basic roles
GRANT CREATE SESSION TO Hannah;
GRANT RESOURCE TO Hannah;

-- Grant specific privilege
GRANT INSERT ANY TABLE TO Hannah;

-- =====================================
-- Verification queries
-- =====================================
-- List users to confirm creation
SELECT Username, Account_Status, Default_Tablespace
FROM DBA_USERS
WHERE Username IN ('JOHN', 'HANNAH')
ORDER BY Username;

-- Check system privileges
SELECT Grantee, Privilege
FROM DBA_SYS_PRIVS
WHERE Grantee IN ('JOHN','HANNAH')
ORDER BY Grantee, Privilege;

COMMIT;