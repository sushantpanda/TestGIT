global with sharing class MyJSRemoting  
{ 
    public MyJSRemoting() {

    }

 
   public MyJSRemoting(ApexPages.StandardController controller){}
 
    @RemoteAction
    global static List<account> showContacts(String accName){
        accName = '%'+ accName+'%';
        List<account> lst_account = new List<account>([select id, name,employee_email__c from account where Name LIKE : accName]);
        return lst_account ;
    }
}