/*
    ********** Release 1.0.0 **********
*/
--changeset mikeo:ddl_create_table_customer labels:jira-1218,release-1.0.0
CREATE TABLE Sales.Customer (
    CustomerID int IDENTITY (1, 1) NOT NULL,
    PersonID int,
    StoreID int,
    TerritoryID int,
    AccountNumber varchar(10) NOT NULL,
    rowguid uniqueidentifier CONSTRAINT DF_Customer_rowguid DEFAULT newid() NOT NULL,
    ModifiedDate datetime CONSTRAINT DF_Customer_ModifiedDate DEFAULT GETDATE() NOT NULL,
    CONSTRAINT PK_Customer_CustomerID PRIMARY KEY (CustomerID));
--rollback DROP TABLE Sales.Customer;

/*
    ********** Release 1.0.1 **********
*/
--changeset mikeo:ddl_add_column_currencycode labels:jira-1342,release-1.0.1
ALTER TABLE Sales.Customer ADD CurrencyCode CHAR(3);
--rollback ALTER TABLE Sales.Customer DROP COLUMN CurrencyCode;

--changeset mikeo:dml_update_currencycode labels:jira-1357,release-1.0.1
UPDATE Sales.Customer SET ModifiedDate = GETDATE(), CurrencyCode = 'USD';
--rollback UPDATE Sales.Customer SET CurrencyCode = NULL WHERE BusinessUnitID BETWEEN 1 AND 5;
