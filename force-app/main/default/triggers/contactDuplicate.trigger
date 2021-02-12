trigger contactDuplicate on contact
(before insert, before update) {
Map<String, contact> contactMap = new Map<String, contact>();
for (contact contact : System.Trigger.new) {
system.debug(System.Trigger.oldMap);
// Make sure we don't treat an email address that
if ((contact.Email != null) &&
(System.Trigger.isInsert ||
(contact.Email != System.Trigger.oldMap.get(contact.Id).Email))) {
// Make sure another new contact isn't also a duplicate
system.debug(contactMap.values());
if (contactMap.containsKey(contact.Email)) {
contact.Email.addError('Another new contact has the '
+ 'same email address.');
} else {
contactMap.put(contact.Email, contact);
}
}
}
// Using a single database query, find all the contacts in
// the database that have the same email address as any
// of the contacts being inserted or updated.
for (contact contact : [SELECT Email FROM contact
WHERE Email IN :contactMap.KeySet()]) {
contact newcontact = contactMap.get(contact.Email);
newcontact.Email.addError('A contact with this email '
+ 'address already exists.');
}
}