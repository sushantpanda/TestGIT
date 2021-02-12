public class jobseeker_normal_search_cls
{

Transient Public String[] grdData {get;set;}
Transient Public String[] emailAddress {get;set;}
Transient public string job{get;set;}
Transient public List<string> joblist {get;set;}
Transient public List<string> jobs {get;set;}
Transient public List<string> searchStringlist {get;set;}
Transient public Set<String> jobid {get;set;}
Transient public string selectedjob{get;set;}
public List<string> selectedjobs{get;set;}
Transient public boolean datacheck{get;set;}
Transient public string searchstring{get;set;}
Transient Public String candidateid{get;set;} 
Transient public String [] array1{get;set;}
public  jobseeker_normal_search_cls()
{
    try
    {
         candidateid = ApexPages.currentPage().getParameters().get('id');
        datacheck=false;
        searchstring='Enter your skills ';
    }
    
    catch(Exception e)
    {
        System.debug(e);
    }
   
}

public void getgrdData()
{
    try
    {

    grdData =new String[]{};
    jobid=new Set<String>();
     searchStringlist=searchstring.split(',');
     List <string>  alreadyjobs = new List<string>();
    List<Applied_Job__c> alreadyapplyiedjobs = [select jobid__C from Applied_Job__c where Candidate__c=:candidateid];
    
    for(integer l=0; l<alreadyapplyiedjobs.size();l++)
    {
        alreadyjobs.add(alreadyapplyiedjobs[l].jobid__C);
    }
    
    for(Job_Posting__c jobs : [select id ,Skill__c from Job_Posting__c where status__c !='hot' and Jobid__c not in : alreadyjobs ])
    {
       
        
         job=jobs.Skill__c;
         if(job!=null && job!='' )
         {
             joblist=job.split(',');
         }
         
         
             //candiadte=searchstring;
            
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
    
    for(Job_Posting__c finaljobs :[select id,Jobid__c,account__r.name,account__c,Name,Experience_Required__c,Job_Location__c,Skill__c from Job_Posting__c where id=:jobid ORDER By date__c desc limit 50])
    {
        // string employer='';
        //employer='<a href=\'https://ap1.salesforce.com/'+ finaljobs.id +'\' target=\'_blank\'>'+'</a>';
        //grdData.add('["","'+ (finaljobs.Job_Code__c== null?'':finaljobs.Job_Code__c)+'","'+ (finaljobs.Name== null?'':finaljobs.Name)+'","'+ finaljobs.Employer__r.name+'","'+ finaljobs.Experience_Required__c  + '","'+finaljobs.Skills_Required__c +'","'+ (finaljobs.Job_Location__c== null?'':finaljobs.Job_Location__c) +'"]');
     string employer='';

employer='<a href=\'/apex/representemp?cid='+ finaljobs.account__c +'\' target=\'_blank\'>'+(finaljobs.account__r.name == null?'':finaljobs.account__r.name)+'</a>';



        grdData.add('["","'+ (finaljobs.Jobid__c== null?'':finaljobs.Jobid__c)+'","'+ (finaljobs.Name== null?'':finaljobs.Name)+'","'+ finaljobs.Experience_Required__c  + '","'+finaljobs.Skill__c +'","'+ (finaljobs.Job_Location__c== null?'':finaljobs.Job_Location__c) +'","'+employer +'"]');
    }
    
       if(grdData.size()==0)
        {
             grdData.add('["","<b><font color=red>0 Jobs</font></b>", "","", "",""]');
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
      if(selectedjob.length()>0)
      { 
    selectedjobs=selectedjob.split(';');
    System.debug('----selectedjobs--------'+selectedjobs.size());
    for(integer k=0;k<selectedjobs.size();k++)
    {
     Job_Posting__c appliedjobs=[select Jobid__c,Name,account__r.name from Job_Posting__c where Jobid__c=:selectedjobs[k]];
     Applied_Job__c appJobs= new  Applied_Job__c();
      appJobs.Name='Test';
      System.debug('__________job code________'+appliedjobs.Jobid__c);
      appJobs.Jobid__c=appliedjobs.Jobid__c;
      appJobs.name=appliedjobs.Name;
   //   appJobs.Employer_Name__c=appliedjobs.account__r.name;
      appJobs.Candidate__c=candidateid;
      insert appJobs;
      System.debug('__________ID________'+appJobs.id);
      //grdData.clear();
      
       Contact con=[select id,email from contact where accountid in(select account__c from job_posting__c where Jobid__c=:appliedjobs.Jobid__c)];
       emailAddress.add(con.id+','+appliedjobs.Jobid__c);
      
    }
     sendEmailtoEmployer(emailAddress);  
    }
    getgrdData();
    }
    catch(Exception e)
      {
          System.debug(e);
      }
     
}
public void sendEmailtoEmployer( String [] jobcode)
    {
         System.debug('@@@@@@@@@@@@@'+jobcode);
          List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Candidate__c can=[select name,Email__c from Candidate__c  where id=:candidateid ];
        for(integer i=0;i<jobcode.size();i++)
        {
            array1=new String[]{};
        array1=jobcode[i].split(',');
         Contact con=[select id,name,email from contact where id=:array1[0]];
         
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();       
        System.debug('___________________________'+con.email);              

            String[] toAddresses = new String[] {con.email}; 

            mail.setToAddresses(toAddresses);

            mail.setSubject('Automated email: Job Applied');

          String body = '<b>\n Hello: '+con.name + '</B> <br/>';

            body += can.Name+ '</b> has appled the job which is posted by your organization with job code <b>'+array1[1]+' <br/>';

            body += '\n His Contact Details are following. <br/>';
            body += '\n Email Id: ' + can.Email__c + '<br/>';
           // body += '\n Contact No.' + can.Contact_No__c + '<br/>' ;

            mail.setHtmlBody(body);
            mails.add(mail);
            
           }                    

            try {
  System.debug('############@'+mails.size());
                Messaging.sendEmail(mails);

            } catch(Exception ex) {         

            }
       
        
    }

public static testMethod void jobseeker_normal_search_cls()
     {
        try
        { 
          
            Test.setCurrentPage(Page.search);
             jobseeker_normal_search_cls obj =new jobseeker_normal_search_cls();
           
             Account acc= new Account(name='test',employee_email__c='user@gmail.com',password__c='p');
            insert acc;
            Job_posting__c job1 =new Job_Posting__c(Name='testjob',Skill__c ='c,c++,java,apex',experience_required__c=2,status__c='cold',Job_Location__c='delhi',salary__c='3',Account__c=acc.id);
            insert job1;
            obj.searchstring='c,c++,java,sql,apex';
            obj.selectedjob='J-01'+ ';';
            obj.getgrdData();
             Job_posting__c job2 =new Job_Posting__c(Name='testjob',Skill__c ='c,c++,java,apex',experience_required__c=2,status__c='cold',Job_Location__c='delhi',salary__c='3',Account__c=acc.id);
            //job2.jobid__c='J-20';
            insert job2; 
            
            System.debug('@@@@'+job2.jobid__c);
            obj.selectedjob='J-01'+ ';';
            Contact Con=new Contact(Lastname='test');
           
            insert con;
            candidate__C can1=new candidate__C(name='testing');
             insert can1;
               
            Job_Posting__c jbjobs1=new Job_Posting__C(Name='testjob',Skill__c ='c,c++,java,apex',experience_required__c=2,status__c='cold',Job_Location__c='delhi',salary__c='3',Account__c=acc.id);
            insert jbjobs1;
             Applied_Job__c appJobs= new  Applied_Job__c(name='test',Candidate__c=can1.id);
             insert appJobs;
            obj.insertinjobapplied();
            
            Job_Posting__c jbjobs=new Job_Posting__C(Name='testjob',Skill__c ='c,c++,java,apex',experience_required__c=2,status__c='cold',Job_Location__c='delhi',salary__c='3',Account__c=acc.id);
            insert jbjobs;
            
           // obj.selectedjobs='C-01,C-02';
              candidate__C can=new candidate__C(name='testing');
             insert can;
              obj.candidateid =can.id;
            string[] emailAddress =new String[]{}; 
           emailAddress.add(con.id+','+'J-01');
            obj.sendEmailtoEmployer(emailAddress);
         
        }
        
        
         catch(Exception e)
         {
             System.debug(e);
         }
      } 
}