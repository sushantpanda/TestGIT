public class advanceSearch_class
{
Transient public integer experience{get;set;}
Transient public String [] array1{get;set;}
Transient public integer min_pay{get;set;}
Transient public integer max_pay {get;set;}
Transient public string job_location{get;set;}
Transient public string skills{get;set;}
Transient Public String[] grdData {get;set;}
Transient Public String[] emailAddress {get;set;}
Transient public string job{get;set;}
Transient public List<string> joblist {get;set;}
Transient public List<string> searchStringlist {get;set;}
Transient public List<string> job_location_list {get;set;}
Transient public Set<String> jobid {get;set;}
Transient public string selectedjob{get;set;}
Transient public List<string> selectedjobs{get;set;}
Transient public boolean datacheck{get;set;}
Transient public string searchstring{get;set;}
Transient Public String candidateid{get;set;} 

public advanceSearch_class()
{
    //datacheck=false;
    try
    {
        candidateid = ApexPages.currentPage().getParameters().get('id');
        searchstring='Enter skills';
    }
     catch(Exception e)
      {
          System.debug(e);
      }
}

public void data()
{
    try
    {
    System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@');
    System.debug('@@'+experience);
    System.debug('@@'+min_pay);
    System.debug('@@'+max_pay );
    System.debug('@@'+job_location);
    System.debug('@@'+searchstring);
   
    
    grdData =new String[]{};
    jobid=new Set<String>();
    if(searchstring.length()>0)
     {
     searchStringlist=searchstring.split(',');
     }
     if(job_location.length()>0)
     {
         job_location_list=job_location.split(',');
     }
     List <string>  alreadyjobs = new List<string>();
    List<Applied_Job__c> alreadyapplyiedjobs = [select jobid__C from Applied_Job__c where Candidate__c=:candidateid  ];
    
    for(integer l=0; l<alreadyapplyiedjobs.size();l++)
    {
        alreadyjobs.add(alreadyapplyiedjobs[l].jobid__C);
    }
    
    
   // List<Job_Posting__c> jobs=new List<Job_Posting__c>();
    if(searchstring.length()>0 &&  job_location.Length()>0)
    {
        System.debug('@@@@@@@@@@@@@@@@@@@ First If');
      for(Job_Posting__c jobs : [select id ,Skill__c from Job_Posting__c where status__c !='Closed' and Jobid__c not in : alreadyjobs AND (Job_Location__c like : job_location +'%' OR Job_Location__c=:job_location_list ) AND (Experience_Required__c>=:experience AND Experience_Required__c<=:experience+1 )limit 50] )
        {
            
            job=jobs.Skill__c;
             joblist=job.split(',');
             
                 for(integer j=0;j<joblist.size();j++)
                 {
                 
                     for(integer i=0;i<searchStringlist.size();i++)      
                     {
                     
                        if(joblist[j].toLowerCase().startsWith(searchStringlist[i].toLowerCase())|| joblist[j].toLowerCase().endsWith(searchStringlist[i].toLowerCase())|| joblist[j].toLowerCase().contains(searchStringlist[i].toLowerCase()))
                         // if(joblist[j]==candiadtelist[i])
                         {
                            jobid.add(jobs.id);
                         }
                     }
                 }
             
             
        }
      }
      
      else if(searchstring.Length()>0 && job_location.length()<=0)
      {
           System.debug('@@@@@@@@@@@@@@@@@@@ Second If');
        for(Job_Posting__c jobs : [select id ,Skill__c from Job_Posting__c where status__c !='Closed' and Jobid__c not in : alreadyjobs AND (Experience_Required__c>=:experience AND Experience_Required__c<=:experience+1 )limit 50] )
        {
            
            job=jobs.Skill__c;
            joblist=job.split(',');
             
                 for(integer j=0;j<joblist.size();j++)
                 {
                 
                     for(integer i=0;i<searchStringlist.size();i++)      
                     {
                     
                        if(joblist[j].toLowerCase().startsWith(searchStringlist[i].toLowerCase())|| joblist[j].toLowerCase().endsWith(searchStringlist[i].toLowerCase())|| joblist[j].toLowerCase().contains(searchStringlist[i].toLowerCase()))
                         // if(joblist[j]==candiadtelist[i])
                         {
                           jobid.add(jobs.id);
                         }
                     }
                 }
             
             
        }
      }
      
       else if(searchstring.Length()<=0 && job_location.Length()>0)
      {
           System.debug('@@@@@@@@@@@@@@@@@@@ Third If');
        for(Job_Posting__c jobs : [select id ,Skill__c from Job_Posting__c where status__c !='Closed' and Jobid__c not in : alreadyjobs AND (Job_Location__c like : job_location +'%' OR Job_Location__c=:job_location_list )  AND (Experience_Required__c>=:experience AND Experience_Required__c<=:experience+1 )limit 50] )
        {
            
           job=jobs.Skill__c;
           joblist=job.split(',');
             
                 for(integer j=0;j<joblist.size();j++)
                 {
                         jobid.add(jobs.id);
                 }
         
        }
      }
        for(Job_Posting__c finaljobs :[select id,name,Jobid__c,experience_required__c, skill__c,account__c,account__r.name,date__c, Job_Location__c from   job_posting__c  where id=:jobid ORDER By date__c Desc limit 50])
        {
            system.debug('___________________________________________________'+finaljobs );
             string employer='';
             //employer='<a href=\'/apex/company_view_page?id='+ finaljobs.Employer__c +'\' target=\'_blank\'>'+(finaljobs.Employer__r.name == null?'':finaljobs.Employer__r.name)+'</a>';
            employer='<a href=\'/apex/representemp?cid='+ finaljobs.account__c +'\' target=\'_blank\'>'+(finaljobs.account__r.name == null?'':finaljobs.account__r.name)+'</a>';
            system.debug('+++++++++++++++++++++++++++++++++++++'+finaljobs.account__r.name);
          grdData.add('["","'+ (finaljobs.Jobid__c== null?'':finaljobs.Jobid__c)+'","'+ (finaljobs.Name== null?'':finaljobs.Name)+'","'+ employer +'","'+ finaljobs.experience_required__c +'","'+finaljobs.Skill__c +'","'+ (finaljobs.Job_Location__c== null?'':finaljobs.Job_Location__c)+'"]');
        }
    
       if(grdData.size()==0)
        {
             grdData.add('["","<b><font color=red>0 Jobs Found</font></b>", "","", "",""]');
             datacheck=false;
        }
        
        else
        {
        datacheck=true;
        }
    }
     catch(Exception e)
      {
          System.debug(e);
      }
    
    
}


public void insertinjobapplied()
{
      emailAddress =new String[]{};  
      try
      {
      if(selectedjob!=null)
      { 
    selectedjobs=selectedjob.split(';');
    
    for(integer k=0;k<selectedjobs.size();k++)
    {
     Job_Posting__c appliedjobs=[select  Name,Jobid__c,experience_required__c,Account__c,Account__r.name,Job_Location__c,skill__c,status__c from Job_Posting__c where Jobid__c=:selectedjobs[k] limit 20];
     Applied_Job__c appJobs= new  Applied_Job__c();
      appJobs.Name='Test';
      System.debug('__________job code________'+appliedjobs.Jobid__c);
      appJobs.Jobid__c=appliedjobs.Jobid__c;
      appJobs.Employername__c=appliedjobs.Account__r.name;
      appJobs.Employername__c=appliedjobs.Account__r.name;
      appJobs.location__c=appliedjobs.Job_Location__c;
      
      
     
      insert appJobs;
      System.debug('__________ID________'+appJobs.id);
      //grdData.clear();
      
       Contact con=[select id,email from contact where accountid in(select account__c from job_posting__c where Jobid__c=:appliedjobs.Jobid__c)limit 20];
      
       emailAddress.add(con.id+','+appliedjobs.Jobid__c);
        
    }
    sendEmailtoEmployer(emailAddress);  
    }
    grdData.clear();
    data();
    }
    catch(Exception e)
    {}
        
}
public void sendEmailtoEmployer( String [] jobcode)
    {
         System.debug('@@@@@@@@@@@@@'+jobcode);
          List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Candidate__c can=[select name,Email__c,phone_No__c from Candidate__c  where id=:candidateid ];
        for(integer i=0;i<jobcode.size();i++)
        {
            array1=new String[]{};
        array1=jobcode[i].split(',');
         Contact con=[select id,firstname,email from contact where id=:array1[0]];
         
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();       
        System.debug('___________________________'+con.email);              

            String[] toAddresses = new String[] {con.email}; 

            mail.setToAddresses(toAddresses);

            mail.setSubject('Automated email: Job Applied');

          String body = '<b>\n Hello: '+con.firstname + '</B> <br/>';

            body += can.name + '</b> has appled the job which is posted by your organization with job code <b>'+array1[1]+' <br/>';

            body += '\n His Contact Details are following. <br/>';
            body += '\n Email Id: ' + can.Email__c + '<br/>';
            body += '\n Contact No.' + can.phone_No__c + '<br/>' ;

            mail.setHtmlBody(body);
            mails.add(mail);
            
           }                    

            try {
  System.debug('############@'+mails.size());
                Messaging.sendEmail(mails);

            } catch(Exception ex) {         

            }
       
        
    }
    
    
     
    
    public static testMethod void advanceSearch_class1()
     {
         
           
            Test.setCurrentPage(Page.advanceSearch);
             advanceSearch_class obj =new advanceSearch_class();
             obj.job_location='delhi,fbd';
            obj.insertinjobapplied();
           
             Account acc= new Account(name='test',  employee_email__c='user@gmail.com',password__c='p');
            insert acc;
            Job_posting__c job1 =new Job_Posting__c(Name='testjob',Skill__c ='c,c++,java,apex',Account__c=acc.id,Job_Location__c='Noida',experience_required__c=3,status__c='Hot');
            insert job1;
             obj.job=job1.Skill__c;
             
            obj.searchstring='c,c++,java,sql,apex';
            obj.job_location='Noida';
             
            obj.experience=2;
            obj.data();
           Job_posting__c job2 =new Job_Posting__c(Name='testjob',Skill__c ='c,c++,java,apex',Account__c=acc.id,Job_Location__c='',experience_required__c=0);
            //job2.jobid__c='J-20';
            insert job2;  
             obj.job=job2.Skill__c;
             obj.searchstring='c,c++,java,sql,apex';
           obj.job_location='';
           obj.experience=0;
           
             Applied_Job__c apj=new Applied_Job__c(Employername__c='ssss',location__c='ssss');
            insert apj;
           
           
           
           
            obj.insertinjobapplied();
           
              Contact Con=new Contact(Lastname='test',email='ssss@gmail.com');
            
            insert con;
            
            candidate__C can=new candidate__C(name='testing', Email__c='user@gmail.com',password__c='p');
             insert can;
             obj.candidateid =can.id;
            string[] emailAddress =new String[]{};  
           emailAddress.add(con.id+','+'J-01');
           
          
           
           
           
           
            obj.sendEmailtoEmployer(emailAddress);
            
            
            
            
           
         
            obj.experience=2;
            obj.selectedjob='J-01'+ ';';
           // System.debug('@@@@'+job2.job_code__c);
           
           
            obj.insertinjobapplied();
            Job_Posting__c appliedjobs=new Job_Posting__C(Name='job12');
            insert appliedjobs;
            
           
          
            obj.selectedjob='C-01';
              
             
            
          
       
      }
      }