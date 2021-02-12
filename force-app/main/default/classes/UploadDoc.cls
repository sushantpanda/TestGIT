public class UploadDoc
{
Public Document mydoc;
    Public Document getmyimage()
    {
        mydoc = new Document();
        return mydoc;
    }
   
    Public Pagereference Savedoc()
    {
        mydoc.folderid = UserInfo.getUserId(); // Stores in the currennt users "My Personal Documents" folder
        //mydoc.folderid = 'any other id you want here'; // Fetch Id dynamically by using [Select Id from Folder where Name='My Images']. Specifying a FolderId is mandatory
        insert mydoc;
        return NULL;
    }   
       
       
}