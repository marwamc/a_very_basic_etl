### A very basic etl


### How to run:
In this project (peg_etl) directory, run the following commands:

    1)  make db
    2)  make etl
    3)  make analysis
    4)  make cleanup
   

### What is being solved
Given some raw business data in the form of: <br/>
1. Customers
2. Contracts
3. Products
4. Transactions

Produce a report of active or completed contracts, along with the information listed below.
1. ContractId As seen in the data provided
2. CustomerName The customer’s full name
3. ProductType As seen in the data provided
4. DateOfSale The date the customer pays the deposit
5 TotalOutstandingBalance The amount the customer has left to pay off
the loan
6. OutsandingBalanceToDate The amount the customer should have paid
by the current date.
7. ProjectedCompletionDate The date the customer will pay off the loan,
assuming they don’t miss any payments

A contract is considered active when the deposit has been paid, and is
considered completed when the entire loan amount has been paid off.
Assume that the current date is 8th Jan 2018. MySQL is recommended,
but not required.
The data is contained within the directory **raw_data** in the
form of CSV files.
