//
//  ConnectionController.h
//  ExchangeApp
//
//  Created by Admin on 11/15/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectionManager : NSObject

//+(void)createConnection;
-(void)createRequestToUrl:(NSURL *) url requestHTTPBody:(NSString *) requestHTTPBody;

@end
