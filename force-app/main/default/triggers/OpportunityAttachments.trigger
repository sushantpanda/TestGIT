trigger OpportunityAttachments on Attachment (after insert,after delete) {
map<id,list<attachment>> attach=new map<id,list<attachment>>();
list<Opportunity> opp =new  list<Opportunity>();
if(Trigger.isInsert){
  for(Attachment a: Trigger.new)
	{
      Id myId = a.parentid;  
         system.debug('1111'+myId);
	  if(myId.getSobjectType()==Schema.Opportunity.SObjectType){
		if(attach.containsKey(a.parentid)) {
                List<attachment> at =attach.get(a.parentid);
                attach.put(a.parentid,at);
       	 } else {
                attach.put(a.parentid, new List<attachment>{a});
        }
      }
    }
    list<Opportunity> ops=[select id,Attachment_Count__c from Opportunity where id in:attach.keyset()];
	for(Opportunity opp1:ops)
		{
            system.debug('aaa'+attach);
		list<attachment> acc= attach.get(opp1.id);
	system.debug('nnnnn'+acc);
             system.debug('bbttttttt'+(Integer)acc.size()+'jjjj'+opp1.Attachment_Count__c);
            system.debug('bbbbbbb'+opp1.Attachment_Count__c);
		if(opp1.Attachment_Count__c !=0)
			{
			 opp1.Attachment_Count__c= opp1.Attachment_Count__c+(Integer)acc.size();
			 opp.add(opp1);
			}
			else{
				 opp1.Attachment_Count__c=(Integer)acc.size();
				 opp.add(opp1);
                system.debug('llllll'+opp);
				}
		}
if(opp.size()>0){
update opp;
}

}
if(Trigger.isdelete){
for(Attachment aa: Trigger.old)
	{
      Id myId = aa.parentid; 
       system.debug('1111'+myId);
	  if(myId.getSobjectType()==Schema.Opportunity.SObjectType){
		if(attach.containsKey(aa.parentid)) {
                List<attachment> at =attach.get(aa.parentid);
                attach.put(aa.parentid,at);
       	 } else {
                attach.put(aa.parentid, new List<attachment>{aa});
        }
      }
    }
    list<Opportunity> ops=[select id,Attachment_Count__c from Opportunity where id in:attach.keyset()];
	for(Opportunity op:ops)
		{
            system.debug('aaa'+attach);
		list<attachment> acc= attach.get(op.id);
            system.debug('nnnnn'+acc);
		
            system.debug('bbttttttt'+(Integer)acc.size()+'jjjj'+op.Attachment_Count__c);
            if(op.Attachment_Count__c-(Integer)acc.size()==0){
			 op.Attachment_Count__c= 0;
                system.debug('bbbbbbb'+op.Attachment_Count__c);
                opp.add(op);
            }
            else{
                op.Attachment_Count__c=op.Attachment_Count__c-(Integer)acc.size();
			 opp.add(op);
            }
			system.debug('bbbbbbb22222'+opp);
             
		}
if(opp.size()>0){
update opp;
}
      }
}