trigger testtrigger on test__c (before insert) 


{
for(test__c tc:trigger.new)
{
tc.Account1123__c='0019000000BKxAM';
}

}