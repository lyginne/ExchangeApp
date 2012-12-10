//
//  MasterViewController.m
//  ExchangeApp
//
//  Created by Admin on 11/12/12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "MasterViewController.h"
//#import "Folders.h"
//#import "Files.h"
#import "DetailViewController.h"

@interface MasterViewController () {

}
@end

@implementation MasterViewController
@synthesize foldersFilesArray;
- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)dealloc
{
    [_detailViewController release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    //adding data
    // creating...
    foldersFilesArray = [[NSMutableArray alloc ] init];
    
    // create folder 1 (root)
    
//    @autoreleasepool {
    
//    Folders *folder1 = [[Folders alloc ]init];
//    folder1.head = @"FOLDER1";
//    folder1.files = [[NSMutableArray alloc] init];
//    //configure files for folder 1
//    Files *file1ForFolder1 = [[Files alloc ] init];
//    file1ForFolder1.head = @"file1ForFolder1";
//    file1ForFolder1.filetext = @"HELLO WORLD!";
//    [folder1.files addObject:file1ForFolder1];
//    
//    
//    //configure folders for folder 1
//    folder1.folders = [[NSMutableArray alloc] init];
//    Folders *folder2 = [[Folders alloc ]init];
//    Folders *folder3 = [[Folders alloc ]init];
//    folder2.head = @"FOLDER2";
//    folder3.head = @"FOLDER3";
//    folder2.files = [[NSMutableArray alloc ] init];
//    // configure files for folder 2
//    Files *file1ForFolder2 = [[Files alloc ] init];
//    file1ForFolder2.head = @"file1ForFolder2";
//    file1ForFolder2.filetext = @"BYE BYE WORLD!";
//    [folder2.files addObject:file1ForFolder2];
//    [folder1.folders addObject:folder2];
//    
//    
//    folder3.files = [[NSMutableArray alloc ] init];
//    // configure files for folder 3
//    Files *file1ForFolder3 = [[Files alloc ] init];
//    file1ForFolder3.head = @"file1ForFolder3";
//    file1ForFolder3.filetext = @"HELLO, so.. lets start!!";
//    [folder3.files addObject:file1ForFolder3];
//    [folder1.folders addObject:folder3];
//    
//    //
//    [foldersFilesArray addObject:folder1];
//    
//    //
//    
//    // create folder11 (root)
//    
//    Folders *folder11 = [[Folders alloc ]init];
//    folder11.head = @"FOLDER11";
//    folder11.files = [[NSMutableArray alloc] init];
//    //configure files for folder 1
//    Files *file1ForFolder11 = [[Files alloc ] init];
//    file1ForFolder11.head = @"file1ForFolder11";
//    file1ForFolder11.filetext = @"HELLO MY NAME IS 11!";
//    [folder11.files addObject:file1ForFolder11];
//    
//    Files *file2ForFolder11 = [[Files alloc ] init];
//    file2ForFolder11.head = @"file2ForFolder11";
//    file2ForFolder11.filetext = @"HELLO MY NAME IS 11 again!";
//    [folder11.files addObject:file2ForFolder11];
//    
//    
//    
//    //.......................
//    
//    //
//    [foldersFilesArray addObject:folder11];
//    //
//    
//  
//    //
//    }
//    
//
//    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [foldersFilesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

//    Folders *folder = [foldersFilesArray objectAtIndex:indexPath.row];

//    NSString *text = folder.head;
//    cell.textLabel.text = text;
    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{//getting some information from cell
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSString *head = cell.textLabel.text;
    
    //finding folder in array
//    Folders *folderToDetail = [[Folders alloc ] init];
//    for (Folders *ff in foldersFilesArray)
//    {
//        NSString *headFromArray = ff.head;
//        if ([headFromArray isEqualToString:head])
//        {
//            folderToDetail = ff;
//            break;
//            
//        }
//    }
    
    
    //NSString *text = [NSString stringWithFormat:@"%@", folderToDetail.head];
    // self.detailViewController.detailItem = text;
//    self.detailViewController.detailItem = folderToDetail;
//    [folderToDetail release];
}

@end
