public with sharing class showemp_cls {
//public job_posting__c jp{get;set;}
   
     public showemp_cls(ApexPages.StandardController controller) {
    }
  
    
   public showemp_cls()
   {

    // jp=new job_posting__c();
    //  jp.Account__c=ApexPages.currentPage().getParameters().get('cid');
    Id ids = ApexPages.currentPage().getParameters().get('cid');
    system.debug('aaaaaaaaaaaaaaa'+ids);
account = (ids == null) ? new Account() :[select Name,employee_email__c, password__c,state__c,billingstreet,billingcity,phone,billingcountry from account where id=:ids];
//system.debug('_____dddddd_______'+acc);
contact=[select FirstName,lastname,phone,Email,Department from contact where accountId=:ApexPages.currentPage().getParameters().get('cid')];
//system.debug('_____con_______'+contact);
   
    }




   

public Account account { get; private set; }
public Contact contact { get; private set; }
 
 
public PageReference save() {
      
            upsert(account);
            upsert(contact);
            
        
        //  After Save, navigate to the default view page: 
    
        //return (new ApexPages.StandardController(account)).view();
         return null;
    }

 public PageReference cancel() {
        return null;
    }


 
 public static testMethod void showemp_cls()
        {
       
        
            Test.setCurrentPage(Page.showemp1);
           Account acc=new account(Name='ssss',employee_email__c='aa@gmail.com',password__c='123');
           insert acc;
         
           contact con =new contact(lastname='aaaa',accountid=acc.id);
            insert con; 
            ApexPages.StandardController sc = new ApexPages.standardController(acc);
            ApexPages.currentPage().getParameters().put('cid',acc.id);   
            
               showemp_cls controller = new  showemp_cls(sc);
              
                controller.save();
             // controller.save1();
              
               controller.cancel();
             
             
                
           
             
            }
           
 
 
 
 
 
}