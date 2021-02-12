public with sharing class WSDLConnectionTest {

public integer c { get; set; }
public integer a{get;set;}
public integer b{get;set;}
public soapSforceComSchemasClassWebsrvcead.WebSrvceAddNumbers WSDL_Add{get;set;}
public WSDLConnectionTest()
{

a=5;
b=7;
partnerSoapSforceCom.Soap myPartnerSoap = new partnerSoapSforceCom.Soap();
myPartnerSoap .endpoint_x = 'https://login.salesforce.com/services/Soap/u/21.0';
partnerSoapSforceCom.LoginResult LoginResult = myPartnerSoap .login('spanda@navatargroup.com', 'ititan56JfDhNislAU9LG1nvOIHorEvC');
system.debug('____________Login Successful_______________________'+LoginResult);
WSDL_Add=new soapSforceComSchemasClassWebsrvcead.WebSrvceAddNumbers();
soapSforceComSchemasClassWebsrvcead.SessionHeader_element session= new soapSforceComSchemasClassWebsrvcead.SessionHeader_element();
system.debug('_______________Session___________________________'+session);
session.sessionId = LoginResult.sessionId;
system.debug('_______________Session__ID_________________________'+session.sessionId);
WSDL_Add.SessionHeader=session;

c=WSDL_Add.AddNum(6,7);
system.debug('_________Sum Is_____Controller______'+c);

// partnerSoapSforceCom.LoginResult LoginResult = myPartnerSoap.login('user@domain.com', 'XXXXXXXXXXX');



}
public void summ()
{
c=WSDL_Add.AddNum(a,b);
system.debug('_________Sum Is____ADD Method_______'+c);
}
}