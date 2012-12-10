//
//  LoginPasswordViewController.m
//  ExchangeApp
//
//  Created by Misha Vasiliev on 18.11.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "LoginPasswordViewController.h"
#import "DataManager.h"

@implementation LoginPasswordViewController{
    
    NSString *alertString;
}

@synthesize login;
@synthesize password;
@synthesize url;
@synthesize delegate;

-(void)showAlert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:alertString
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}
-(void)dismiss{
   [self dismissViewControllerAnimated:NO completion:nil]; 
}
-(void)authentificationSucceed{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self performSelectorOnMainThread:@selector(dismiss) withObject:nil waitUntilDone:NO];
    
}
-(void)authentificationFailed{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self performSelectorOnMainThread:@selector(showAlert) withObject:nil waitUntilDone:NO];
        //[self dismissViewControllerAnimated:NO completion:nil];
    [delegate stopThread];
    
}
-(void)connectionFailed{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    alertString=@"Connection Failed";
    [self performSelectorOnMainThread:@selector(showAlert) withObject:nil waitUntilDone:NO];
    [delegate stopThread];
}


-(void) viewDidAppear:(BOOL)animated
{
    //[super viewDidAppear:NO];
    NSString *loginText =[[NSUserDefaults standardUserDefaults] stringForKey:@"User"];
    NSString *urlText = [[NSUserDefaults standardUserDefaults] stringForKey:@"URL"];
    NSString *passwordText = [[NSUserDefaults standardUserDefaults] stringForKey:@"Password"];

    if (loginText!=nil&&urlText!=nil&&passwordText!=nil){
        //[self performSegueWithIdentifier:@"SegueToLogin" sender:self];
        [self dismiss];
    }
    
    if (loginText!=nil){
        login.text=loginText;
    }
    if (urlText!=nil){
        url.text=urlText;
    }    
}
-(IBAction)signIn:(id)sender
{
    // check here if login and password are correct se
    [[NSUserDefaults standardUserDefaults] setObject:login.text forKey:@"User"];
    [[NSUserDefaults standardUserDefaults] setObject:password.text forKey:@"Password"];
    [[NSUserDefaults standardUserDefaults] setObject:url.text forKey:@"URL"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authentificationFailed) name:@"Authentification Failed" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authentificationSucceed) name:@"Authentification Succeed" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectionFailed) name:@"Connection Failed" object:nil];
    
    [delegate startThread];
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    login.delegate = self;
    password.delegate = self;
}


@end
