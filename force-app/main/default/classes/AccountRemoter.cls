global with sharing class AccountRemoter {

    public String accountName { get; set; }
    public static list<Account> account { get; set; }
    public AccountRemoter() { } // empty constructor
    
    @RemoteAction
    global static list<Account> getAccount() {
        account = [SELECT Id, Name, Phone, Type, NumberOfEmployees 
                   FROM Account ];
        return account;
    }
}