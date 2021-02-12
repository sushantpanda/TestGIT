public with sharing class RecordTypePickListController 
{
 public List<String> pickListVals {get; set;}
 public String valsText {get; set;}
 public Boolean loadOnce {get; set;}
 private Opportunity opp;
  
 public RecordTypePickListController(ApexPages.StandardController std)
 {
  opp=(Opportunity) std.getRecord();
  loadOnce=true;
 }
  
 public PageReference reload()
 {
  pickListVals=new List<String>();
  Boolean skip=true;
  for (String val : valsText.split(':'))
  {
   if (skip)
   {
    skip=false;
   }
   else
   {
    pickListVals.add(val);
   }
  }
 
  loadOnce=false;
   
  return null;
 }
}