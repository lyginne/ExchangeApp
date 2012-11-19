//
//  ShowTextFromFilesViewController.m
//  ExchangeApp
//
//  Created by Misha Vasiliev on 19.11.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "ShowTextFromFilesViewController.h"

@interface ShowTextFromFilesViewController ()


@property (nonatomic, strong) IBOutlet UILabel *head;
@property (nonatomic, strong) IBOutlet UILabel *textL;
-(IBAction)goBack:(id)sender;

@end

@implementation ShowTextFromFilesViewController
@synthesize textLetter;
@synthesize headForText;


-(IBAction)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.head.text = headForText;
    self.textL.text = textLetter;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
