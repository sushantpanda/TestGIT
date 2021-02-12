public with sharing class showcan_cls {
   public candidate__c c { get; private set; }
    public showcan_cls(ApexPages.StandardController controller) {
    c=[select name,Email__c,password__c,address__c,street__c,city__c,state_province__c,country__c,current_employee__c,name_of_employee__c,skill__c,year_of_experience__c,higest_education__c,email_alert_on_new_job__c,enable_profile_for_employee__c from candidate__c where id=:ApexPages.currentPage().getParameters().get('id')];
    }

public showcan_cls(){



}


}