public class clsDynamicSearch {

public string check1{get;set;}
 private String soql {get;set;}
public List<Contact> contacts {get;set;}
          

                
public clsDynamicSearch() {
    soql = 'select firstname, lastname, account.name, email from contact where account.name != null';
   run();
  }
               
                 
                 
   public PageReference change()
   {
   
    String lastName = Apexpages.currentPage().getParameters().get('lastname');
    System.debug('________________________________'+lastname);
     soql = 'select firstname, lastname, account.name, email from contact where account.name != null';
      if (!lastName.equals(''))
      soql += ' and lastname LIKE \''+String.escapeSingleQuotes(lastName)+'%\'';
      run();
       return null;
   }   
   
   public void run()
   {
   try
   {
  
    contacts = Database.query(soql);
     } 
     catch (Exception e) 
     {
     System.debug('____________________________ddddddddd');
     }
   }     }