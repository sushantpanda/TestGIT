global class Scheduledevent Implements Schedulable
            {
                        list<account> accountsave =new list<account>();
                       global void execute(SchedulableContext sc)
                        {
                                    checkevent();
                        }
                        public void checkevent()
                        {  
                        
                           for(account acc:[select name from account ])
                           {
                           system.debug('+++++acc++'+acc);
                           list<event> e= [select Id,WhatId,StartDateTime,EndDateTime,Subject from Event where WhatId=:acc.Id AND StartDateTime < :system.Now() ORDER BY StartDateTime desc limit 1 ]; 
                           system.debug('+++++event++'+e);
                           if(e.size()>0)
                           {
                           acc.dateevent__c=e[0].StartDateTime;
                           accountsave.add(acc);
                           }
                           if(e.size()==0)
                           {
                           acc.dateevent__c=null;
                           accountsave.add(acc);
                           }
                           }
                           system.debug('+++++accountsave++'+accountsave);
                           update accountsave;
                        }
            }