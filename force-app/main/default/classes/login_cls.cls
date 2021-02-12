public with sharing class login_cls {

public Pagereference signin()
{
     Pagereference pr=new PageReference('/apex/candidatelogin');
     pr.setredirect(true);
     return pr;
}

public Pagereference signin1()
{
     Pagereference pr1=new PageReference('/apex/candlogincheck');
     pr1.setredirect(true);
     return pr1;
}
/*
public static testMethod void login_cls ()
     {
        try 
        {  
           
            Test.setCurrentPage(Page.login);
            login_cls lc =new login_cls();
            lc.signin1();
             

                }
          catch(Exception e)
          {
          system.debug(e);
          }
                
                
}*/
}