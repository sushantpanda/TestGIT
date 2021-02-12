public with sharing class jobposting_cls {
public job_posting__c jp{get;set;}

    public jobposting_cls(ApexPages.StandardController controller) {
   
    jp=new job_posting__c();
     jp.Account__c=ApexPages.currentPage().getParameters().get('cid');
    }
 Public PageReference save() {
 

     


insert jp;
system.debug('++++++++++++_______________'+jp);


return null;

}

public static testMethod void jobposting_cls()
        {
       
        
            Test.setCurrentPage(Page.jobposting);
            
             Account acc=new account(Name='ssss',employee_email__c='aa@gmail.com',password__c='123');
           insert acc;
           job_posting__c jbc=new job_posting__c(name='sss',skill__c='java',experience_required__c=2,status__c='normal',job_location__c='delhi',salary__c='3',  Account__c=acc.id);
            insert jbc;
          ApexPages.currentPage().getParameters().put('cid',acc.id);
             ApexPages.StandardController sc = new ApexPages.standardController(jbc);
              
            
               jobposting_cls controller = new  jobposting_cls(sc);
               controller.save();
               
              


}

}