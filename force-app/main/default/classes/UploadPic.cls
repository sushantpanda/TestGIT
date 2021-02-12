public class UploadPic
{

    public UploadPic(candidate controller) {

    }


    


/* Variable Declarations */
private ApexPages.StandardController controller;
public string attach{get;set;}
public id ids{get;set;}
public Boolean isAvailable{get;set;}
public List<Attachment> postImageId;
private Contact cont;

/* Getter and Setter method for the Attachments */
public Attachment attachment {
get {
if (attachment == null) attachment = new Attachment();
return attachment;
}
set;
}


/* Constructor for the class it will set the contact variable to the current contact on which the page is displayed */
public UploadPic(ApexPages.StandardController controller)
{

this.controller = controller;

//Returns the contact from which the page is called


//Checks whether the display pic is already uploaded or not
postImageId = [SELECT id from attachment where name =: 'Display.jpg' and ParentId =:ids limit 1];
if(postImageId.size() > 0)
{
isAvailable = true;
}
else
{
isAvailable = false;
}
}


/* Method to insert the Attachment and associate it with proper Contact */
public void saveAttachment()
{

ids=ApexPages.currentPage().getParameters().get('Id');
system.debug('________________'+ids);
attachment = new Attachment();
//sets the parent id of the attachment to the id of the contact
attachment.ParentId =ids;
attachment.name = 'Display.jpg';
attachment.body =null;
insert attachment;
 attachment.body = null;
isAvailable = true;
}


/* Returns the string that will fetch the image from the attachments */
public String getpostImage()
{
postImageId = [SELECT id from attachment where name =: 'Display.jpg' and ParentId =:ids limit 1];
String path = '/servlet/servlet.FileDownload?file=' + postImageId[0].Id;
return path;
}
}