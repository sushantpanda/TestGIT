public with sharing class editemp {
public account acc=new account();
public account acc1=new account();
public contact con=new contact();
public contact con1=new contact();
public editemp()

{
acc=[select Name,employee_email__c, password__c,state__c,billingstreet,billingcity,phone,billingcountry from account where id=:ApexPages.currentPage().getParameters().get('id')];
con=[select FirstName,lastname,phone,Email,Department from contact where accountid=:ApexPages.currentPage().getParameters().get('id')];
acc1.name=acc.name;
acc1.employee_email__c=acc.employee_email__c;
acc1.password__c=acc.password__c;
acc1.state__c=acc.state__c;
acc1.billingstreet=acc.billingstreet;
acc1.phone=acc.phone;
acc1.billingcountry=acc.billingcountry;
con1.firstname=con.firstname;
con1.lastname=con.lastname;
con1.phone=con.phone;
con1.email=con.email;
con1.Department=con.Department;

}
}