trigger checkdate on Event (after insert,after update,after delete) 
{
    List <Account> accSave = new List<Account>();
    set<id> accid =new set<id>();
    Account acc=new account();

 /* for(event e: trigger.new)
  {
   accid.add(e.WhatId);
  }
     
  list<Account> acc =[select id from account where id in :accid ] ;
  
     for(event e: trigger.new)
        {
         for(account ac: acc)
             {
                  ac.dateevent__c=e.StartDateTime;
                  accSave.add(ac);
             }


 
        }
  update accSave; 
  */
     
      if(Trigger.Isinsert)
    {
        if(trigger.new[0].WhatId!=null)
            {
                                        
       list<event> e= [select Id,WhatId,StartDateTime,EndDateTime,Subject from Event where WhatId=:Trigger.new[0].WhatId AND StartDateTime < :system.Now() ORDER BY StartDateTime desc limit 1 ]; 
            if(e.size()>0)
            {
            acc=[select id,dateevent__c from account where id=:e[0].WhatId];
            acc.dateevent__c=e[0].StartDateTime;
            update acc;
            }


            }
    }
     
     
     
     
     if(Trigger.Isupdate)
     {
        if(trigger.new[0].WhatId!=null)
            {
                                        
       list<event> e= [select Id,WhatId,StartDateTime,EndDateTime,Subject from Event where WhatId=:Trigger.new[0].WhatId AND StartDateTime < :system.Now() ORDER BY StartDateTime desc limit 1 ]; 
            if(e.size()>0)
            {
            acc=[select id,dateevent__c from account where id=:e[0].WhatId];
            acc.dateevent__c=e[0].StartDateTime;
            update acc;
            }


            }
            
        
            
            
     
      }
      
      if(Trigger.Isdelete)
     {
        if(trigger.old[0].WhatId!=null)
            {
               system.debug('+++++++++++++++'+trigger.old[0].WhatId);                         
       list<event> e= [select Id,WhatId,StartDateTime,EndDateTime,Subject from Event where WhatId=:Trigger.old[0].WhatId AND StartDateTime < :system.Now() ORDER BY StartDateTime desc limit 1 ]; 
           
           system.debug('+++++++++++++++'+e);
           
            if(e.size()>0)
            {
             acc=[select id,dateevent__c from account where id=:e[0].WhatId];
            acc.dateevent__c=e[0].StartDateTime;
            system.debug('-----------------'+ acc.dateevent__c);
            update acc;
            }
           else
            {
            acc=[select id,dateevent__c from account where id=:trigger.old[0].WhatId];
            acc.dateevent__c=null;
            update acc;
            }


            }
     
      }
      
      
      
      
      
      
      
}