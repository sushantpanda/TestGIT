public with sharing class RelatedController 
{ 
 public list<contact> cont1{get;set;}  
 private ApexPages.StandardController stdCtrl;
  
 public RelatedController(ApexPages.StandardController std)
 {
 
  stdCtrl=std;
 }
       
  public void AccountPopulated()
 {
  Contact cont=(Contact) stdCtrl.getRecord();
  
  
  cont.Account=[select AccountNumber, Site,name from Account where id=:cont.AccountId];
    cont1=[select name from contact where contact.account.id=:cont.AccountId ];
    system.debug('-----------------name--------------'+cont1);
  
 }
}