public class opportunityList2Con {
    public Boolean ss=true;
     public Blob body {get;set;}
    public void GO() {
     PageReference pdf = new PageReference('/apex/actionpoller'); 
            pdf.setRedirect(true);
            if(ss){
                body = pdf.getContent();
                system.debug('----------body --------'+body );
            }
            else
                body =  Blob.valueof('Dummy Content in email body for Apex Test Run');
                
                Messaging.EmailFileAttachment emailattach = new Messaging.EmailFileAttachment();
            emailattach.setContentType('application/pdf');
            string strSubject = 'Bestilling af YouSee ';
            emailattach.setFileName('.pdf');
            emailattach.setInline(false);
            emailattach.Body = body;
           
           
            Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
            // Assign the addresses for the To and CC lists to the mail object. 
            string[] ss=new String[]{'sushant.panda@capgemini.com'}; 
            mail.setToAddresses(ss);
            // mail.setCcAddresses(ccAddresses);
            mail.setSubject('hello ');
            string strBody;
            strBody= ' Hi , '; 
            strBody= strBody+' Kindly find the form attached with the mail. <br>';
            strBody= strBody+ '<br></br>';
            strBody= strBody+' Regards, <br>';
            
            mail.setHtmlBody(strBody);
            //Id emailTemplateId = [select Id from EmailTemplate where Name = 'YouSee Dealer Web: Manual Orders'].Id;
            //mail.setTemplateId(emailTemplateId);
                   
            //Commented for testing other funcationality.
             mail.setFileAttachments(new Messaging.EmailFileAttachment[] { emailattach});
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            
       
    }

    // ApexPages.StandardSetController must be instantiated
    // for standard list controllers
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

    // Initialize setCon and return a list of records
    public List<Opportunity> getOpportunities() {
        return (List<Opportunity>) setCon.getRecords();
    }
}