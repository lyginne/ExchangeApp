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

//-(void) getSubFoldersFromDistinguishedFolderId:(NSString *) distinguishedFolderId;
-(void) getSubFoldersFromFolderWithFolderId:(NSString *) folderId;
-(void) getSubFoldersFromFolderWithDistinguishedFolderId:(NSString *) distinguishedFolderId;
-(NSString *)XMLtoGetItemFromFolderId:(NSString *) folderId;

@end
