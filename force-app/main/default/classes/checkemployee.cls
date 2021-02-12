public with sharing class  checkemployee {
    public account c{get;set;}
    public job_posting__c jb{get;set;}   
    public checkemployee(ApexPages.StandardController controller) {
          //list<candidate__c> c= new list<candidate__c>();      
        c=[select name,Phone from account where id=:ApexPages.currentPage().getParameters().get('id')];
       
    system.debug('__________eeeeeeeeeeee___'+ApexPages.currentPage().getParameters().get('id'));
    }
public static testMethod void checkemployee()
     {
        try 
        {  
           
            Test.setCurrentPage(Page.viewemployee);
            account c=new account();
            job_posting__c jb=new job_posting__c();
            c.name='aaa';
            insert c;
            }
         catch(Exception e)
         {
         system.debug(e);
         }           
}}