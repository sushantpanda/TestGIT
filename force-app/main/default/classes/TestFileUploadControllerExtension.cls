public class TestFileUploadControllerExtension 
{
    ApexPages.StandardController controller;
    public TestFileUploadControllerExtension(ApexPages.StandardController c) 
    { 
        System.debug('@@@@@@@@ TestFileUploadControllerExtension');
        this.controller = c;
    }    
 
    public PageReference doSave()
    {
        System.debug('@@@@@@@@ doSave');
        Document d = (Document) controller.getRecord();
        System.debug('@@@@@@@@ document name: '+d.name);
  
        d.folderid = UserInfo.getUserId(); //store in Personal Documents
        System.debug('@@@@@@@@ document folder id: '+d.folderid);
        
        insert d;
        System.debug('@@@@@@@@ document object id: '+d.id);
        System.debug('######## document content type: '+d.type);        
  
        System.debug('@@@@@@@@ redirect');
        PageReference page = new PageReference('/apex/FileUpload');
        //page.setRedirect(true);
        return page;   
    }
}