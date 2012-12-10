//
//  Item.h
//  ExchangeApp
//
//  Created by Никита on 10.12.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    text,
    html
} BodyType;

@interface Item : NSObject

@property (nonatomic, retain) NSString *itemId;
@property (nonatomic, retain) NSString *body;
@property (nonatomic, retain) NSString *parentFolderId;
@property (nonatomic) BodyType bodyType;

@end
