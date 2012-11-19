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

@implementation Parser

-(void) fillArray:(Folder *) parentFolder withReceivedFoldersData:(NSData *) receivedData{

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
        folder.previousFolder=parentFolder;
        folder.displayName=[[[XMLfolder elementsForName:@"t:DisplayName"] objectAtIndex:0] stringValue];
        folder.folderId=[[[[XMLfolder elementsForName:@"t:FolderId"] objectAtIndex:0] attributeForName:@"Id"] stringValue];
        [parentFolder.subFolders addObject:folder];
        [folder release];
        //NSLog(@"%@", folder);
    }
    // Folders done, SearchFolders?
}

@end
