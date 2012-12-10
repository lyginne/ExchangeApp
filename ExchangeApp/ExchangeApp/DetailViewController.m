//
//  DetailViewController.m
//  ExchangeApp
//
//  Created by Admin on 11/12/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "DetailViewController.h"
#import "ShowTextFromFilesViewController.h"
#import "DataManager.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (nonatomic, strong) IBOutlet UITableView *tblView;
@property (nonatomic, strong) NSString *inf;
- (void)configureView;
@end

@implementation DetailViewController

@synthesize tblView;
@synthesize inf;

- (IBAction)unlogin:(UIBarButtonItem *)sender{
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"User"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"Password"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"URL"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)dealloc
{
    [_detailItem release];
    [_detailDescriptionLabel release];
    [_masterPopoverController release];
    [super dealloc];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release];
        _detailItem = [newDetailItem retain];

        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
        [tblView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tblView.delegate = self;
    self.tblView.dataSource = self;
    [self configureView];
}

#pragma mark - Table View
//
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tblView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tblView numberOfRowsInSection:(NSInteger)section
{
    return ([self.detailItem.files count] + [self.detailItem.folders count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    BOOL y = ([self.detailItem.folders count] > indexPath.row);
   
     if (y)
     {
         Folders *folder = [self.detailItem.folders objectAtIndex:indexPath.row];
         cell.textLabel.text = folder.head;
     }
    else
    {
        int foldersCount = [self.detailItem.folders count];
        int index = indexPath.row - foldersCount;
        
        Files *file = [self.detailItem.files objectAtIndex:index];
        cell.textLabel.text = file.head;
    }
    
    // Configure the cell.
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *head = cell.textLabel.text;
    BOOL a = NO;
    
    //try to find this name in a folder array:
    Folders *folderToDetail = [[Folders alloc ] init];
    for (Folders *ff in self.detailItem.folders)
    {
        NSString *headFromArray = ff.head;
        if ([headFromArray isEqualToString:head])
        {
            folderToDetail = ff;
            a = YES;
            break;
            
        }
    }
    
    
    //try to find this name in a files array:
    Files *fileToDetail = [[Files alloc] init];
    for (Files *ff in self.detailItem.files)
    {
        NSString *headFromArray = ff.head;
        if ([headFromArray isEqualToString:head])
        {
            fileToDetail = ff;
            a = NO;
            break;
        }
    }
    
    
    
    
    
    
    
    if (a)
    {
    self.detailItem = folderToDetail;
    [fileToDetail release];
    [self.tblView reloadData];
    }
    else
    {
        ShowTextFromFilesViewController *SVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowText"];
        SVC.headForText = fileToDetail.head;
        SVC.textLetter = fileToDetail.filetext;
        [folderToDetail release];
        [self presentViewController:SVC animated:YES completion:nil];
        
        
    }
    
    
    
    
    
}

//

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}


@end
