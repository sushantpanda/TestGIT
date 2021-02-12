public with sharing class candidateinfo {
    public candidate__c c{get;set;}
    public candidateinfo() {

    }
     public string name{get;set;}
     public blob body{get;set;}
     public String ContentType1{ get; set; }
     public string name1{get;set;}
     public blob body1{get;set;}
     public String ContentType2{ get; set; }
    
       
    public id ids{get;set;}
    public id docid{get;set;}
    public Boolean isAvailable{get;set;}
    public List<Attachment> postImageId;
    
      
    ApexPages.StandardController std;
    public candidateinfo(ApexPages.StandardController controller) {
       c = new candidate__c();
        mydoc=new document();
          mydoc1=new document();
    
    
    
    }
    
    Public Document mydoc{get;set;}
     Public Document mydoc1{get;set;}
   
     
   
    
 public PageReference save() {
 
 insert c;
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
 
  PageReference acctPage1 = new PageReference ('/apex/viewcand?id='+c.id);
     acctPage1.setRedirect(true);
      return acctPage1 ;
 
        }
        
      
     
    
      public PageReference cancel() {
     
      PageReference acctPage = new PageReference ('/apex/login');
     acctPage.setRedirect(true);
      return acctPage ;
        }
     
     
    


 
 
 }