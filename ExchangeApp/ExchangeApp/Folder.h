//
//  Folder.h
//  ExchangeApp
//
//  Created by Admin on 11/18/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Folder : NSObject

@property (retain, nonatomic) NSString * folderId;
@property (assign, nonatomic) Folder *previousFolder;
@property (retain, nonatomic) NSString * displayName;
@property (assign, nonatomic) NSMutableArray * subFolders;
@property (assign, nonatomic) NSMutableArray * subItems;

@end
