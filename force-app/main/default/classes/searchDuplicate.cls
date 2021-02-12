global with sharing class searchDuplicate {
   public   AggregateResult[] con{get;set;}
   
   
   public searchDuplicate()
   {
       find();
   }
    public void find(){
      con = [select Email from Contact group by Email having count(Email) > 1];
        System.debug(con);
    }
}