//
//  XMLFormer.m
//  ExchangeApp
//
//  Created by Никита on 10.12.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "XMLFormer.h"

@implementation XMLFormer

+(NSString *)XMLtoGetFoldersFromFolderWithId:(NSString *) folderId {
    return[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
           <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"\
           xmlns:t=\"http://schemas.microsoft.com/exchange/services/2006/types\">\
           <soap:Body>\
           <FindFolder Traversal=\"Shallow\" xmlns=\"http://schemas.microsoft.com/exchange/services/2006/messages\">\
           <FolderShape>\
           <t:BaseShape>AllProperties</t:BaseShape>\
           </FolderShape>\
           <ParentFolderIds>\
           <t:FolderId Id=\"%@\"/>\
           </ParentFolderIds>\
           </FindFolder>\
           </soap:Body>\
           </soap:Envelope>", folderId];
}
+(NSString *)XMLtoGetFoldersFromFolderWithDistinguishedFolderId:(NSString *) distinguishedFolderId{
    return[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
           <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"\
           xmlns:t=\"http://schemas.microsoft.com/exchange/services/2006/types\">\
           <soap:Body>\
           <FindFolder Traversal=\"Shallow\" xmlns=\"http://schemas.microsoft.com/exchange/services/2006/messages\">\
           <FolderShape>\
           <t:BaseShape>AllProperties</t:BaseShape>\
           </FolderShape>\
           <ParentFolderIds>\
           <t:DistinguishedFolderId Id=\"%@\"/>\
           </ParentFolderIds>\
           </FindFolder>\
           </soap:Body>\
           </soap:Envelope>", distinguishedFolderId];
}
+(NSString *)XMLtoGetItemsFromFolderId:(NSString *) folderId {
    return[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
           <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"\
           xmlns:t=\"http://schemas.microsoft.com/exchange/services/2006/types\">\
           <soap:Body>\
           <FindItem xmlns=\"http://schemas.microsoft.com/exchange/services/2006/messages\"\
           xmlns:t=\"http://schemas.microsoft.com/exchange/services/2006/types\"\
           Traversal=\"Shallow\">\
           <ItemShape>\
           <t:BaseShape>IdOnly</t:BaseShape>\
           </ItemShape>\
           <ParentFolderIds>\
           <t:FolderId Id=\"%@\"/>\
           </ParentFolderIds>\
           </FindItem>\
           </soap:Body>\
           </soap:Envelope>", folderId];
}
+(NSString *)XMLtoGetItemWithItemId:(NSString *) itemId{
    return[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
           <soap:Envelope\
                               xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\
                               xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"\
                               xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"\
                               xmlns:t=\"http://schemas.microsoft.com/exchange/services/2006/types\">\
           <soap:Body>\
           <GetItem\
           xmlns=\"http://schemas.microsoft.com/exchange/services/2006/messages\"\
                               xmlns:t=\"http://schemas.microsoft.com/exchange/services/2006/types\">\
           <ItemShape>\
           <t:BaseShape>AllProperties</t:BaseShape>\
           <t:IncludeMimeContent>false</t:IncludeMimeContent>\
           </ItemShape>\
           <ItemIds>\
           <t:ItemId Id=\"%@\"/>\
           </ItemIds>\
           </GetItem>\
           </soap:Body>\
           </soap:Envelope>",itemId];
     //ChangeKey="CQAAAB"
}

+(NSString *)XMLtoReplaceItem:(NSString *)itemId toFolder:(NSString *) parentFolderId{
    return [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
            <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\
                                xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"\
                                xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"\
                                xmlns:t=\"http://schemas.microsoft.com/exchange/services/2006/types\">\
            <soap:Body>\
            <MoveItem xmlns=\"http://schemas.microsoft.com/exchange/services/2006/messages\"\
                                xmlns:t=\"http://schemas.microsoft.com/exchange/services/2006/types\">\
            <ToFolderId>\
            <t:FolderId Id=\"%@\"/>\
            </ToFolderId>\
            <ItemIds>\
            <t:ItemId Id=\"%@\"/>\
            </ItemIds>\
            </MoveItem>\
            </soap:Body>\
            </soap:Envelope>",parentFolderId,itemId];
}
+(NSString *)XMLtoDeleteItem:(NSString *)itemId{
    return [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
            <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"\
                                xmlns:t=\"http://schemas.microsoft.com/exchange/services/2006/types\">\
            <soap:Body>\
            <DeleteItem DeleteType=\"HardDelete\" xmlns=\"http://schemas.microsoft.com/exchange/services/2006/messages\">\
            <ItemIds>\
            <t:ItemId Id=\"%@\" />\
            </ItemIds>\
            </DeleteItem>\
            </soap:Body>\
            </soap:Envelope>", itemId];
}
+(NSString *)XMLtoDeleteFolder:(NSString *)foldefId{
    return[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
           <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"\
                               xmlns:t=\"http://schemas.microsoft.com/exchange/services/2006/types\">\
           <soap:Body>\
           <DeleteFolder xmlns=\"http://schemas.microsoft.com/exchange/services/2006/messages\"\
                               xmlns:t=\"http://schemas.microsoft.com/exchange/services/2006/types\"\
           DeleteType=\"HardDelete\" >\
           <FolderIds>\
           <t:FolderId Id=\"%@\" />\
           </FolderIds>\
           </DeleteFolder>\
           </soap:Body>\
           </soap:Envelope>",foldefId];
}
+(NSString *)XMLtoRenameFolder:(NSString *)folderId name:(NSString *)newName{
    return [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
            <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"\
                                xmlns:t=\"http://schemas.microsoft.com/exchange/services/2006/types\">\
            <soap:Body>\
            <UpdateFolder xmlns=\"http://schemas.microsoft.com/exchange/services/2006/messages\"\
                                xmlns:t=\"http://schemas.microsoft.com/exchange/services/2006/types\">\
            <FolderChanges>\
            <t:FolderChange>\
            <t:FolderId Id=\"%@\"/>\
            <t:Updates>\
            <t:SetFolderField>\
            <t:FieldURI FieldURI=\"folder:DisplayName\"/>\
            <t:Folder>\
            <t:DisplayName>%@</t:DisplayName>\
            </t:Folder>\
            </t:SetFolderField>\
            </t:Updates>\
            </t:FolderChange>\
            </FolderChanges>\
            </UpdateFolder>\
            </soap:Body>\
            </soap:Envelope>",folderId, newName];
}
+(NSString *)XMLtoCreateFolderInFolder:(NSString *)parentFolder withName:(NSString *)name{
    return [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
            <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"\
                                xmlns:t=\"http://schemas.microsoft.com/exchange/services/2006/types\">\
            <soap:Body>\
            <CreateFolder xmlns=\"http://schemas.microsoft.com/exchange/services/2006/messages\">\
            <ParentFolderId>\
            <t:FolderId Id=\"%@\"/>\
            </ParentFolderId>\
            <Folders>\
            <t:Folder>\
            <t:DisplayName>%@</t:DisplayName>\
            </t:Folder>\
            </Folders>\
            </CreateFolder>\
            </soap:Body>\
            </soap:Envelope>",parentFolder,name];
}

@end
