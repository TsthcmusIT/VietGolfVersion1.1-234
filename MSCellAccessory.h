//
//  MSCellAccessory.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DETAIL_DISCLOSURE_DEFAULT_COLOR             [UIColor colorWithRed:35.0f/255.0f green:110/255.0f blue:216.0f/255.0 alpha:1.0f]
#define DISCLOSURE_INDICATOR_DEFAULT_COLOR          [UIColor colorWithRed:127.0f/255.0f green:127.0f/255.0f blue:127.0f/255.0f alpha:1.0f]
#define CHECKMARK_DEFAULT_DEFAULT_COLOR             [UIColor colorWithRed:50.0f/255.0f green:79.0f/255.0f blue:133.0f/255.0f alpha:1.0f]
#define FLAT_DETAIL_BUTTON_DEFAULT_COLOR            [UIColor colorWithRed:0/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f]
#define FLAT_DISCLOSURE_INDICATOR_DEFAULT_COLOR     [UIColor colorWithRed:199.0f/255.0f green:199.0f/255.0f blue:204.0f/255.0f alpha:1.0f]
#define FLAT_CHECKMARK_DEFAULT_COLOR                [UIColor colorWithRed:0/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f]

typedef NS_ENUM(NSInteger, MSCellAccessoryType)
{
    DETAIL_DISCLOSURE,
    DISCLOSURE_INDICATOR,
    CHECKMARK,
    UNFOLD_INDICATOR,
    FOLD_INDICATOR,
    PLUS_INDICATOR,
    MINUS_INDICATOR,
    FLAT_DETAIL_DISCLOSURE,
    FLAT_DETAIL_BUTTON,
    FLAT_DISCLOSURE_INDICATOR,
    FLAT_CHECKMARK,
    FLAT_UNFOLD_INDICATOR,
    FLAT_FOLD_INDICATOR,
    FLAT_PLUS_INDICATOR,
    FLAT_MINUS_INDICATOR
};

@interface MSCellAccessory : UIControl
@property (nonatomic, assign) MSCellAccessoryType accType;
@property (nonatomic, assign) BOOL isAutoLayout; //default is YES. if set to NO, accessory layout does not adjust automatically.

+ (MSCellAccessory *)accessoryWithType:(MSCellAccessoryType)accessoryType color:(UIColor *)color;
+ (MSCellAccessory *)accessoryWithType:(MSCellAccessoryType)accessoryType color:(UIColor *)color highlightedColor:(UIColor *)highlightedColor;

// If you using a FLAT_DETAIL_DISCLOSURE, use these method. because FLAT_DETAIL_DISCLOSURE has a two different UI (FLAT_DETAIL_BUTTON, FLAT_DISCLOSURE_INDICATOR), must set a each color.
+ (MSCellAccessory *)accessoryWithType:(MSCellAccessoryType)accessoryType colors:(NSArray *)colors;
+ (MSCellAccessory *)accessoryWithType:(MSCellAccessoryType)accessoryType colors:(NSArray *)colors highlightedColors:(NSArray *)highlightedColors;



@end
