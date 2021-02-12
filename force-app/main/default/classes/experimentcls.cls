public with sharing class experimentcls
 {
    public String [] str ;
    public String [] str2 ;
    public String searching { get; set; }
    public list<Account> printacc;
    public list<contact> printemp;
        public string accountidd{get;set;}
    Public experimentcls()

      {
        //comp = new list<contact>();
         
     
        
      } 
    public String[] getprintacc()
       {
         return str;
       }
      public void search1()
      {
       str=new String[]{};
          printacc = [select Name, Id,phone from Account order by name];
          for(Account acc:printacc) 
                   {                      
                        String cmdname= '<a href=javascript:test(\''+acc.id+'\')>'+acc.name+'</a>';
                        str.add('["'+'","'+cmdname+'","'+acc.id+'","'+acc.phone+'"]');
                   }
                   
      }
 }