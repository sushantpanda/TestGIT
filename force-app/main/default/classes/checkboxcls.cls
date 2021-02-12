public with sharing class checkboxcls {
   public string ss{get;set;}
    public PageReference selected() {
    System.debug('------------------------>lstwrap is'+lstwrap);
    for(wrappecls w:lstwrap){
        if(w.check==true){
            System.debug('---------->'+w.con);
            System.debug('-----+++++++++----->'+w.con.name);
                                   }
                                         }  
        return null;
        
      
                                                      }
                                                      
                                                      
        public  checkboxcls()
        {
              ss=' "account" ';
        }
    public class wrappecls{
        public boolean check{get; set;}
        public Contact con{get; set;}
     
        public wrappecls(Contact c){
            con =c;
            check=false;
                                                    }
     
                                      }
  
    LIst<wrappecls> lstwrap= new List<wrappecls>();
 
    public List<wrappecls> getitems(){
    List<Contact> lst=[Select id, name, phone from Contact];
    for(Contact c:lst){
    lstwrap.add(new wrappecls(c));
                              }
    System.debug('------------------------>lstwrap is'+lstwrap);
    return lstwrap;
                                                       }
                                                         }