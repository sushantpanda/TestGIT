trigger updatecontact on Account (after insert, after update ) {
if(trigger.isUpdate)
   {
      integer count=0;
      list<id> ids=new list<id>();
       map<id,account> map1=new map<id,account>();
      for(account ac:trigger.new)
      {
        
        ids.add(ac.id);
        map1.put(ac.id,ac);
        
      }
      list<contact> con=new list<contact>();
      list<contact> updtcont=new list<contact>();
     
      con=[select name,accountid,MailingStreet,MailingCity,MailingState,MailingCountry from contact where accountid in:ids ];
      system.debug('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'+con);
      for(contact cont:con)
      {
         if(map1.containsKey(cont.accountid))
        {
          cont.MailingStreet=map1.get(cont.accountid).BillingStreet;
          updtcont.add(cont);
        }
      }
     try
      {
        if(!updtcont.isEmpty())
        {
            update updtcont;
        }
      }
     
      catch(Exception e)
   {
      system.debug(e);
   
   }
      
      
   }
}