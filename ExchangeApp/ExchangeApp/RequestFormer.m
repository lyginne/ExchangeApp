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

-(NSString *)XMLtoFromDistinguishedFolderId:(NSString *) distinguishedFolderId {
    return[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
         <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"\
         xmlns:t=\"http://schemas.microsoft.com/exchange/services/2006/types\">\
         <soap:Body>\
         <FindFolder Traversal=\"Shallow\" xmlns=\"http://schemas.microsoft.com/exchange/services/2006/messages\">\
         <FolderShape>\
         <t:BaseShape>Default</t:BaseShape>\
         </FolderShape>\
         <ParentFolderIds>\
         <t:DistinguishedFolderId Id=\"%@\"/>\
         </ParentFolderIds>\
         </FindFolder>\
         </soap:Body>\
         </soap:Envelope>", distinguishedFolderId];
}
-(void) getSubFoldersFromFolder:(Folder *) folder
      withDistinguishedFolderId:(NSString *) distinguishedFolderId{
    
    NSURL *url=[NSURL URLWithString:@"https://mail.digdes.com/ews/exchange.asmx"];
    NSString *requestHTTPBody=[self XMLtoFromDistinguishedFolderId:distinguishedFolderId];
    ConnectionManager *connectionManager=[[ConnectionManager alloc] init];
    [connectionManager setFolder:folder];
    [connectionManager createRequestToUrl:url requestHTTPBody:requestHTTPBody];
    [connectionManager setDelegate:self];

    
}
-(void) connectionManager:(ConnectionManager *)connectionManager didFinishLoadingData:(NSData *)data{
    Parser *pasrser = [[Parser alloc] init];
    [pasrser fillArray:connectionManager.folder withReceivedFoldersData:data];
    
    
}
@end
