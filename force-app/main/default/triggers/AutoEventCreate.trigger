trigger AutoEventCreate on Opportunity (after insert , after update) {

List <Event> eventList = new List <Event> ();
Set<Id> oppIds = new Set<Id>();
if(Trigger.isInsert) {
for(Opportunity opp:Trigger.new){
if(opp.Probability !=null && opp.Probability>=50.00){

datetime myDate = datetime.now();



eventList.add (new Event(
Subject = 'Other',
WhatId = opp.Id,
OwnerId = opp.OwnerId,
StartDateTime = DateTime.Now(),
ActivityDateTime=null,
EndDateTime = DateTime.Now(),
DurationInMinutes = Integer.valueOf(Math.Floor( (myDate.getTime() - myDate.getTime()) / (1000.0*60.0)))

));

}
if(eventList.size() > 0)

insert eventList;

}

}
If(Trigger.isUpdate)
{
for(Opportunity opp:Trigger.new){
if(opp.Probability !=null && opp.Probability>=50.00 )
{
Opportunity opp1=trigger.oldmap.get(opp.id);
if(opp1.probability<=50.00){
datetime myDate = datetime.now();



eventList.add (new Event(
Subject = 'Other',
WhatId = opp.Id,
OwnerId = opp.OwnerId,
StartDateTime = DateTime.Now(),
ActivityDateTime=null,
EndDateTime = DateTime.Now(),
DurationInMinutes = Integer.valueOf(Math.Floor( (myDate.getTime() - myDate.getTime()) / (1000.0*60.0)))

));

}
if(eventList.size() > 0)

insert eventList;

}


}
}

}