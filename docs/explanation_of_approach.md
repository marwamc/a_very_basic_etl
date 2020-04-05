
## Intro
It is possible to construct the desired CONTRACT STATUS report in at most 1 or 2 complex queries. 
Herein, a slightly different approach is presented:

### Create a contract_status table
The goal is to have a contract status table that can be used to identify active or 
completed contracts as follows:
```dbn-sql
SELECT * FROM finance.contract_status where status = 'ACTIVE'
SELECT * FROM finance.contract_status where status = 'COMPLETED'
```

We identified the following main component CTEs that are required in order to construct the  <br/>
**contract_status** table; and pulled them into standalone intermediate tables:

    i. CONTRACT START DATE (primary key contract_id)
    ii. CONTRACT DEPOSIT SUMMARY (primary key contract_id)
    iii. CONTRACT PAYMENT SUMMARY (primary key contract_id)
    iv. CONTRACT PROJECTION (primary key contract_id)

Finally constructing the CONTRACT STATUS table is straight-forward. The only complexity is 
on the 4 JOINS but all 4 intermediate tables are sorted and partitioned by contract_id, 
so each of these is a relatively low cost join.

### Intermediate tables
The final finance.contract_status table is easily constructed when the following 4 
intermediate tables exist:
```dbn-sql
data_intermediate.contract_start_date
data_intermediate.contract_projection
data_intermediate.contract_payment_summary
data_intermediate.contract_deposit_summary
```

### Why split transactions into deposits and payments?
We split scheduled payments and deposits into 2 different tables for several reasons: 

1. As much as both are transactions, they really are 2 distinct business facts. 
A deposit signals the activation of the contract. Scheduled payments have no such meaning.
2. They have different ordinality/cardinality and fill rates. A contract should ideally 
have a single deposit payment, and several (tens to hundreds) scheduled payments. 
If an analyst wanted to extract some business meaning, such as, 
which contracts are active i.e. a deposit has been made for such contracts, 
then this is a simple scan and filter on the deposit table, which is of order < Total # contracts. 
Querying this fact from a dedicated deposit table should be orders of magnitude cheaper 
than attempting to extract this from the full transactions table.


### Why a table for contract_start_date?
I deem the contract start date a nebulous enough entity that it deserves to be a 
standalone table as well. This explicitly clarifies the business decisions being made 
regarding contract start date:

    • If a deposit date exists, that will be the contract start date
    • If there are multiple deposits,  the earliest deposit date is considered the 
    activation date
    • If no deposit exists for said contract, then the earliest recorded payment date will 
    be used as the contract start date
    • If neither deposit nor scheduled payment exist, then use the date of contract creation 
    as the contract date. 


### Why a contract_projection table?
Finally, the contract projection is created in the following query. I also  deem contract <br/>
projection worthy of it’s own table for the following reasons:
1. Is potentially a fact that different business units might be interested in: <br/>

        1a. Finance could use this identify lagging or on-time contracts 
        1b. Marketing could use this to identify customers that might be a good fit 
            for upcoming marketing campaigns
        1c. Customer service could use this to identify the impact of re-scheduling 
            a customer’s payments or even refunding or writing off a payment 
            
2. Involves the creation and application of business logic that is likely to have 
significant impact on contract analysis. Having this dedicated table facilitates the scrutiny 
and troubleshooting of the decisions made during projection.




Theere are 380 in contracts in the provided dataset:

SELECT * FROM finance.contract_status WHERE contract_status='ACTIVE' (353 contracts)

SELECT * FROM finance.contract_status WHERE contract_status='COMPLETED' (27 contracts)