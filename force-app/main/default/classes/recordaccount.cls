public with sharing class recordaccount {
Public String[] grdData {get;set;}
public string selectedcheck{get;set;}
public void record ()

  {
grdData =new String[]{};
for(account acc:[select name,fax,phone ,description from account limit 20])
        {
grdData.add('["","'+ acc.name  + '","'+acc.fax +'","'+acc.phone +'","'+acc.description +'"]');

          }

   }

}