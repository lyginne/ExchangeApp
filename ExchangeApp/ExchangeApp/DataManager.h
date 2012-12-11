//
//  DataManager.h
//  ExchangeApp
//
//  Created by Никита on 05.12.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

-(void)threadStart;

+(NSMutableArray *)getFoldersArray;
+(NSMutableArray *) getItemsArray;

+(void)createFolderInParentFolder:(NSString *) parentFolderId withName:(NSString *) name;
+(void)renameFolderWithId:(NSString *) folderId name:(NSString *) newName;
+(void)deleteFolderWithId:(NSString *) folderId;
+(void)deleteItem:(NSString *) itemId;
+(void)replaceItem:(NSString *) itenId inParentFolder:(NSString *) parentFolderId;

@end
