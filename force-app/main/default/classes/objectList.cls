public class objectList{
  public String val {get;set;}
 
  public List<SelectOption> getName()
  {
    List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();     
    List<SelectOption> options = new List<SelectOption>();
    
    for(Schema.SObjectType f : gd)
    {
        if(f.getDescribe().getlabel().contains('Contact'))
    
       options.add(new SelectOption(f.getDescribe().getLabel(),f.getDescribe().getLabel()));
    }
    return options;
   }
}