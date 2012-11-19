//
//  Folders.h
//  ExchangeApp
//
//  Created by Misha Vasiliev on 19.11.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Folders : NSObject

@property (nonatomic, strong) NSString *head;
@property (nonatomic, strong) NSMutableArray *folders;
@property (nonatomic, strong) NSMutableArray *files;

@end
