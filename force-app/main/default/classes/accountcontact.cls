public with sharing class accountcontact {

    public accountcontact(ApexPages.StandardController controller) {

      System.debug('hello1111');
    }


    public PageReference save1() {
        system.debug('___________check_________________');
    account.billingcountry='india';
        insert account;

      contact.accountId = account.id;
      insert contact;
    
     Pagereference pr=new PageReference('/apex/viewemp?cid='+account.id);
     pr.setredirect(true);
     return pr;
        
    }


    Account account;
   Contact contact;
     public Account getAccount() 
     {

      if(account == null) account = new Account();
      account.billingcountry='India';
      return account;

     }

   public Contact getContact() 
               {

      if(contact == null) contact = new Contact();

      return contact;
                   }



 public PageReference cancel() {
   
    Pagereference pr=new PageReference('/apex/employeelogin');
     pr.setredirect(true);
     return pr;
   
   
   
   
    }


    


    
}