global  class genxml{
//string str;

webservice static string DomExample()
{
    Dom.Document doc = new Dom.Document();
    
    Dom.Xmlnode rootNode = doc.createRootElement('response', null, null);

    list<account> accountList = [ 
        select  id, name,geo__Latitude__s,geo__Longitude__s
          from  Account where name='sushant'
    ];
     system.debug('1112222'+accountList );     
    for (Account eachAccount : accountList) 
    {
        Dom.Xmlnode accountNode = rootNode.addChildElement('Account', null, null);
        accountNode.setAttribute('id', eachAccount.Id);
        accountNode.setAttribute('name', eachAccount.Name);
          //accountNode.setAttribute('name', eachAccount.ph);
        //accountNode.setAttribute('name', eachAccount.city);
     //   in this way you add as many field you want 
        
        accountNode.setAttribute('geolatitude', string.valueof(eachAccount.geo__Latitude__s));
         accountNode.setAttribute('geolatitude', string.valueof(eachAccount.geo__Longitude__s));
      
        
       
    }
   // str=doc.toXmlString();
    system.debug(doc.toXmlString()); 
   // system.debug('111'+str); 
    return doc.toXmlString();
             
}
}