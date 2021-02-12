public with sharing class viewcandidate 
{

public String selectedTab{get;set;}
     public list<applied_job__c> ap{get;set;}
      public candidate__c c { get; private set; }
    public viewcandidate(ApexPages.StandardController controller) {
     ap=[select  jobid__c,candidate__c, employername__c,location__c from applied_job__c where candidate__c=:ApexPages.currentPage().getParameters().get('id')];
  c=[select name,Email__c,password__c,address__c,street__c,city__c,state_province__c,country__c,current_employee__c,name_of_employee__c,skill__c,year_of_experience__c,higest_education__c,email_alert_on_new_job__c,enable_profile_for_employee__c from candidate__c where id=:ApexPages.currentPage().getParameters().get('id')];
    }
    
      public void switchTab(){
     
         selectedTab = System.currentPageReference().getParameters().get('tabvalue');    
     
    }
       
 public static testMethod void viewcandidate()
     {
         
           
            Test.setCurrentPage(Page.viewcand);
            applied_job__c apc= new  applied_job__c(jobid__c='ooooq',employername__c='aaa',location__c='dddd');
            insert apc;  
            candidate__c c=new candidate__c(name='ss',Email__c='aa@gmail.com',password__c='111',address__c='sssss12',street__c='wweeer',city__c='wertt',state_province__c='wsderf',country__c='dcvfr',name_of_employee__c='sdcxz',skill__c='vfbghn');
            insert c;
              ApexPages.currentPage().getParameters().put('id',c.id);  
          ApexPages.StandardController sc = new ApexPages.standardController(c);
             
             
               viewcandidate controller = new viewcandidate(sc);
             controller.switchTab();
            }
    
 
 
 }