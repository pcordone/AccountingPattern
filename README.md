# accounting-pattern

## Description
An implementation of Martin Fowlers accounting pattern https://www.martinfowler.com/eaaDev/AccountingNarrative.html.  I kept the entries in an Account object and also created a ChartOfAccounts object to store all accounts since that follows the domain structure of a typical accounting system. 


## Installation

You need to have gyb installed in order to code generate the enum CurrencyType from the command line.  I used brew to install gyb:
    
    brew install nshipster/formulae/gyb

To generate CurrencyType with gyb at terminal in the Accounting project type:
    
    make

To delete the generated files type:
    
    make clean
