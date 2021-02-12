public class theController {
String searchText;
List<account> results;
public String getSearchText() {
return searchText;
}
public void setSearchText(String s) {
searchText = s;
}
public List<account> getResults() {
return results;
}
public PageReference doSearch() {
results = (List<account>)[FIND :searchText RETURNING account(name,Phone)][0];
return null;
}
}