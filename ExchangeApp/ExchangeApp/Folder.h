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
@property (assign, nonatomic) NSString *parentFolderId;
@property (retain, nonatomic) NSString * displayName;


@end
