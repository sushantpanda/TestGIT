public class MultiSelectComponentController
{
private String[] selectedMakes = new String[]{};
private SelectOption[] availableList1;
private SelectOption[] chosenList1;
private String selectedTitle;
private String deSelectedTitle;
public  String MULTIPICKLIST_SEPERATOR ;

public SelectOption[] getAvailableList1(){
if (availableList1 == null) {
availableList1 = new SelectOption[]{};
List <Account> pmakes = [Select Name from account  ORDER BY Name limit 50];
for (account f : pmakes ) {
availableList1.add(new SelectOption(f.name, f.name));
}
}

return availableList1 ;
}

public SelectOption[] getChosenList1(){
if (chosenList1== null) {
chosenList1= new SelectOption[]{};
}
combineOptions(chosenList1);
return chosenList1;
}

private String combineOptions(List<SelectOption> values) {
String result = '' ;
for(SelectOption s: values) {
MULTIPICKLIST_SEPERATOR = ';';
result = result + MULTIPICKLIST_SEPERATOR + s.getValue();
//quote.es_nlp_makes__c = result;
}
return result;
}

public String getDeselectedTitle(){

deselectedTitle ='Available';

return deselectedTitle;

}


public String getSelectedTitle(){

selectedTitle ='Chosen';

return selectedTitle;

}
}