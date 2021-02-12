trigger check on contact(before insert) {
   for(contact a : Trigger.New)
   a.accountid = '0019000000DKx8X';
  }