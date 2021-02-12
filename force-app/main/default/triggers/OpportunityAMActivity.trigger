trigger OpportunityAMActivity on Task( after insert ) {
  Map< Id, Opportunity > opps = new Map< Id, Opportunity >( );
  for( Task record: Trigger.new ) {
    if( record.WhatId != null && record.WhatId.getSObjectType( ) == Opportunity.SobjectType )  {
      opps.put( record.WhatId, null );
    }
  }
  opps.putAll( [SELECT Id, OwnerId FROM Opportunity WHERE Id IN :opps.keySet( ) ] );
  for( Task record: Trigger.new ) {
    if( opps.containsKey( record.WhatId ) && opps.get( record.WhatId ).OwnerId == record.OwnerId ) {
    /*&& ( opps.get( record.WhatId ).AM_Last_Activity__c == null || opps.get( record.WhatId ).AM_Last_Activity__c < record.ActivityDate*/
  }
  update opps.values( );
}
}