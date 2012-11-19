//
//  DetailViewController.h
//  ExchangeApp
//
//  Created by Admin on 11/12/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Folders.h"
#import "Files.h"
@interface DetailViewController :  UIViewController <UISplitViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) Folders *detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
