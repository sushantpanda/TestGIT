global class scheduleEmailSending_test Implements Schedulable
{
    
public String [] array1{get;set;}
Public String[] emailAddress {get;set;}
public string job{get;set;}
public List<string> joblist {get;set;}
public List<string> searchStringlist {get;set;}
public List<String> jobid {get;set;}
public List<String> jobmatch {get;set;}
public List<String> candidatelist {get;set;}

public string searchstring{get;set;}
public List<Job_Posting__c> jobs{get;set;}
Map<String, list<String>> mailsend = new Map<string,list<string>>();
public  scheduleEmailSending_test()
{
     jobs=new  List <Job_Posting__c>();
}
   global void execute(SchedulableContext sc)
    {
                getcandidtaes();
    }
    public void getcandidtaes()
    {
        try
        {

        jobid=new List<String>();
        
             jobs=[select id ,jobid__c,skill__c from Job_Posting__c where status__c !='Closed' ];
            List<Candidate__c>  candidate=[select name,Email__c,password__c,address__c,cv_id__c,image_id__c,street__c,city__c,date_of_birth__c,age__c,state_province__c,country__c,current_employee__c,name_of_employee__c,skill__c,year_of_experience__c,higest_education__c,email_alert_on_new_job__c,enable_profile_for_employee__c from candidate__c where  Skill__c!=null  AND email_alert_on_new_job__c=true ];
           
        
        
        for(integer candidatecounter=0;candidatecounter<candidate.size();candidatecounter++)
      {
        
        
        
            for(integer jobcounter=0;jobcounter<jobs.size();jobcounter++)
            {
                
                job=jobs[jobcounter].Skill__c;
                 System.debug('--------------------'+job);
                joblist=job.split(',');
                
                    integer count=0;
                     searchstring=candidate[candidatecounter].Skill__c;
                      System.debug('hhhhhhhhhhhhhhhhhhhhh'+searchstring);
                     searchStringlist=searchstring.split(',');
                     
                     
                         for(integer i=0;i<searchStringlist.size();i++)      
                     {
                            for(integer j=0;j<joblist.size();j++)
                        {
                         
                            if(searchStringlist[i].toLowerCase()==joblist[j].toLowerCase())
                            {
                                count++;
                                
                                                                                           
                            }
                         }
                         
                         
                     }
                     if(count>0)
                     {
                          jobid.add(jobs[jobcounter].jobid__c);
                          
                      }
            }
            
            candidatelist.add(candidate[candidatecounter].id);
            mailsend.put(candidate[candidatecounter].id,jobid);
            
      }
             
             
        System.debug('@@@@@@@@@@'+jobid);
     
        email();
      }
      
      catch(Exception e)
      {
          System.debug(e);
      }

        
    }
    public void email()
    {
        try
        {
          List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
      //   System.debug('pppppppppppp'+lst.size());
         for(integer i=0;i<mailsend.size();i++)
         {
            // array1=new String[]{};
           // array1=lst[i].split(',');
          //   System.debug('rrrrrrr'+array1[0]);
          //   System.debug('qqqqqqqq'+array1[1]);
             Candidate__c can=[select name,Email__c,password__c,address__c,cv_id__c,image_id__c,street__c,city__c,date_of_birth__c,age__c,state_province__c,country__c,current_employee__c,name_of_employee__c,skill__c,year_of_experience__c,higest_education__c,email_alert_on_new_job__c,enable_profile_for_employee__c from Candidate__c  where id=:candidatelist[0] limit 1];
             
               system.debug('ssssssssssssssssssssssssssssssssss'+can);           
             Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();                     
                String[] toAddresses = new String[] {can.Email__C}; 
                mail.setToAddresses(toAddresses );
                mail.setSubject('Automated email: Jobs found for you');
                String body = '<b>\n Hello:'+ can.Name+'</B> <br/>';
                body += 'We have job Matching your skills <B> '+can.Skill__C+ '</B> with Job Code'+mailsend.get(can.id)+'<br/>';
                 body += 'You Can apply for this job';
                system.debug('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz'+mailsend.get(can.id));     

                mail.setHtmlBody(body);
                 mails.add(mail);
                }
                                   

                try {
                 System.debug('@@@@############@@'+mails);

                    Messaging.sendEmail( mails);

                } catch(Exception ex)
                {         
                        System.debug('@@@@###Exception########@@'+ex);
                }
         
       }
       
        catch(Exception e)
      {
          System.debug(e);
      }  
        
    }

    
        
    }