public with sharing class checkcandidate {
    public candidate__c c{get;set;}
    public checkcandidate(ApexPages.StandardController controller) {
          //list<candidate__c> c= new list<candidate__c>();      
        c=[select name, address__c, skill__c,phone_no__c,Email__c from candidate__c where id=:ApexPages.currentPage().getParameters().get('id')];
    system.debug('__________eeeeeeeeeeee___'+ApexPages.currentPage().getParameters().get('id'));
    }



}