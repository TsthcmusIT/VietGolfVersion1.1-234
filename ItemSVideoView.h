//
//  ItemSVideoView.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVideoInCommunity.h"

@interface ItemSVideoView : UIView
{
    UIButton *_BtnViewInWeb;
    UIButton *_BtnLike;
    UILabel *_LblLike;
    UIButton *_BtnComment;
    UIButton *_BtnDownload;
    UILabel *_LblDownload;
    
}

@property (nonatomic, retain) UIButton *_BtnViewInWeb;
@property (nonatomic, retain) UIButton *_BtnLike;
@property (nonatomic, retain) UILabel *_LblLike;
@property (nonatomic, retain) UIButton *_BtnComment;
@property (nonatomic, retain) UIButton *_BtnDownload;
@property (nonatomic, retain) UILabel *_LblDownload;

-(id)initWithInfo:(SVideoInCommunity*)info withFrame:(CGRect)frame;

@end