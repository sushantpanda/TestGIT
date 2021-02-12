Trigger accounttest on account (before insert, before update)
{
    set<ID> ids = Trigger.newMap.keySet();
    system.debug('aaaaaaaaaaaaaaaaaaaa'+ids);
    list<account> ac = [SELECT Id,name,employee_email__c,password__c FROM account WHERE Id in :ids];
    system.debug('+++++accc++'+ac);

}