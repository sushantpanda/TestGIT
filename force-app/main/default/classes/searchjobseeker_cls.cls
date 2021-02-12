public with sharing class searchjobseeker_cls {



       public candidate__c printprof { get; set; } 
     public  Account printemp1{get;set;}
     public String [] str ;
    public string searchvalue{get;set;}
    public list<candidate__c> accountvalue{get;set;}
    public list<candidate__c> value{get;set;}
    public list<candidate__c> value1;
    public list<candidate__c> value2{get;set;}
    public set<id> value3{get;set;}
    public String searching { get; set; }
  //  public list<Account> printacc;
    public contact printemp{get;set;}
    public string accountidd{get;set;}
     public id iddd{get;set;}
   
     public searchjobseeker_cls()
    {
    
    
    iddd=ApexPages.currentPage().getParameters().get('cid');
   
      printemp1 = [select name from Account where id=:ApexPages.currentPage().getParameters().get('cid')];
      value = new list<candidate__c>();
        value1 = new list<candidate__c>();
        value3 = new set<id>();
      str=new String[]{};
        str.add('["","","","",""]');
    }
    
    public String[] getvalue1()
       {
         return str;
       }
      public void search1()
      {
       str=new String[]{};
       system.debug('---------value.size----------'+value1.size());
     if(value1.size()>0)
     {
       value1.clear();
     }
     else
     {
     }
      system.debug('-----------before---------'+searchvalue);
      string trimvalue = searchvalue.trim();
      system.debug('-----------before---------'+trimvalue);
      List<String>ideaSearchText = (trimvalue.Split(','));
      system.debug('---------all----------'+ideaSearchText);
      system.debug('---------111----------'+ideaSearchtext[0]);
    //  system.debug('---------222----------'+ideaSearchText[1]);
      system.debug('---------length----------'+ideaSearchText.size());
      
           // system.debug('---------222----------'+ideaSearchText[2]);
           for(integer i=0;i<ideaSearchText.size();i++)
             {
                 string str1 = '%'+ideasearchText[i]+'%';
                  system.debug('========ideasearchText[i]======'+ideasearchText[i]);
                 system.debug('========searchvalue=='+searchvalue );
                 system.debug('========str1=='+str1 );
                 accountvalue=[select id from candidate__c where skill__c   LIKE :str1 ];
                 system.debug('===========accountvalue============'+accountvalue );
                 value.addall(accountvalue);
                 system.debug('===========value============'+value );
    //           List<tableName> lst = [select field1, field2 from tableName where Id IN : stringList];
                system.debug('======================='+accountvalue );
                }
                value2=value;
                for(integer j=0;j<value2.size();j++)
                {
                system.debug('==========value[j]============='+value2[j].id);
                
                value3.add(value2[j].id);
                }
               value1 =  [select id,name,skill__c,phone_no__c,year_of_experience__c,enable_profile_for_employee__c,state_province__c from candidate__c where id in :value3 and enable_profile_for_employee__c=false limit 50];
               
               system.debug('==========value1============='+value1); 
               accountvalue.clear();
               value.clear();
               value2.clear();
               value3.clear();
              
         // printacc = [select Name, Id,phone from Account  Limit 500];
          for(candidate__c acc:value1) 
                   {       
                        string candidate='';
                       candidate='<a href=\'/apex/viewxcand1?cid='+ acc.id +'\' target=\'_blank\'>'+(acc.name == null?'':acc.name)+'</a>';
                      //  String cmdname= '<a href=javascript:test(\''+acc.id+'\')>'+acc.phone_no__c+' '+acc.name+'</a>';
                       // str.add('["'+'","'+cmdname+'","'+acc.name+'","'+acc.keyskill__c+'"]');
                        str.add('["'+'","'+acc.name+'","'+acc.skill__c+'","'+acc.year_of_experience__c+' years","'+acc.state_province__c+'","'+candidate+'" ]');
                        
                   }
                   value1.clear();
                  
      }
        public void displaycompany() 
        {
           //printemp = [select lastName, Id,email from contact where accountid=:accountidd];
           printprof = [select name,email__c,phone_no__c from candidate__c where id=:accountidd limit 50];
        }
     
   
         public static testmethod void searchjobseeker_cls()
    {
        Test.setCurrentPage(Page.employeesearch);
        
       candidate__c can= new candidate__c();
        can.name='aaa' ;
       
        can.street__c = 'hjhj';
         can.year_of_experience__c=5;
        can.phone_no__c= '999999';
       
        can.skill__c='fff';
       
        insert can;
        Account acc = new Account();
        acc.name='fgfg';
        acc.employee_email__c='aaa@gmail.com';
        acc.password__c='aa';
       
        insert acc;
        ApexPages.currentPage().getParameters().put('cid' , acc.id);
         ApexPages.StandardController sc=new ApexPages.StandardController(can);
        searchjobseeker_cls sj=new searchjobseeker_cls();
         sj.searchvalue = 'fdg,aabs';
         sj.accountidd=can.id;
          sj.getvalue1();
          sj.displaycompany(); 
          string trimvalue='aaa,aaa,aaaa'; 
          sj.search1();
           
          
          //  searchjobseeker_cls isbk = new searchjobseeker_cls(sc);
          
          
        
       
       
    }
     

}