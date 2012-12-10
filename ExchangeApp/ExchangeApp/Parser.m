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
#import "Item.h"

@implementation Parser

-(void) findFoldersInDoc:(GDataXMLDocument *) doc withNamespaces:(NSDictionary *)myNS{
    NSArray *folders = [doc nodesForXPath:@"//t:Folder" namespaces:myNS error:nil];
    for (GDataXMLElement *XMLfolder in folders)
    {
        Folder *folder = [[Folder alloc] init];
        folder.displayName=[[[XMLfolder elementsForName:@"t:DisplayName"] objectAtIndex:0] stringValue];
        folder.folderId=[[[[XMLfolder elementsForName:@"t:FolderId"] objectAtIndex:0] attributeForName:@"Id"] stringValue];
        RequestFormer *request = [[RequestFormer alloc] init];
        [request getSubFoldersFromFolderWithFolderId:folder.folderId];
        [request getItemsFromFolderWithFolderId:folder.folderId];
        folder.parentFolderId=[[[[XMLfolder elementsForName:@"t:ParentFolderId"] objectAtIndex:0] attributeForName:@"Id"] stringValue];
        [[DataManager getFoldersArray]addObject:folder];
        [folder release];
        NSLog(@"%@", folder.displayName);
    }

}
-(void) findItemsInDoc:(GDataXMLDocument *) doc withNamespaces:(NSDictionary *) myNS{
    NSArray *messages = [doc nodesForXPath:@"//t:Message" namespaces:myNS error:nil];
    for (GDataXMLElement *XMLitem in messages)
    {
        Item *item = [[Item alloc] init];
        //folder.displayName=[[[XMLfolder elementsForName:@"t:DisplayName"] objectAtIndex:0] stringValue];
        //item.parentFolderId=[[[[XMLitem elementsForName:@"t:ParentFolderId"] objectAtIndex:0] attributeForName:@"Id"] stringValue];
        item.itemId=[[[[XMLitem elementsForName:@"t:ItemId"] objectAtIndex:0] attributeForName:@"Id"] stringValue];
        //item.body=[[XMLitem elementsForName:@"t:Body"] objectAtIndex:0];
        
        //if ([[[[[XMLitem elementsForName:@"t:Body"] objectAtIndex:0] attributeForName:@"BodyType"] stringValue] isEqualToString:@"Text"])
         //   item.bodyType=text;
        //else
        //    item.bodyType=html;
            
        RequestFormer *request = [[RequestFormer alloc] init];
        [request getItemWithgItemId:item.itemId];
        [item release];
        //NSLog(@"%@",XMLitem);
    }

}
-(void) getItemsInDoc:(GDataXMLDocument *) doc withNamespaces:(NSDictionary *) myNS{
    NSArray *messages = [doc nodesForXPath:@"//t:Message" namespaces:myNS error:nil];
    for (GDataXMLElement *XMLitem in messages)
    {
        Item *item = [[Item alloc] init];
        //folder.displayName=[[[XMLfolder elementsForName:@"t:DisplayName"] objectAtIndex:0] stringValue];
        item.parentFolderId=[[[[XMLitem elementsForName:@"t:ParentFolderId"] objectAtIndex:0] attributeForName:@"Id"] stringValue];
        item.itemId=[[[[XMLitem elementsForName:@"t:ItemId"] objectAtIndex:0] attributeForName:@"Id"] stringValue];
        item.body=[[[XMLitem elementsForName:@"t:Body"] objectAtIndex:0] stringValue];
        
        if ([[[[[XMLitem elementsForName:@"t:Body"] objectAtIndex:0] attributeForName:@"BodyType"] stringValue] isEqualToString:@"Text"])
           item.bodyType=text;
        else
            item.bodyType=html;
        if ([item body])
           [[DataManager getItemsArray] addObject:item];
        [item release];
        //NSLog(@"%@",XMLitem);
    }
    

}
-(void) fillArrayWithReceivedFoldersData:(NSData *) receivedData{

    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:receivedData
                                                           options:0 error:&error];
    NSDictionary *myNS = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"http://schemas.microsoft.com/exchange/services/2006/types", @"t",@"http://schemas.microsoft.com/exchange/services/2006/messages",@"m", nil];
    if ([doc nodesForXPath:@"//m:FindFolderResponse" namespaces:myNS error:nil])
        [self findFoldersInDoc:doc withNamespaces:myNS];
    if ([doc nodesForXPath:@"//m:FindItemResponse" namespaces:myNS error:nil])
        [self findItemsInDoc:doc withNamespaces:myNS];
    if ([doc nodesForXPath:@"//m:GetItemResponse" namespaces:myNS error:nil])
        [self getItemsInDoc:doc withNamespaces:myNS];
    [doc release];
        // Folders done, SearchFolders?
}

@end
