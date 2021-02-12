trigger UpdateEvent on Event (after insert,after update,after delete) 
{

    List<Account> AccList;
    Set<Id> Eidset;
    
    if(trigger.isinsert || trigger.isupdate){
        AccList=new List<Account>();        
        Eidset=new Set<Id>();
        for(Event E:trigger.new)
        {
            Eidset.add(E.WhatId);
        }
        List<Event> EL=[Select id, whatid, ActivityDate from Event where WhatId IN :Eidset];
        
        Map<Id, Account> MapAEvent=new Map<Id, Account>();
        Map<Id, Event> MapAcEvent=new Map<Id, Event>();
        
        for(Event E: EL){
            if(MapAcEvent.containskey(E.whatid)){
                Event EN=MapAcEvent.get(E.whatid);
                if(EN.Activitydate<E.Activitydate){
                    MapAcEvent.put(E.whatid, E);    
                }         
   
            }
            else{
                MapAcEvent.put(E.whatid, E);
            }
        }
        
        AccList=[Select dateevent__c,id from Account where id IN :Eidset];
        for(Account A:AccList){
            MapAEvent.put(A.id, A);
        }
        
        Account Acc;
        Integer RecCount=0;
        for(Event E:trigger.new){                       
            if((E.whatid!=null)&&(MapAEvent.get(E.Whatid).dateevent__c!=null)){
                if(MapAEvent.get(E.Whatid).dateevent__c<E.ActivityDate){
                    Acc=new Account();
                    Acc=MapAEvent.get(E.whatid);
                    Acc.dateevent__c=E.ActivityDate;
                  /*  if(MapAcEvent.containskey(E.whatid))
                    {
                        Event Enew=MapAcEvent.get(E.Whatid);
                        if(Enew.ActivityDate>Acc.dateevent__c){
                            Acc.dateevent__c=Enew.ActivityDate;
                        }
                                                
                    }*/
                    MapAEvent.put(E.whatid, Acc);
                    RecCount+=1;
                }     
                             
            }
            else{
                Acc=new Account();
                Acc=MapAEvent.get(E.whatid);
                Acc.dateevent__c=E.ActivityDate;
                if(MapAcEvent.containskey(E.whatid)){
                        Event Enew=MapAcEvent.get(E.Whatid);
                        if(Enew.ActivityDate>Acc.dateevent__c){
                            Acc.dateevent__c=Enew.ActivityDate;
                        }
                    }
                MapAEvent.put(E.whatid, Acc);
                RecCount+=1;
            }
        }
        if(RecCount>0){
            AccList=MapAEvent.values();
            update AccList;
        }
    }
}