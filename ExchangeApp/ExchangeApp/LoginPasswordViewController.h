//
//  LoginPasswordViewController.h
//  ExchangeApp
//
//  Created by Misha Vasiliev on 18.11.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SplitViewController.h"

@protocol StartThreadDelegate <NSObject>

@required
-(void)startThread;
-(void)stopThread;

@end

@interface LoginPasswordViewController :  UIViewController <UITextFieldDelegate>//, SplitViewControllerDelegate>

@property (assign) id<StartThreadDelegate> delegate;

@property (nonatomic, strong) IBOutlet UITextField *login;
@property (nonatomic, strong) IBOutlet UITextField *password;
@property (nonatomic, strong) IBOutlet UITextField *url;

-(IBAction)signIn:(id)sender;

@end
