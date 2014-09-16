//
//  NotificationTableViewController.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MSCellAccessory.h"
#import "Notification.h"

@class CoreGUIController;

@interface NotificationTableViewController : UITableViewController
{
    CoreGUIController *_CoreGUI;
    NSIndexPath *_selectedIndex;
    
    NSMutableArray *notificationArr;
    Notification *notificationItem;
    int numRows;
}

-(id)initWithCoreGUI:(CoreGUIController *)coreGUI style:(UITableViewStyle)style;


@end
