public class accountrecord {
 public string ab{get;set;}
 public string abemp{get;set;}
 

    public PageReference go() {
    test__c ac=new test__c();
    ac.name=ab;
    insert ac;
    Savepoint sp = Database.setSavepoint();
    
        return null;
    }



}