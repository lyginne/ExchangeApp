//
//  RequestFormer.m
//  ExchangeApp
//
//  Created by Admin on 11/18/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "RequestFormer.h"
#import "ConnectionManager.h"
#import "Folder.h"
#import "Parser.h"

@implementation RequestFormer

-(NSString *)XMLtoFromFolderId:(NSString *) folderId {
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

-(void) getSubFoldersFromFolderWithFolderId:(NSString *) folderId{
    
    NSURL *url=[NSURL URLWithString:@"https://mail.digdes.com/ews/exchange.asmx"];
    NSString *requestHTTPBody=[self XMLtoFromFolderId:folderId];
    ConnectionManager *connectionManager=[[ConnectionManager alloc] init];
    //[connectionManager setFolder:folder];
    [connectionManager createRequestToUrl:url requestHTTPBody:requestHTTPBody];
    [connectionManager setDelegate:self];
}
-(NSString *)XMLtoFromDistinguishedFolderId:(NSString *) distinguishedFolderId {
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
-(NSString *)XMLtoGetItemsFromFolderId:(NSString *) folderId {
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
-(void) getSubFoldersFromFolderWithDistinguishedFolderId:(NSString *) distinguishedFolderId{
    
    //NSURL *url=[NSURL URLWithString:@"https://mail.digdes.com/ews/exchange.asmx"];
    NSURL *url=[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] stringForKey:@"URL"]];
    NSString *requestHTTPBody=[self XMLtoFromDistinguishedFolderId:distinguishedFolderId];
    ConnectionManager *connectionManager=[[ConnectionManager alloc] init];
    //[connectionManager setFolder:folder];
    [connectionManager createRequestToUrl:url requestHTTPBody:requestHTTPBody];
    [connectionManager setDelegate:self];

    
}
-(void) connectionManager:(ConnectionManager *)connectionManager didFinishLoadingData:(NSData *)data{
    Parser *pasrser = [[Parser alloc] init];
    [pasrser fillArrayWithReceivedFoldersData:data];
    
    
}
@end
