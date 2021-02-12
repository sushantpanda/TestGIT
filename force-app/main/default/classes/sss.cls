public with sharing class sss {

    public string str { get; set; }
        public integer inputValue { get; set; }
  integer sum=0;
    public PageReference find() {
    
    
 system.debug('aaaaaaa'+inputValue );
    
       integer r;
      integer temp=inputValue ;
 
      while( temp!= 0 )
      {
         r = math.mod(temp,10);
         sum = sum + r*r*r;
         temp = temp/10; 
      }
      
     if(inputValue == sum)
     {  
     system.debug('ssssssssssssssssssssssssssssssss');    
     str='this is ok';
    }
    else{
     system.debug('tttttttttttttttttttttttttt');   
    str='this is not';
    
    }

return null;

}
}