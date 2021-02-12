@isTest
public class checkdate 
{
    static testMethod void verifyAccount()
    {
    account acc= new account (name='aaa',employee_email__c='aaa@gmail.com',password__c='123');
    insert acc;
    event ee =new event(whatid = acc.id,durationinminutes = 60, activitydatetime = datetime.now());
        insert ee;
    }
    
    static testMethod void verifyAccount1()
    {
    account ac=new account();
    account acc1= new account (name='aaa1',employee_email__c='aaa1@gmail.com',password__c='1231');
    insert acc1;
    event ee1 =new event(whatid = acc1.id,durationinminutes = 60, activitydatetime = datetime.now());
        insert ee1;
        if(ee1!=null)
        {        
         
         acc1.dateevent__c=ee1.activitydatetime;
        }
        update acc1;
         
    }
     static testMethod void verifyAccount11()
    {
    account ac1=new account();
    account acc11= new account (name='aaa11',employee_email__c='aaa11@gmail.com',password__c='12311');
    insert acc11;
    acc11.name='sssss';
    update acc11;
    event ee11 =new event(whatid = acc11.id,durationinminutes = 60, activitydatetime = datetime.now());
        insert ee11;
        if(ee11!=null)
        {        
         
         acc11.dateevent__c=ee11.activitydatetime;
        }
        update acc11;
         
    }
    

    
    
}