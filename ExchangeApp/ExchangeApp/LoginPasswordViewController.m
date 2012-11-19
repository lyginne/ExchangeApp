//
//  LoginPasswordViewController.m
//  ExchangeApp
//
//  Created by Misha Vasiliev on 18.11.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "LoginPasswordViewController.h"

@interface LoginPasswordViewController ()

@property (nonatomic, strong) IBOutlet UITextField *login;
@property (nonatomic, strong) IBOutlet UITextField *password;
-(IBAction)signIn:(id)sender;

@end

@implementation LoginPasswordViewController


@synthesize login;
@synthesize password;

-(IBAction)signIn:(id)sender
{
    // check here if login and password are correct
    NSString *logintext = [[NSString alloc] initWithString:login.text];
    NSString *passwordtext = [[NSString alloc] initWithString:password.text];
    BOOL loginCorrect = [logintext isEqualToString:@""];
    BOOL passwordCorrect = [passwordtext isEqualToString:@""];
    
    if ((loginCorrect) && (passwordCorrect))
    {
        UIAlertView *simpleAlert = [[UIAlertView alloc] initWithTitle:@"Sign in succes!"
                                                              message:@"loading data"
                                                             delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
        
        
        [simpleAlert show];
        [simpleAlert release];
        [logintext release];
        [passwordtext release];
        //dismiss
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        UIAlertView *simpleAlert = [[UIAlertView alloc] initWithTitle:@"Incorrect login and password"
                                                              message:@"Please, try again"
                                                             delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
        
        [simpleAlert show];
        [simpleAlert release];
        [logintext release];
        [passwordtext release];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    login.delegate = self;
    password.delegate = self;
	
}


@end
