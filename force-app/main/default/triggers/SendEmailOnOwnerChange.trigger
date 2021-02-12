trigger SendEmailOnOwnerChange on Account (after update) {
system.debug('trigger.old'+trigger.old);
system.debug('trigger.new'+trigger.new);
/*
    if (trigger.old[0].OwnerId != trigger.new[0].OwnerId) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String emailAddr =[select Email from User where Id = :trigger.old[0].OwnerId].Email;
        String newOwnerName = [select Name from User where Id = :trigger.new[0].OwnerId].Name;

        String[] toAddresses = new String[] {emailAddr};
        mail.setToAddresses(toAddresses);

        mail.setSubject('ALERT-Owner Changed for Account : ' + trigger.new[0].Name);

        mail.setPlainTextBody('Owner of Account: ' + trigger.new[0].Name + ' Changed to ' + newOwnerName);
        mail.setHtmlBody('Owner of Account: <b>' + trigger.new[0].Name + '</b> Changed to <b>' + newOwnerName  + '</b>');

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    */
    
}