public class AddFieldController {

public String tot { get; set; }


public void getTotal() {
integer i,a;
String x = Apexpages.currentPage().getParameters().get('numofprod');
system.debug('-------x----'+x);
String y = Apexpages.currentPage().getParameters().get('priceofprod');
system.debug('----y----'+y);
try
{
i=integer.valueof(x);
a=integer.valueof(y);
tot = 'The total price is'+(i+a);
system.debug('----tot ----'+tot);

}

catch(Exception e)
{
system.debug('eeeeeeeeeeeeee'+e);

}



}
}