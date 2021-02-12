public with sharing class candidatelogin {
    public list<candidate__c> c;
     String country =null;
    public PageReference register() {
       PageReference p= new PageReference('/apex/candidate');
       p.setredirect(true);
        return p;
    }



public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('US','US')); 
        options.add(new SelectOption('CANADA','Canada')); 
        options.add(new SelectOption('MEXICO','Mexico')); return options; 
    }
                   
    public String getCountry() {
        return country;
    }
    
 public String pwd { get; set; }
 public String uname { get; set; }


public PageReference test() {
        return null;
    }
          
          

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

public static testMethod void candidatelogin()
 {
        try 
        {  
        
         
         
           Test.setCurrentPage(Page.candidatelogin);
           candidatelogin cl=new candidatelogin ();
           
            cl.register();
            cl.signin();
          
        

        }
        
        catch(Exception e)
            {
            
            }
}





}