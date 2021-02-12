public with sharing class AccountPagination {
    private final Account acct;  

    // The constructor passes in the standard controller defined
    // in the markup below
    public AccountPagination(ApexPages.StandardSetController controller) {
        this.acct = (Account)controller.getRecord(); 
    }    
    
     public ApexPages.StandardSetController accountRecords {
        get {
            if(accountRecords == null) {
                accountRecords = new ApexPages.StandardSetController(
                    Database.getQueryLocator([SELECT Name FROM Account WHERE Id NOT IN 
                        (SELECT AccountId FROM Opportunity WHERE IsClosed = true)]));
                        accountRecords.setPageSize(5);
            }
            return accountRecords;
        }
        private set;
    }
    public List<Account> getAccountPagination() {
         return (List<Account>) accountRecords.getRecords();
    } 
    public void previous()  
    {  
        accountRecords.previous();  
    }  
   
    //Returns the next page of records  
    public void next()  
    {  
        accountRecords.next();  
    }   
}