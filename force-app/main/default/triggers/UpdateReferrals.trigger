trigger UpdateReferrals on Lead (after insert) {

  Set<Id> createdByIds = new Set<Id>();
  List<Id> referralIds = new List<Id>();
  
  for (Lead l : trigger.new){
    createdByIds.add(l.CreatedById);
  }
  
  // Return all users that created Leads in this trigger
  Map<Id, User> creator = new Map<Id, User>([Select  UserType FROM User WHERE Id IN :CreatedByIds]);
  
  // Find all of the PowerPartner users who created a Lead in this trigger
  for (Lead l : trigger.new){
    if (creator.get(l.CreatedById).UserType == 'PowerPartner'){
      referralIds.add (l.Id);
    }
  }      
  
  // Get all of the Leads owned by PowerPartner users discovered above
  List<Lead> referrals = new List<Lead>([SELECT CreatedById, Name, Company FROM Lead WHERE ID in :referralIds]);
   List<Lead> refe=new list<lead>();
  // Loop through all of those Leads
  for (Lead l : referrals){
    
    // Set the Partner Sales Rep to the creator of the Lead
  //  l.Partner_Sales_Rep__c = l.CreatedById;

    // Get the divisions of the Partner Sales Rep (From its contact record)
  //  l.Divisions__c = creator.get(l.CreatedById).Contact.Divisions__c;
    
    // Set the singular division on the Lead if the Partner only has one division
 //   if (creator.get(l.CreatedById).Contact.Divisions__c.indexOf(';', 0) == -1){
   //   l.Division__c = creator.get(l.CreatedById).contact.Divisions__c;
    //}
   
  // refe.add(l);


}
update referrals;

}