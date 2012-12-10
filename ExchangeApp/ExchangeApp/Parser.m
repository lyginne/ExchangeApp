//
//  Parser.m
//  ExchangeApp
//
//  Created by Admin on 11/18/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "Parser.h"
#import "GDataXMLNode.h"
#import "Folder.h"
#import "RequestFormer.h"
#import "DataManager.h"

@implementation Parser

-(void) fillArrayWithReceivedFoldersData:(NSData *) receivedData{

    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:receivedData
                                                           options:0 error:&error];
    //NSArray *folders = [doc nodesForXPath:@"/*/t:Folder" error:nil];
    NSDictionary *myNS = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"http://schemas.microsoft.com/exchange/services/2006/types", @"t", nil];
    //NSArray *tempArray = [xmlResult nodesForXPath:@"//ns1:message/ns1:error/ns1:value" namespaces:myNS error:&error];
    NSArray *folders = [doc nodesForXPath:@"//t:Folder" namespaces:myNS error:nil];
    for (GDataXMLElement *XMLfolder in folders)
    {
        Folder *folder = [[Folder alloc] init];
        //folder.parentFolder=parentFolder;
        folder.displayName=[[[XMLfolder elementsForName:@"t:DisplayName"] objectAtIndex:0] stringValue];
        folder.folderId=[[[[XMLfolder elementsForName:@"t:FolderId"] objectAtIndex:0] attributeForName:@"Id"] stringValue];
        RequestFormer *request = [[RequestFormer alloc] init];
        [request getSubFoldersFromFolderWithFolderId:folder.folderId];
        
        folder.parentFolderId=[[[[XMLfolder elementsForName:@"t:ParentFolderId"] objectAtIndex:0] attributeForName:@"Id"] stringValue];
        [[DataManager getFoldersArray]addObject:folder];
        [folder release];
        NSLog(@"%@", folder.displayName);
    }
    // Folders done, SearchFolders?
}

@end
