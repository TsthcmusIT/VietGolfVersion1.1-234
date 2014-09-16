//
//  MSCMoreOptionTableViewCell.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol MSCMoreOptionTableViewCellDelegate <NSObject>

@optional

// "More button"

/*
 * Tells the delegate that the "More" button for specified row was pressed.
 */
-(void)tableView:(UITableView *)tableView moreOptionButtonPressedInRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 * If not implemented or returning nil the "More" button will neither be created
 * nor displayed and the cell will act like a common UITableViewCell.
 *
 * The "More" button also supports multiline titles.
 */
-(NSString *)tableView:(UITableView *)tableView titleForMoreOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 * If not implemented or returning nil the "More" button will have [UIColor whiteColor]
 * as titleColor.
 */
-(UIColor *)tableView:(UITableView *)tableView titleColorForMoreOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 * If not implemented or returning nil the "More" button will have [UIColor lightGrayColor]
 * as backgroundColor.
 */
-(UIColor *)tableView:(UITableView *)tableView backgroundColorForMoreOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

// "Delete button"

/*
 * If not implemented or returning nil the "Delete" button will have the default backgroundColor.
 */
-(UIColor *)tableView:(UITableView *)tableView backgroundColorForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 * If not implemented or returning nil the "Delete" button will have the default titleColor.
 */
-(UIColor *)tableView:(UITableView *)tableView titleColorForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MSCMoreOptionTableViewCell : UITableViewCell
{
    UIButton *_BtnFavorited;
    UIScrollView *_CellScrollView;
    UIButton *_MoreOptionButton;
}

@property (nonatomic, weak) id<MSCMoreOptionTableViewCellDelegate> _Delegate;
@property (nonatomic, strong) UIButton *_MoreOptionButton;
@property (nonatomic, strong) UIScrollView *_CellScrollView;
@property (nonatomic, retain) UIButton *_BtnFavorited;

@end

