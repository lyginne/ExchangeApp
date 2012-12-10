//
//  RequestFormer.m
//  ExchangeApp
//
//  Created by Admin on 11/18/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "RequestFormer.h"
#import "ConnectionManager.h"
//#import "Folder.h"
#import "Parser.h"
#import "XMLFormer.h"

@implementation RequestFormer

-(void) getSubFoldersFromFolderWithFolderId:(NSString *) folderId{
    
    NSURL *url=[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] stringForKey:@"URL"]];
    NSString *requestHTTPBody=[XMLFormer XMLtoGetFoldersFromFolderWithId:folderId];
    ConnectionManager *connectionManager=[[ConnectionManager alloc] init];
    [connectionManager createRequestToUrl:url requestHTTPBody:requestHTTPBody];
    [connectionManager setDelegate:self];
}
-(void) getSubFoldersFromFolderWithDistinguishedFolderId:(NSString *) distinguishedFolderId{
    
    NSURL *url=[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] stringForKey:@"URL"]];
    NSString *requestHTTPBody=[XMLFormer XMLtoGetFoldersFromFolderWithDistinguishedFolderId:distinguishedFolderId];
    ConnectionManager *connectionManager=[[ConnectionManager alloc] init];
    [connectionManager createRequestToUrl:url requestHTTPBody:requestHTTPBody];
    [connectionManager setDelegate:self];
}
-(void) getItemsFromFolderWithFolderId:(NSString *)folderId{
    
    NSURL *url=[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] stringForKey:@"URL"]];
    NSString *requestHTTPBody=[XMLFormer XMLtoGetItemsFromFolderId:folderId];
    ConnectionManager *connectionManager=[[ConnectionManager alloc] init];
    [connectionManager createRequestToUrl:url requestHTTPBody:requestHTTPBody];
    [connectionManager setDelegate:self];
}
-(void) getItemWithgItemId:(NSString *)itemId{
    NSURL *url=[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] stringForKey:@"URL"]];
    NSString *requestHTTPBody=[XMLFormer XMLtoGetItemWithItemId:itemId];
    ConnectionManager *connectionManager=[[ConnectionManager alloc] init];
    [connectionManager createRequestToUrl:url requestHTTPBody:requestHTTPBody];
    [connectionManager setDelegate:self];
}

-(void) connectionManager:(ConnectionManager *)connectionManager didFinishLoadingData:(NSData *)data{
    Parser *pasrser = [[Parser alloc] init];
    [pasrser fillArrayWithReceivedFoldersData:data];
}
@end
