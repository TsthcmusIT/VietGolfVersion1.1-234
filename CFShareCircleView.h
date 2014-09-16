//
//  CFShareCircleView.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFSharer.h"

@class CFShareCircleView;

@protocol CFShareCircleViewDelegate
- (void)shareCircleView:(CFShareCircleView *)aShareCircleView didSelectSharer:(CFSharer *)sharer;
@end

@interface CFShareCircleView : UIView

@property (assign) id <CFShareCircleViewDelegate> delegate;

- (id)initWithSharers:(NSArray *)sharers;
- (void)showAnimated:(BOOL)animated;
- (void)dismissAnimated:(BOOL)animated;

@end


