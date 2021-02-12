trigger checkdate1 on Event (after insert,after update) 
{
    List <Account> accSave = new List<Account>();
    set<id> accid =new set<id>();
    Account acc1=new account();

  for(event e: trigger.new)
  {
  if(e.accountid!=null)
  {  
   accid.add(e.AccountID);
  }
   }  
  list<Account> acc =[select id from account where id in :accid ] ;
  
    
        
        list<event> e= [select Id,accountid,StartDateTime,EndDateTime,Subject from Event where accountid In:accId ORDER BY StartDateTime desc limit 1   ]; 
          
          system.debug('+++++++'+e);
          for(event s: e)
          {
          for(account ac: acc)
             {
             
                  ac.dateevent__c=s.StartDateTime;
                  accSave.add(ac);
             }

            }
 
        
  update accSave;
  
  
  }