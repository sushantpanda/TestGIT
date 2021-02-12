public with sharing class appliedjob {
 public list<applied_job__c> ap{get;set;}
    public appliedjob() {
  ap=[select  jobid__c,candidate__c, employername__c,location__c from applied_job__c where candidate__c=:ApexPages.currentPage().getParameters().get('cid')];
    }

    
  

}