trigger checkacc on account(before insert) 
 {
  for(account a : Trigger.New)
     a.name= 'checkacc';
  }