public with sharing class candidatelogin_cls {

  
    public list<candidate__c> c;
     
    public PageReference register() {
       PageReference p= new PageReference('/apex/candidate');
       p.setredirect(true);
        return p;
    }


         
 
    
    
 public String pwd { get; set; }
 public String uname { get; set; }


          

public Pagereference signin()
{

  c=[select id,email__c,password__c from candidate__c];                                
system.debug('____'+c);
if(c[0].email__c==uname && c[0].password__c==pwd)
{
system.debug('____________'+c);

     Pagereference pr=new PageReference('/apex/viewcand?id='+c[0].id);
     pr.setredirect(true);
     return pr;
}





else
{
   ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Username or Password Invalid'));
   return null;
 }

   return null;
}

public static testMethod void candidatelogin_cls()
 {
       
        
         
         
           Test.setCurrentPage(Page.candidatelogin);
          candidatelogin_cls cl=new candidatelogin_cls();
          list<candidate__c> c2=new list<candidate__c>();
           cl.register();
        candidate__c  c=new candidate__c(email__c='aa@gmail.com',password__c='ddd');
          insert c;
          
            cl.signin();
                 
           
          
        

       
        
        
}





}