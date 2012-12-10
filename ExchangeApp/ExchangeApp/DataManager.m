//
//  DataManager.m
//  ExchangeApp
//
//  Created by Никита on 05.12.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "DataManager.h"
#import "RequestFormer.h"

@implementation DataManager

static NSMutableArray *foldersArray;
static NSMutableArray *itemsArray;
static NSCondition *arraysCondition;


-(void)threadStart{
    while (YES)
    {
        NSLog(@"%@", @"thread is fockin alive");
        RequestFormer *requestFormer = [[RequestFormer alloc] init];
        [arraysCondition lock];
        [requestFormer getSubFoldersFromFolderWithDistinguishedFolderId:@"msgfolderroot"];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        //[[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        while ([runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Data Reloaded" object:nil];
        [arraysCondition unlock];
        [requestFormer release];
        [NSThread sleepForTimeInterval:180];
		//run loop spinned ones
	}
}
-(id)init{
    self=[super init];
    foldersArray = [[NSMutableArray alloc] init];
    itemsArray = [[NSMutableArray alloc] init];
    return self;
}


+(NSMutableArray *)getFoldersArray{
    return foldersArray;
}
+(NSMutableArray *) getItemsArray{
    return itemsArray;
}
+(NSCondition *)getCondition{
    return arraysCondition;
}

@end
