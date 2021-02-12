public class addTextrBox 
{
    public List<textBoxClass> listValueOfTextBox
        { 
          get; 
          set; 
        }    
    public addTextrBox ()
        {
            listvalueOfTextBox = new List<textBoxClass>();
        }
    public PageReference addTextBox() 
        {
            try
                {
                    listvalueOfTextBox.add(new textBoxClass('Serial Number' + (listvalueOfTextBox.size() +  1)));
                }
            catch(Exception e)
                {
                    ApexPages.addMessages(e);
                }
            return ApexPages.currentPage();
        }
     public class textBoxClass
         {
             public string textBoxLabel{get;set;}
             public string textBoxValue{get;set;}
             
             public textBoxClass(String textBoxLabel)
                 {
                     this.textBoxLabel = textBoxLabel;
                 }
         }
      public PageReference saveText() 
        {
            try
                {
                 /*   List<student__c> listStudent = new List<student__c>();
                    for(textBoxClass item : listvalueOfTextBox)
                        {
                            student__c studentObj = new student__c(stunumber__c = Decimal.valueOf(item.textBoxValue));
                        
                            listStudent.add(studentObj);
                        }
                    
                    if(listStudent.size() >  0)
                        insert listStudent;    */
                         
                }
            catch(Exception e)
                {
                    ApexPages.addMessages(e);
                }
            return ApexPages.currentPage();
        }
}