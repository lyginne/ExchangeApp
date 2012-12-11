//
//  RequestFormer.h
//  ExchangeApp
//
//  Created by Admin on 11/18/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionManager.h"

@interface RequestFormer : NSObject <ConnectionManagerDelegate>

//________________________GetData
-(void) getSubFoldersFromFolderWithFolderId:(NSString *) folderId;
-(void) getSubFoldersFromFolderWithDistinguishedFolderId:(NSString *) distinguishedFolderId;
-(void) getItemsFromFolderWithFolderId:(NSString *)folderId;
-(void) getItemWithgItemId:(NSString *)itemId;

//________________________SetData
-(void) createFolderinFolder:(NSString *)parentfolderId withName:(NSString *) name;
-(void) renameFolder:(NSString *) folderId name:(NSString *) newName;
-(void) deleteFolder:(NSString *) folderId;
-(void) deleteItem:(NSString *) itemId;
-(void) replaceItem:(NSString *) itemId inFolder:(NSString *) parentFolderId;
//-(NSString *)XMLtoGetItemFromFolderId:(NSString *) folderId;

@end
