//
//  ConnectionController.h
//  ExchangeApp
//
//  Created by Admin on 11/15/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Folder;

@protocol ConnectionManagerDelegate;

@interface ConnectionManager : NSObject

@property (nonatomic, assign) id<ConnectionManagerDelegate> delegate;
@property (nonatomic, assign) Folder* folder;
//+(void)createConnection;
-(void)createRequestToUrl:(NSURL *) url requestHTTPBody:(NSString *) requestHTTPBody;

@end

@protocol ConnectionManagerDelegate <NSObject>

-(void)connectionManager:(ConnectionManager *) connectionManager didFinishLoadingData:(NSData *) data;

@end