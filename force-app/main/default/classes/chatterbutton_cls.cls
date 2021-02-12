public class chatterbutton_cls {
public String strabc { get; set; }
    public chatterbutton_cls(){
    string ids=ApexPages.currentPage().getParameters().get('id');
    system.debug('--id--'+ids);
    }
    
    
    public void sendmail(){
    
    }

/*
        public ApexPages.StandardSetController setCon {
        get {
        if(setCon == null) {
        setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
        [SELECT Name, CloseDate FROM Opportunity]));
        }
        return setCon;
        }
        set;
        }
        */
            
}