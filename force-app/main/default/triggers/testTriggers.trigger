trigger testTriggers on Opportunity (after insert,before Insert,before Update,after update) {
    if(trigger.isafter && trigger.isInsert){
        system.debug('trigger.new'+trigger.new);
        system.debug('trigger.old'+trigger.old);
    }
    if(trigger.isBefore && trigger.isInsert){
        system.debug('trigger.new'+trigger.new);
        system.debug('trigger.old'+trigger.old);
    }
    
    if(trigger.isBefore && trigger.isUpdate){
        system.debug('trigger.new'+trigger.new);
        system.debug('trigger.old'+trigger.old);
    }
    
    if(trigger.isAfter && trigger.isUpdate){
        system.debug('trigger.new'+trigger.new);
        system.debug('trigger.old'+trigger.old);
    }
}