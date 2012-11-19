//
//  SplitViewController.m
//  ExchangeApp
//
//  Created by Misha Vasiliev on 18.11.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "SplitViewController.h"
#import "LoginPasswordViewController.h"

@interface SplitViewController ()


@end

@implementation SplitViewController

@synthesize didUserSeeSignInScreen;

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    if (didUserSeeSignInScreen == 0)
    {
        didUserSeeSignInScreen = 1;
        [self performSegueWithIdentifier:@"SegueToLogin" sender:self];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    didUserSeeSignInScreen = 0;
	
}



@end
