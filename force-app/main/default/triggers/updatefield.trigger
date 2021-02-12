trigger updatefield on Account (after update) 

{
Set<id> SetOfIDs = new Set<id>();

List<Account> AccountsToUpdate = new List<Account>();
List<Account> adaccount = new List<Account>();



// populate the set
for (account a : trigger.new) {
    SetOfIDs.add(a.id);
}   


// you need to query the fields you want to edit as no select * exists in SOQL
AccountsToUpdate = [ SELECT ID, Name FROM account WHERE ID in :SetOfIDs ];

for(account acc:AccountsToUpdate)
{
 acc.SLASerialNumber__c='123';
 adaccount.add(acc);
}

update adaccount;
}