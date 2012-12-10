//
//  SplitViewController.m
//  ExchangeApp
//
//  Created by Misha Vasiliev on 18.11.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "SplitViewController.h"
#import "LoginPasswordViewController.h"
#import "DataManager.h"

@implementation SplitViewController{
    NSThread *backgroundDownloadingThread;
}

-(void)stopThread{
    [backgroundDownloadingThread cancel];
}
-(void)startThread{
    DataManager *dataManager = [[DataManager alloc] init];
    backgroundDownloadingThread =[[NSThread alloc] initWithTarget:dataManager selector:@selector(threadStart) object:nil];
    [backgroundDownloadingThread start];
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    NSString *loginText =[[NSUserDefaults standardUserDefaults] stringForKey:@"User"];
    NSString *urlText = [[NSUserDefaults standardUserDefaults] stringForKey:@"URL"];
    NSString *passwordText = [[NSUserDefaults standardUserDefaults] stringForKey:@"Password"];
    
    if (loginText!=nil&&urlText!=nil&&passwordText!=nil){
        [self startThread];
    }
    else{
        LoginPasswordViewController *loginView = [[LoginPasswordViewController alloc] init];
        [self.navigationController presentViewController:loginView animated:YES completion:nil];
        loginView.delegate=self;
    }
}
//- (void)viewDidLoad{
//    
//    [super viewDidLoad];
//}

@end
