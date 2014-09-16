//
//  ItemSVideoView.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "ItemSVideoView.h"

@implementation ItemSVideoView

@synthesize _BtnViewInWeb, _BtnLike, _LblLike, _BtnComment, _BtnDownload, _LblDownload;

-(id)initWithInfo:(SVideoInCommunity*)info withFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *lblOwner = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 10.0f, self.frame.size.width - 40.0f, 25.0f)];
    lblOwner.text = info._Owner;
    [lblOwner setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f]];
    lblOwner.textAlignment = NSTextAlignmentCenter;
    lblOwner.textColor = [UIColor colorWithWhite:0.6f alpha:1.0f];
    lblOwner.backgroundColor = [UIColor clearColor];
    
    UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(10.0f, lblOwner.frame.origin.y + lblOwner.frame.size.height + 5.0f, self.frame.size.width - 20.0f, 260.0f)];
    viewContent.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
    viewContent.layer.cornerRadius = 10.0f;
    
    UILabel *lblGolfTree = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 0, viewContent.frame.size.width - 15.0f, 20.0f)];
    lblGolfTree.backgroundColor = [UIColor clearColor];
    [lblGolfTree setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]];
    [lblGolfTree setTextColor:[UIColor colorWithWhite:0.5f alpha:1.0f]];
    lblGolfTree.text = info._GolfTree;
    
    UIImageView *imaVThumnail = [[UIImageView alloc] initWithFrame:CGRectMake(0, lblGolfTree.frame.origin.y + lblGolfTree.frame.size.height, viewContent.frame.size.width, viewContent.frame.size.height - 2.0f*lblGolfTree.frame.size.height)];
    imaVThumnail.image = [UIImage imageWithContentsOfFile:info._PathThumnail];
    imaVThumnail.backgroundColor = [UIColor blackColor];
    
    _BtnViewInWeb = [UIButton buttonWithType:UIButtonTypeCustom];
    _BtnViewInWeb.frame = CGRectMake(0, 0, 50.0f, 50.0f);
    _BtnViewInWeb.center = CGPointMake(self.frame.size.width/2.0f, self.frame.size.height/2.3f);
    _BtnViewInWeb.backgroundColor = [UIColor clearColor];
    [_BtnViewInWeb setBackgroundImage:[UIImage imageNamed:@"ViewSVideo.png"] forState:UIControlStateNormal];
    
    _BtnLike = [UIButton buttonWithType:UIButtonTypeCustom];
    _BtnLike.frame = CGRectMake(47.5f, viewContent.frame.origin.y + viewContent.frame.size.height + 10.0f, 30.0f, 30.0f);
    _BtnLike.backgroundColor = [UIColor clearColor];
    [_BtnLike setBackgroundImage:[UIImage imageNamed:@"Like.png"] forState:UIControlStateNormal];
    if (info._Liked) {
        [_BtnLike setEnabled:NO];
        [_BtnLike setAlpha:0.5f];
    }
    
    _LblLike = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, _BtnLike.frame.origin.y + _BtnLike.frame.size.height, 80.0f, 15.0f)];
    _LblLike.text = [NSString stringWithFormat:@"%d Thích", info._Like];
    _LblLike.textAlignment = NSTextAlignmentCenter;
    [_LblLike setTextColor:[UIColor colorWithWhite:0.5f alpha:1.0f]];
    [_LblLike setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0f]];
    
    _BtnComment = [UIButton buttonWithType:UIButtonTypeCustom];
    _BtnComment.frame = CGRectMake(147.5f, viewContent.frame.origin.y + viewContent.frame.size.height + 10.0f, 30.0f, 30.0f);
    _BtnComment.backgroundColor = [UIColor clearColor];
    [_BtnComment setBackgroundImage:[UIImage imageNamed:@"CommentSVideo.png"] forState:UIControlStateNormal];
    
    
    UILabel *lblComment = [[UILabel alloc] initWithFrame:CGRectMake(120.0f, _BtnComment.frame.origin.y + _BtnComment.frame.size.height, 80.0f, 15.0f)];
    lblComment.backgroundColor = [UIColor clearColor];
    lblComment.textAlignment = NSTextAlignmentCenter;
    [lblComment setTextColor:[UIColor colorWithWhite:0.5f alpha:1.0f]];
    [lblComment setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0f]];
    lblComment.text = @"Bình luận";
    
    _BtnDownload = [UIButton buttonWithType:UIButtonTypeCustom];
    _BtnDownload.frame = CGRectMake(247.5f, viewContent.frame.origin.y + viewContent.frame.size.height + 10.0f, 30.0f, 30.0f);
    _BtnDownload.backgroundColor = [UIColor clearColor];
    [_BtnDownload setBackgroundImage:[UIImage imageNamed:@"DownloadSVideo.png"] forState:UIControlStateNormal];
    
    
    _LblDownload = [[UILabel alloc] initWithFrame:CGRectMake(220.0f, _BtnDownload.frame.origin.y + _BtnDownload.frame.size.height, 80.0f, 15.0f)];
    [_LblDownload setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0f]];
    _LblDownload.backgroundColor = [UIColor clearColor];
    [_LblDownload setTextColor:[UIColor colorWithWhite:0.5f alpha:1.0f]];
    _LblDownload.textAlignment = NSTextAlignmentCenter;
    _LblDownload.text = @"Tải xuống";
    
    UILabel *lblEnd = [[UILabel alloc] initWithFrame:CGRectMake(0, _LblDownload.frame.origin.y + _LblDownload.frame.size.height, self.frame.size.width, self.frame.size.height - (_LblDownload.frame.origin.y + _LblDownload.frame.size.height))];
    lblEnd.backgroundColor = [UIColor clearColor];
    
    
    [self addSubview:lblOwner];
    [viewContent addSubview:lblGolfTree];
    [viewContent addSubview:imaVThumnail];
    [self addSubview:viewContent];
    [self addSubview:_BtnViewInWeb];
    [self addSubview:_BtnLike];
    [self addSubview:_LblLike];
    [self addSubview:_BtnComment];
    [self addSubview:lblComment];
    [self addSubview:_BtnDownload];
    [self addSubview:_LblDownload];
    [self addSubview:lblEnd];
    
    return self;
}



@end
