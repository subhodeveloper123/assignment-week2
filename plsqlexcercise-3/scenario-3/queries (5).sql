
-- create

CREATE TABLE Customers (
    CustomerID NUMBER(10) PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance NUMBER(10),
    LastModified DATE
);
CREATE TABLE Accounts (
    AccountID NUMBER(10) PRIMARY KEY,
    CustomerID NUMBER(10) ,
    AccountType VARCHAR2(20),
    Balance NUMBER(10),
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE Transactions (
    TransactionID NUMBER(10) PRIMARY KEY,
    AccountID NUMBER (10),
    TransactionDate DATE,
    Amount NUMBER,
    TransactionType VARCHAR2(10),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Loans (
    LoanID NUMBER(10) PRIMARY KEY,
    CustomerID NUMBER(10),
    LoanAmount NUMBER(10),
    InterestRate NUMBER(10),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID NUMBER(10) PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary NUMBER(10),
    Department VARCHAR2(50),
    HireDate DATE
); 

-- insert
INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (1, 'John Doe', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 1000, SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (2, 'Jane Smith', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 1500, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (1, 1, 'Savings', 1000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (2, 2, 'Checking', 1500, SYSDATE);

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (1, 1, SYSDATE, 200, 'Deposit');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (2, 2, SYSDATE, 300, 'Withdrawal');

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (1, 1, 5000, 5, SYSDATE, ADD_MONTHS(SYSDATE, 60));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', TO_DATE('2015-06-15', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', TO_DATE('2017-03-20', 'YYYY-MM-DD'));


-- fetch 
CREATE OR REPLACE PROCEDURE TransferFunds (
    p_source_account_id IN NUMBER,
    p_target_account_id IN NUMBER,
    p_amount            IN NUMBER
)
IS
    v_source_balance NUMBER;
BEGIN
    -- 1. Get source account balance
    SELECT Balance INTO v_source_balance
    FROM Accounts
    WHERE AccountID = p_source_account_id
    FOR UPDATE;

    -- 2. Check if sufficient funds are available
    IF v_source_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient balance in source account.');
    END IF;

    -- 3. Debit from source account
    UPDATE Accounts
    SET Balance = Balance - p_amount,
        LastModified = SYSDATE
    WHERE AccountID = p_source_account_id;

    -- 4. Credit to target account
    UPDATE Accounts
    SET Balance = Balance + p_amount,
        LastModified = SYSDATE
    WHERE AccountID = p_target_account_id;

    -- 5. Output confirmation
    DBMS_OUTPUT.PUT_LINE('₹' || p_amount || ' transferred from account ' ||
                         p_source_account_id || ' to account ' || p_target_account_id);

    COMMIT;
END;
/
SET SERVEROUTPUT ON;
EXEC TransferFunds(1, 2, 500);








