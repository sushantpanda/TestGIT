public class testemail 
{

   


    public testemail() {
    
   
    }
    public Integer i=0;
    public  List<Id> contactids=new list<id>();
  public List<candidate__c> cand{get;set;}
  public List<job_posting__c> postng{get;set;}
   
  public testemail(ApexPages.StandardController controller)
  {     


  }
  public void check(){
     postng = [select Id,skill__c from job_posting__c ];
     
     
     system.debug('_________postng _____'+postng );
    
     
     system.debug('_________postng _____'+postng[0].skill__c );
     cand = [select Id,skill__c,Email__c,password__c,street__c,phone_no__c from candidate__c limit 250 ];
    system.debug('_________cand _____'+cand[0] );
     system.debug('_________cand _____'+cand [0].skill__c );
   for(integer i=0;i<=1;i++)
    {
         if (cand [i].skill__c==postng[i].skill__c)
             {
             system.debug('__________hiiii________'+cand [i].id);
             contactids.add(cand [i].id);
             system.debug('___________idss________'+contactids);
             }
    }
                    }
  public void SendEmail()
  {
       Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
       mail.setTargetObjectIds(contactids);
       mail.setTemplateId('00X90000000QHUD');
       Messaging.sendEmail(new Messaging.MassEmailMessage[] { mail });
  }  


}