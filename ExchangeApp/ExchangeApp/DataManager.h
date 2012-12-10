//
//  DataManager.h
//  ExchangeApp
//
//  Created by Никита on 05.12.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+(NSMutableArray *)getFoldersArray;
+(NSMutableArray *) getItemsArray;
-(void)threadStart;

@end
