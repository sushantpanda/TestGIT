trigger checkafter on contact (after update) {

for(Contact con: trigger.new ){
system.debug('trigger.new'+con);
system.debug('trigger.old'+system.Trigger.oldmap.get(con.id));

}

System.debug('##trigger.new##'+trigger.new);
System.debug('##trigger.Old##'+trigger.old);

}