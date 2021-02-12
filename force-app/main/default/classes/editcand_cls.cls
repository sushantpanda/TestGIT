public with sharing class editcand_cls {
     public candidate__c c { get; private set; }
     public string name{get;set;}
     public blob body{get;set;}
     public String ContentType1{ get; set; }
     public string name1{get;set;}
     public blob body1{get;set;}
     public String ContentType2{ get; set; }
     Public Document mydoc{get;set;}
     Public Document mydoc1{get;set;}
        Id ids;
     
     
     
    public editcand_cls(ApexPages.StandardController controller) {  
    c=[select name,Email__c,password__c,address__c,cv_id__c,image_id__c,street__c,city__c,date_of_birth__c,age__c,state_province__c,country__c,current_employee__c,name_of_employee__c,skill__c,year_of_experience__c,higest_education__c,email_alert_on_new_job__c,enable_profile_for_employee__c from candidate__c where id=:ApexPages.currentPage().getParameters().get('id')];
     ids=ApexPages.currentPage().getParameters().get('id');
     system.debug('__+++++_____'+ids);
     
     mydoc=new document();
     mydoc1=new document();
    ids=c.id;
    }

   



     public PageReference save() {
            
              system.debug('__+++++_____'+ids);
          upsert(c);
          system.debug('------------------name---------------------'+name);
          if(name!=null)
          {
          mydoc.folderId=UserInfo.getUserId();
          mydoc.name=name;
          mydoc.contentType=ContentType1;
          mydoc.body=body;
          insert mydoc;
          
          //insert log;
          c.image_Id__c=mydoc.id;
          update c;
          }
          if(name1!=null)
          {
          mydoc1.folderId=UserInfo.getUserId();
          mydoc1.name=name1;
          mydoc1.contentType=ContentType2;
          mydoc1.body=body1;
          insert mydoc1;
          
          c.cv_id__c=mydoc1.id;
          update c;
          }
         
        // PageReference pageRef = new PageReference('apex/viewcand1?id='+ids);
       //  pageRef.setRedirect(true);
         
          return null ;
 
        }
        
 public static testMethod void editcand_cls()
     {
          
            Test.setCurrentPage(Page.showcand1);
           // candidate__c c= new  applied_job__c(jobid__c='ooooq',employername__c='aaa',location__c='dddd');
         
            candidate__c c=new candidate__c(name='ss',Email__c='aa@gmail.com',password__c='111',address__c='sssss12',street__c='wweeer',city__c='wertt',state_province__c='wsderf',country__c='dcvfr',name_of_employee__c='sdcxz',skill__c='vfbghn');
            insert c;
              ApexPages.currentPage().getParameters().put('id',c.id);  
          ApexPages.StandardController sc = new ApexPages.standardController(c);
             
             
               viewcandidate controller = new viewcandidate(sc);
             controller.switchTab();
            }
    
 
 
 }