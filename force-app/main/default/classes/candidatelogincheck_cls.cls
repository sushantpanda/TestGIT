public with sharing class candidatelogincheck_cls {

    String country='';
    public list<candidate__c> c;
      public list<account> acc;  
      public account account ;
 public String pwd { get; set; }
 public String uname { get;set; }
     
   


public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('candidate','candidate')); 
        options.add(new SelectOption('employee','employee')); 
         return options; 
    }
                   
    public String getCountry() {
        return country;
     
    }
    public void setCountry(String country) { this.country = country; 
    
    system.debug('____________'+country);
    }

         
 
    



          

public Pagereference signin()
{
    if(country=='candidate')
    {


  
c=[select id,email__c,password__c from candidate__c where email__c=:uname];                                
{
if(c[0].password__c==pwd)
if(c.size()>0 ){



     Pagereference pr=new PageReference('/apex/viewcand?id='+[select id from candidate__c where email__c=:uname ].id);
     pr.setredirect(true);
     return pr;

}
}


}

if(country=='employee')
{
 acc=[select employee_email__c,password__c from account where employee_email__c=:uname ];                             

{
if(acc[0].password__c==pwd)
if(acc.size()>0){
system.debug('____________'+c);

     Pagereference pr=new PageReference('/apex/viewemp?cid='+[select id from account where employee_email__c=:uname ].id);
     pr.setredirect(true);
     return pr;
}

}
       
}











else
{
   ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Username or Password Invalid '));
   return null;
 }

   return null;
}


 public PageReference register() {
    
    if(country=='candidate')
    {
       PageReference p= new PageReference('/apex/candidate');
       p.setredirect(true);
        return p;
     }
    if(country=='employee')
        {    
        PageReference pq= new PageReference('/apex/employeereg');
         pq.setredirect(true);
        return pq;     
          
        
        }
        
        else
        {
       ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Select Registeration option'));
           return null;
        
        
        }
        
        
        }
        
        
        
   








public static testMethod void candidatelogincheck_cls()
 {
       
        
         
         
           Test.setCurrentPage(Page.candidatelogin);
          candidatelogincheck_cls cl=new candidatelogincheck_cls();
          list<candidate__c> c2=new list<candidate__c>();
          
        candidate__c  c=new candidate__c(email__c='aa@gmail.com',password__c='ddd',name='sss');
          insert c;
          cl.country='candidate';
           cl.uname='aa@gmail.com';
           cl.pwd='ddd';
        
         
            cl.signin();
             
             
               cl.register();   
               
               account acc=new account(name='sss',employee_email__c='aa@gmail.com',password__c='12');
               insert acc;
               
               cl.country='employee';
               cl.uname='aa@gmail.com';
               cl.pwd='12'; 
               
            cl.signin();
            
               cl.register();  
               
                account acc1=new account(name='sss',employee_email__c='aa@gmail.com',password__c='12');
               insert acc1;
                cl.country='';
              cl.signin();
            
               cl.register();
              
             
               
           
          
        

       
        
        
}





}