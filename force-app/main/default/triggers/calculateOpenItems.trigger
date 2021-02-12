trigger calculateOpenItems on Task (after insert,before delete,before update)
{
    Map<Id,Id> objSetTaskId = new Map<Id,Id>();
    Set<Id> objSet = new Set<Id>();
    for(Task ObjTsk : Trigger.New)
    {
        if(ObjTsk.Status.contains('In Progress') )
        {
        objSetTaskId.put(ObjTsk.Id,ObjTsk.WhatId);
        system.debug('++++'+objSetTaskId);
        objSet.add(ObjTsk.WhatId);
        }
    }
List<Task> TotalTsk = [Select id,CallType,Description from Task where whatId in : objSet];
if(Trigger.Isinsert)
{
for(Task objtskcnt : [Select id,CallType,Description from Task where whatId in : objSet])
{
if(objSetTaskId.get(objtskcnt.Id) != null)
{
Account objAcc = new Account(id= objSetTaskId.get(objtskcnt.Id));
objAcc.AccountNumber = String.ValueOf(TotalTsk.size());
update objAcc;
}
}
}
}