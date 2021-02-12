trigger find on Contact (after insert, after update) 
{
integer sum=0;
list<account> acc;
set<id> ids=new set<id>();
for(contact con: trigger.new)
{
ids.add(con.accountid);

}
 //Map<Id,Account> AccountMap = new Map<Id,Account>([Select Id,Amount__c from Account where Id in :ids]);
   // for(AggregateResult res : [SELECT AccountId, SUM(Amount__c) cnt FROM Contact where AccountId in : ids GROUP BY ]){
     //   if(res.get('AccountId') <> null){
      //      AccountMap.get((ID)res.get('AccountId')).Amount__c = (Decimal)res.get('cnt');
      //  }
  //  }
   // update AccountMap.values();
}