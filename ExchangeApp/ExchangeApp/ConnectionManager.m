
//
//  ConnectionController.m
//  ExchangeApp
//
//  Created by Admin on 11/15/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "ConnectionManager.h"

@implementation ConnectionManager{
    
    NSString *str;
    NSMutableData *receivedData;
    //NSString *errorMessage;
}

@synthesize folder;
@synthesize delegate=_delegate;

-(void)createRequestToUrl:(NSURL *) url requestHTTPBody:(NSString *) requestHTTPBody {
    
    NSData *requestHTTPBodyData=[requestHTTPBody dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *theRequest=[NSMutableURLRequest  requestWithURL:url
                                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:60.0];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest setHTTPBody:requestHTTPBodyData];
    
    NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (connection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
       receivedData = [[NSMutableData data] retain];
        NSLog(@"Connection succeed");
    }
    else {
        NSLog(@"Connection failed");
        // Inform the user that the connection failed.
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Connection Failed" object:nil];
        
    }
}

-(void)connection:(NSURLConnection *)connection
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge previousFailureCount] == 0) {
        NSURLCredential *newCredential;
        NSString *user=[[NSUserDefaults standardUserDefaults] stringForKey:@"User"];
        NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:@"Password"];
        newCredential = [NSURLCredential credentialWithUser:user
                                                   password:password//@"P@ssw0rd"
                                                persistence:NSURLCredentialPersistenceForSession];
        [[challenge sender] useCredential:newCredential
               forAuthenticationChallenge:challenge];
        NSLog(@"Authentification complete");
    }
    else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
        NSLog(@"Authentification Failed");
        //errorMessage=@"Authentification Failed";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Authentification Failed" object:nil];
        [receivedData release];
        // inform the user that the user name and password
        // in the preferences are incorrect
        //[self showPreferencesCredentialsAreIncorrectPanel:self];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
    NSLog(@"Did receive response");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Authentification Succeed" object:nil];
    
    [receivedData appendData:data];
//    NSString *receivedDataStr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"Did Receive data %@", receivedDataStr);
    
}



- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // inform the user
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Connection Failed" object:nil];
    // release Connection
    [connection release];
    // receivedData is declared as a method instance elsewhere
    [receivedData release];
    
    
    NSLog(@"Connection failed! Error - %@ %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey],
          error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    //NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    

    // release the connection, and the data object
    NSLog(@"Connection Did Finish Loading");
    [_delegate connectionManager:self didFinishLoadingData:receivedData];
    [connection release];
    [receivedData release];
    
}

@end
