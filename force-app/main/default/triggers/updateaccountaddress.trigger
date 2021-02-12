trigger updateaccountaddress  on Contact (before update ) 
{
set<id> ids=new set<id>();
list<contact> conadd=new list<contact>();

for(contact con:trigger.new)
{
ids.add(con.accountid);
}
Map<Id,Account> accMap =  new Map<Id,Account>([select id,name,site from Account where id in:ids]);

for(contact con1: trigger.new)
{
 con1.Languages__c=accmap.get(con1.accountid).site;
conadd.add(con1);
}

}