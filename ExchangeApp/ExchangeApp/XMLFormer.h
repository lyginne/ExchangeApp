//
//  XMLFormer.h
//  ExchangeApp
//
//  Created by Никита on 10.12.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLFormer : NSObject

+(NSString *)XMLtoGetFoldersFromFolderWithId:(NSString *) folderId;
+(NSString *)XMLtoGetFoldersFromFolderWithDistinguishedFolderId:(NSString *) distinguishedFolderId;
+(NSString *)XMLtoGetItemsFromFolderId:(NSString *) folderId;
+(NSString *)XMLtoGetItemWithItemId:(NSString *) itemId;

@end
