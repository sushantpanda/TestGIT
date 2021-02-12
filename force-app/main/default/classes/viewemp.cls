public with sharing class viewemp {

public String selectedTab{get;set;}

    public account acc{get;set;}
     
    public viewemp(ApexPages.StandardController controller) {
       acc=[select  name from account where id=:ApexPages.currentPage().getParameters().get('cid')];
    }
    
        public void switchTab(){
     
         selectedTab = System.currentPageReference().getParameters().get('tabvalue');    
     
    }
    
    

public static testMethod void viewemp()
        {
       
        
            Test.setCurrentPage(Page.viewemp);
           Account acc=new account(Name='ssss',employee_email__c='aa@gmail.com',password__c='123');
           insert acc;
            
            ApexPages.StandardController sc = new ApexPages.standardController(acc);
            ApexPages.currentPage().getParameters().put('cid',acc.id);   
             
               viewemp controller = new viewemp(sc);
             controller.switchTab();
            }
           
         
            
      
        

}