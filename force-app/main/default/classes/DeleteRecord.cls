public Class DeleteRecord
{
    public string abc{get;set;}
    public string check{get;set;}
     public string selected{get;set;}
     Contact [] Contacts;

        public List<Contact> getContacts(){
                if(contacts == null){
                        contacts = [select Id, Name, Phone, MailingCity from Contact limit 10];
                } 
                return Contacts;
        }
    public DeleteRecord(ApexPages.StandardSetController controller) {
     
    } 
   public DeleteRecord(){
   
  
   }
    public void deleteRec()
    {
        system.Debug('-------------'+abc+'-----------------');
        
        system.Debug('++++++++++++'+selected+'-----------------');
    }
    
    public pagereference contro(){
    return null;
    }
    
}