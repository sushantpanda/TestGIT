public with sharing class editemp_cls {

   
Id idd = ApexPages.currentPage().getParameters().get('cid');
public Account account { get; private set; }
public Contact contact { get; private set; }
 
 public editemp_cls(){
 Id ids = ApexPages.currentPage().getParameters().get('cid');
account = (ids == null) ? new Account() :[select Name,employee_email__c, password__c,state__c,billingstreet,billingcity,phone,billingcountry from account where id=:ids];
//system.debug('_____dddddd_______'+acc);
contact=[select FirstName,lastname,phone,Email,Department from contact where accountId=:ApexPages.currentPage().getParameters().get('cid')];
//system.debug('_____con_______'+contact);
   
}

public PageReference save() {

//Id idd = ApexPages.currentPage().getParameters().get('cid');

        try {
            upsert(account);
            upsert(contact);
            
        } catch(System.DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }
        //  After Save, navigate to the default view page: 
    
        //return (new ApexPages.StandardController(account)).view();
        
       // PageReference pageRef = new PageReference('/apex/viewemp?cid='+idd);
        
        // return pageRef ;
        return null;
    }

 public PageReference cancel() {
       // PageReference pageRef = new PageReference('/apex/viewemp?cid='+idd);
        
        // return pageRef ;
         return null ;
    }
public static testMethod void editemp_cls()
{
        
        
            Test.setCurrentPage(Page.editemp);
        
          
        account acc =new account(name='sss',employee_email__c='ss@gmail.com',password__c='aa',state__c='aaa',billingstreet='aaaa',billingcity='aaa',phone='233',billingcountry='dssaa');
        insert acc;
        ApexPages.currentPage().getParameters().put('cid',acc.id);
        contact con =new contact(FirstName='sss',lastname='sss',phone='3432',Email='ww@gmail.com',Department='fsdfgsd',accountId=acc.id);
        insert con;
      
       //  ApexPages.StandardController controller1 = new ApexPages.StandardController(con);
        editemp_cls edtemp=new editemp_cls();
         edtemp.save();
         edtemp.cancel();
             
         
}}