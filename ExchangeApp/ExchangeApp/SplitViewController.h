//
//  SplitViewController.h
//  ExchangeApp
//
//  Created by Misha Vasiliev on 18.11.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginPasswordViewController.h"



@interface SplitViewController : UISplitViewController <StartThreadDelegate>

@property (nonatomic) int didUserSeeSignInScreen;

-(IBAction)signIn:(id)sender;
//@property (assign,nonatomic) id<SplitViewControllerDelegate> delegate;


@end
