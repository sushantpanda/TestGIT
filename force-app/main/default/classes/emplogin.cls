public with sharing class emplogin {

    public emplogin(ApexPages.StandardController controller) {

    }


    public list<account> c;

    public PageReference register() {
       PageReference p= new PageReference('/apex/employeereg');
        return p;
    }

 public String pwd { get; set; }
 public String uname { get; set; }



public PageReference signup()
{
PageReference p= new PageReference('/apex/employer_registration');
return p;
}

public Pagereference signin()
{
integer i=0;
system.debug('_______umane__'+uname );
system.debug('_______pwd __'+pwd );
//c=[select name,employee_email__c,password__c from Account where employee_email__c=:uname]

  if([select employee_email__c,password__c from account where employee_email__c=:uname  ].size()>0)                              


{
system.debug('____________'+c);

     Pagereference pr=new PageReference('/apex/viewemp?cid='+[select id from account where employee_email__c=:uname ].id);
     pr.setredirect(true);
     return pr;
    
}

else
{
   ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Username or Password Invalid '));
   return null;
 }


   return null;
}



public static testMethod void emplogin()
 {
       
        
         
         
           Test.setCurrentPage(Page.employeelogin);
           
             Account acc=new account(name='aa',employee_email__c='aa@gmail.com',password__c='123');
           insert acc;
           
            ApexPages.StandardController sc = new ApexPages.standardController(acc);
             
             
               emplogin controller = new emplogin(sc);
               controller.signin();
                controller.signup();
                controller.register();
               
          
        

       
        
        
}
}