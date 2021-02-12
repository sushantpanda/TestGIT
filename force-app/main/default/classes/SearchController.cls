public class SearchController{
 /**class variable to store values at class level**/
    private List<SelectOption> lstObjectOptions ;   
    /**variable to store fields as per selected object at ui level **/
    private static List<string> fields ;
    /** variable bind with search textbox **/
    public static string searchString {get;set;}
    /** variable contain selected value of object dropdown **/
    public static string SelectedSobject {get;set;}
    /** list variable which will bind with VF page **/
    public static List<Sobject> currentViewList {get;set;}
    public static string headerValues ;
    
    /**Constructor for this controller **/
    public SearchController(){
    
      //default value of object to search
      SelectedSobject ='Account';
      currentViewList = new List<Sobject>();
    
    }
    

/** method return  header values and set of data as per search keyword **/
    @RemoteAction
    public static SearchController.FieldsWithData  RemoteCall(string searchStrParam , string SelectedSobjectParam){
       searchString = searchStrParam;
       SelectedSobject = SelectedSobjectParam;
       searchData(1);
       //return currentViewList;
       FieldsWithData finalObject = new FieldsWithData();
       finalObject.fieldList = headerValues;
       finalObject.rowList =currentViewList;
       system.debug('======='+finalObject);
       return finalObject;
    
    }

/** method return  header values and set of data as per pagination **/
    @RemoteAction
    public static List<SObject>  RemoteCallPagaination(string searchStrParam , string SelectedSobjectParam ,string buttonTypeParam,Integer offsetValue){
    system.debug('==='+ buttonTypeParam + '===' + offsetValue );
       searchString = searchStrParam;
       SelectedSobject = SelectedSobjectParam;
    
  return searchData(offsetValue);
        
    }
    

 /** Method to get data result based on search word and on click on search button 
    Use SOSL to get search on all fields and use offset on SOQL to get results as per pagination .
   **/

    public static List<Sobject> searchData(integer offsetValue){
        
        String querySOSL='';
        String querySQL=''; 
  Integer offsetCount;

  if(offsetValue >1){
  offsetCount = (offsetValue-1) * 5;
  }

        system.debug('==='+SelectedSobject );


        currentViewList = new List<Sobject>();
            
        String queryFields = getQueryFields(getFields());
        queryFields = 'id,' + queryFields ;
        
        if(SelectedSobject=='Account'){
            querySQL = 'select ' + queryFields + ' from Account';
            querySOSL = 'FIND\'' + searchString + '*\'IN ALL FIELDS RETURNING Account(' + queryFields + ')';
        }
        else{
            querySQL = 'select ' + queryFields + ' from Contact';
            querySOSL = 'FIND\'' + searchString + '*\'IN ALL FIELDS RETURNING Contact(' + queryFields + ')';
        }
        
        
        system.debug('====='+QuerySOSL);
        
        List<List<SObject>>  resultListOfList= search.query(querySOSL);
        system.debug('==='+resultListOfList);
        
        if(resultListOfList[0] !=null && resultListOfList[0].size()>0){
             
    if(offsetValue==1)
    querySQL = querySQL + ' where id in (' + getRecordIds(resultListOfList[0]) + ') Limit 5 '  ;
    else
    querySQL = querySQL + ' where id in (' + getRecordIds(resultListOfList[0]) + ') Limit 5 OFFSET ' + string.valueOf(offsetCount)  ;

             system.debug('====='+QuerySQL);
             currentViewList= Database.Query(querySQL);
             
            
        }
  return currentViewList;
        
    }
    
   
    /** Inner class to map data with header fields **/
    public class FieldsWithData{
        public String fieldList;
        public List<SObject> rowList ;
        
    }
    
 /** List contains fields of contact to show on VF page **/
    public static List<String> getFields(){
            
          fields = new List<String>();
           
           if(SelectedSobject=='Account'){
              fields.add('Name');
              fields.add('Rating');
              fields.add('Website');
              fields.add('Phone');
              fields.add('Fax');
              
            }
            else{
              
              fields.add('FirstName');
              fields.add('LastName');
              fields.add('Email');
              fields.add('Fax');
              fields.add('Phone');
                
                
            }
            return fields;
        
    }
    
   /** method to concatenate ids of search results **/
   private static string getRecordIds(List<SObject> sObjectList){
        string ids ='';integer i=0;
        for(SObject nextObj:sObjectList){
            i=i+1;
            
            if(i==1)
                ids= '\'' + nextObj.id + '\'';
            else
                ids=ids+',\''+ nextObj.id + '\'';
        }
        return ids;
    
   }
   
    /** method to concatenate fields for SOSL query as per selected object **/
    private static String getQueryFields(List<String> fieldsParam){
    
      String query='' ;Integer i=0;
      headerValues='';headerValues =''; 
      for(String nextStr:fieldsParam){
        i=i+1;
        
        if(i==1){
            query=nextStr;
           
        }
        else {
            query=query+ ',' + nextStr;
           
            }
            
       headerValues = query;
        
      }
      return query;
      
    
    }

    


}