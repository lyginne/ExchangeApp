//
//  DataManager.m
//  ExchangeApp
//
//  Created by Никита on 05.12.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "DataManager.h"
#import "RequestFormer.h"
#import "Item.h"
#import "Folder.h"

@implementation DataManager

static NSMutableArray *foldersArray;
static NSMutableArray *itemsArray;
static NSCondition *arraysCondition;

+(NSInteger)findItemIndexFor:(NSString *)itemId{
    for (NSInteger i=0;i<[itemsArray count];i++){
        Item *item = [itemsArray objectAtIndex:i];
        if ([itemId isEqualToString:item.itemId])
            return i;
    }
    return -1;
}
+(NSInteger)findFolderIndexFor:(NSString *)folderId{
    for (NSInteger i=0;i<[itemsArray count];i++){
        Folder *folder = [itemsArray objectAtIndex:i];
        if ([folderId isEqualToString:folder.folderId])
            return i;
    }
    return -1;
}
+(void)deteteFromFoldersArrayItem:(NSString *)folderId{
    NSInteger index=[self findFolderIndexFor:folderId];
    [itemsArray removeObjectAtIndex:index];
}
+(void)deteteFromItemsArrayItem:(NSString *)itemId{
    NSInteger index=[self findItemIndexFor:itemId];
    [itemsArray removeObjectAtIndex:index];
}

+(void)createFolderInParentFolder:(NSString *) parentFolderId withName:(NSString *) name{
    RequestFormer *request=[[RequestFormer alloc] init];
    [request createFolderinFolder:parentFolderId withName:name];
    
}
+(void)renameFolderWithId:(NSString *) folderId name:(NSString *) newName{
    RequestFormer *request =[[RequestFormer alloc] init];
    [request renameFolder:folderId name:newName];
    [DataManager deteteFromFoldersArrayItem:folderId];
}
+(void)deleteFolderWithId:(NSString *)folderId{
    RequestFormer *request = [[RequestFormer alloc] init];
    [request deleteFolder:folderId];
    [DataManager deteteFromFoldersArrayItem:folderId];
}
+(void)deleteItem:(NSString *)itemId{
    RequestFormer *request = [[RequestFormer alloc] init];
    [request deleteItem:itemId];
    [DataManager deteteFromItemsArrayItem:itemId];
}
+(void)replaceItem:(NSString *)itenId inParentFolder:(NSString *)parentFolderId{
    RequestFormer *request =[[RequestFormer alloc] init];
    [request replaceItem:itenId inFolder:parentFolderId];
    [DataManager deteteFromItemsArrayItem:itenId];
}

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
        [NSThread sleepForTimeInterval:300];
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
