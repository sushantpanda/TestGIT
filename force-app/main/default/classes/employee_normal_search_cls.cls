public with sharing class employee_normal_search_cls {

    public String getSelectedjob() {
        return null;
    }

Public String[] grdData {get;set;}
Public String[] emailAddress {get;set;}
public string job{get;set;}
public List<string> joblist {get;set;}
public List<string> searchStringlist {get;set;}
public Set<String> jobid {get;set;}
public string selectedjob{get;set;}
public List<string> selectedjobs{get;set;}
public boolean datacheck{get;set;}
public string searchstring{get;set;}
 Public String candidateid{get;set;} 
 public String [] array1{get;set;}
public  employee_normal_search_cls()
{
    try
    {
         candidateid = ApexPages.currentPage().getParameters().get('id');
        datacheck=false;
        searchstring='Enter skills';
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
    List<Applied_Job__c> alreadyapplyiedjobs = [select jobid__c from Applied_Job__c where Candidate__c=:candidateid];
    
    for(integer l=0; l<alreadyapplyiedjobs.size();l++)
    {
        alreadyjobs.add(alreadyapplyiedjobs[l].jobid__c);
    }
    
    for(Job_Posting__c jobs : [select id ,skill__c from Job_Posting__c where status__c !='hot' and     jobid__c not in : alreadyjobs ])
    {
       
        
         job=jobs.skill__c;
         joblist=job.split(',');
         
         
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
    
    for(Job_Posting__c finaljobs :[select id,Jobid__c,experience_required__c, skill__c from   job_posting__c where id=:jobid])
    {
       

  //  employer='<a href=\'/apex/company_view_page?id='+ finaljobs.Employer__c +'\' target=\'_blank\'>'+(finaljobs.Employer__r.name == null?'':finaljobs.Employer__r.name)+'</a>';



        grdData.add('["","'+ (finaljobs.Jobid__c== null?'':finaljobs.Jobid__c)+'","'+ finaljobs.experience_required__c  + '","'+finaljobs.Skill__c +'"]');
    }
    
       if(grdData.size()==0)
        {
             grdData.add('["","<b><font color=blue>0 Jobs</font></b>", "","", "",""]');
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
    Job_Posting__c appliedjobs=[select  Name,Jobid__c,experience_required__c,Account__c,Job_Location__c,skill__c,status__c from Job_Posting__c where Jobid__c=:selectedjobs[k]];
     Applied_Job__c appJobs= new  Applied_Job__c();
      appJobs.Name='jobapplied';
     System.debug('__________job code________'+appliedjobs.Jobid__c);
      appJobs.Jobid__c=appliedjobs.Jobid__c;
      appJobs.Employername__c=appliedjobs.Account__c;
      appJobs.location__c=appliedjobs.Job_Location__c;
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
        Candidate__c can=[select name,Email__c, phone_no__c from Candidate__c  where id=:candidateid ];
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

         //   body += can.name + '</b> has appled the job which is posted by your organization with job code <b>'+array1[1]+' <br/>';

           body += '\n His Contact Details are following. <br/>';
           body += '\n Email Id: ' + can.Email__c + '<br/>';
           body += '\n Contact No.' + can.phone_no__c + '<br/>' ;

           mail.setHtmlBody(body);
            
          //  mails.add(e);      
           }                    

            try {
  System.debug('############@'+mails.size());
                Messaging.sendEmail(mails);

            } catch(Exception ex) {         

            }
       
        
    }}