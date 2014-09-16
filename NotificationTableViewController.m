//
//  NotificationTableViewController.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "NotificationTableViewController.h"
#import "CoreGUIController.h"

@interface NotificationTableViewController ()

@end

@implementation NotificationTableViewController

-(id)initWithCoreGUI:(CoreGUIController *)coreGUI style:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _CoreGUI = coreGUI;
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Thông báo";
    self.navigationController.title = @"Thông báo";
    numRows = 0;
    
    // Back
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(0, 0, 75.0f, 25.0f);
    [btnBack setImage:[UIImage imageNamed:@"BackButtonBarItem.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
}


-(void)popBack
{
    [_CoreGUI._Navi05 popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    notificationArr = [[NSMutableArray alloc] initWithArray:[_CoreGUI loadNotication]];
    numRows = [notificationArr count];
    notificationItem = [[Notification alloc] init];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    notificationItem = [notificationArr objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.text = notificationItem._Title;
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
    cell.detailTextLabel.text = notificationItem._Link;
    
    if (notificationItem._Checked) {
        [self configureCell:cell indexPath:indexPath accessoryType:CHECKMARK];
    }
    else {
        [self configureCell:cell indexPath:indexPath accessoryType:FLAT_PLUS_INDICATOR];
    }
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath accessoryType:(MSCellAccessoryType )accessoryType
{
    if(accessoryType == FLAT_PLUS_INDICATOR)
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:accessoryType color:[UIColor colorWithRed:1.0f green:1.0f blue:0.3f alpha:1.0]];
    }
    else
    {
        cell.accessoryView = [MSCellAccessory accessoryWithType:accessoryType colors:@[[UIColor colorWithRed:39/255.0 green:255/255.0 blue:39/255.0 alpha:1.0], [UIColor colorWithWhite:0.4 alpha:1.0]]];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    _selectedIndex = indexPath;
    
    
    int cur = indexPath.row;
    Notification *tempNo = [[Notification alloc] init];
    tempNo = [notificationArr objectAtIndex:cur];
    [_CoreGUI passingNotificationToDetailNo:tempNo withCurrentRow:cur];
    
    [tableView reloadRowsAtIndexPaths:[tableView indexPathsForSelectedRows] withRowAnimation:UITableViewRowAnimationBottom];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
