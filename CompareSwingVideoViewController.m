//
//  CompareSwingVideoViewController.m
//  VietGolfVersion1.1
//
//  Created by admin on 8/12/14.
//  Copyright (c) 2014 NguyenDuyThanh. All rights reserved.
//

#import "CompareSwingVideoViewController.h"
#import "CoreGUIController.h"

@interface CompareSwingVideoViewController ()

@end

@implementation CompareSwingVideoViewController

@synthesize _IsMixed, _SVideoHost, _PlayerHost, _PlayerCompare;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"So sánh";
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    self._ScreenName = CompareSwingVideo;
    
    isMaster = YES;
    isTranparancy = NO;
    isHostPlaying = NO;
    isComparePlaying = NO;
    flagEndTime = NO;
    isOrient = YES;
    statusHostEndTime = YES;
    statusCompareEndTime = YES;
    allowMoving = NO;
    isBothPause = NO;
    
    if (_IsMixed) {
        [self showCompareScreen:_SVideoHost withCompareStringPath:_SVideoHost._PathCompare];
    } else {
        allowOrient = NO;

        // Video host
        viewBackground = [[UIView alloc] init];
        viewBackground.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        viewBackground.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
        [self.view addSubview:viewBackground];
        
        lblTitle = [[UILabel alloc] init];
        lblTitle.frame = CGRectMake(0, 0, self.view.frame.size.width, 40.0f);
        lblTitle.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
        lblTitle.text = @"CHỌN SWING VIDEO";
        [lblTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:21.0f]];
        [lblTitle setTextColor:[UIColor whiteColor]];
        lblTitle.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lblTitle];
        
        btnExit = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnExit setFrame:CGRectMake(10.0f, 5.0f, 30.0f, 30.0f)];
        [btnExit setImage:[UIImage imageNamed:@"BackToList.png"] forState:UIControlStateNormal];
        btnExit.backgroundColor = [UIColor clearColor];
        [btnExit addTarget:self action:@selector(exitChooseScreen) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnExit];
        
        btnMaster = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnMaster setFrame:CGRectMake(0.5f*self.view.frame.size.width, lblTitle.frame.origin.y + lblTitle.frame.size.height, 0.5f*self.view.frame.size.width, 30.0f)];
        btnMaster.tag = 11;
        [btnMaster setTitleColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [btnMaster setBackgroundColor:[UIColor colorWithWhite:0.1f alpha:1.0f]];
        [btnMaster.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0f]];
        [btnMaster setTitle:@"Master" forState:UIControlStateNormal];
        [btnMaster addTarget:self action:@selector(showSVideos:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnMaster];
        
        btnUser = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnUser setFrame:CGRectMake(0, lblTitle.frame.origin.y + lblTitle.frame.size.height, 0.5f*self.view.frame.size.width, 30.0f)];
        btnUser.tag = 12;
        [btnUser setBackgroundColor:[UIColor colorWithWhite:0.1f alpha:1.0f]];
        [btnUser.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0f]];
        [btnUser setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnUser setTitle:@"User" forState:UIControlStateNormal];
        [btnUser addTarget:self action:@selector(showSVideos:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnUser];
        
        
        scrollview = [[UIScrollView alloc] init];
        scrollview.frame = CGRectMake(0, 0.25f*viewBackground.frame.size.height, viewBackground.frame.size.width, 0.5f*self.view.frame.size.height);
        [scrollview setDelegate:self];
        scrollview.backgroundColor = [UIColor clearColor];
        scrollview.showsVerticalScrollIndicator = NO;
        scrollview.showsHorizontalScrollIndicator = NO;
        scrollview.pagingEnabled = YES;
        [viewBackground addSubview:scrollview];

        pageControl = [[UIPageControl alloc] init];
        pageControl.frame = CGRectMake(0, 0, 200.0f, 36.0f);
        pageControl.center = CGPointMake(viewBackground.frame.size.width/2.0f, viewBackground.frame.size.height - (viewBackground.frame.size.height - (scrollview.frame.origin.y + scrollview.frame.size.height))/2.0f);
        [pageControl addTarget:self
                        action:@selector(pgCntlChanged:)forControlEvents:UIControlEventValueChanged];
        pageControl.currentPage = 0;
        [viewBackground addSubview:pageControl];

        
        listVideoCompare = [[NSMutableArray alloc] init];
        itemArr = [[NSMutableArray alloc] init];

        [self showSVideos:btnMaster];
    }
}

-(void)showSVideos:(UIButton*)sender
{
    for (int z = 0; z < [itemArr count]; z++) {
        [[itemArr objectAtIndex:z] removeFromSuperview];
    }
    
    [itemArr removeAllObjects];
    
    if (sender.tag == 12) {
        listVideoCompare = [_CoreGUI loadVideoWithType:1];
        sender.enabled = NO;
        btnMaster.enabled = YES;
        isMaster = NO;
        [btnUser setTitleColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [btnMaster setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    } else {
        listVideoCompare = [_CoreGUI loadVideoWithType:0];
        sender.enabled = NO;
        btnUser.enabled = YES;
        isMaster = YES;
        [btnMaster setTitleColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [btnUser setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }

    pageControl.numberOfPages = listVideoCompare.count;
    scrollview.contentSize = CGSizeMake(scrollview.frame.size.width * listVideoCompare.count, scrollview.frame.size.height);
    
    for (int i = 0; i < listVideoCompare.count ; i++) {
        UIImageView * imageview = [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@", ((SVideoInfo*)[listVideoCompare objectAtIndex:i])._Thumnail]]];
        [imageview setContentMode:UIViewContentModeScaleAspectFill];
        imageview.frame = CGRectMake(0, 0.25*viewBackground.frame.size.height, viewBackground.frame.size.width, scrollview.frame.size.height);
        [imageview setTag:i + 1];
        if (i != 0) {
            imageview.alpha = 0;
        }
        [viewBackground addSubview:imageview];
        [itemArr addObject:imageview];
    }
    
    if ([listVideoCompare count] > 0) {
        
        btnPrev = [UIButton buttonWithType:UIButtonTypeCustom];
        btnPrev.frame = CGRectMake(0, 0, scrollview.frame.size.width/4.0f, scrollview.frame.size.height);
        btnPrev.center = CGPointMake(scrollview.frame.size.width/8.0f, scrollview.frame.origin.y + scrollview.frame.size.height/2.0f);
        [btnPrev setImage:[UIImage imageNamed:@"BackToList.png"] forState:UIControlStateNormal];
        [btnPrev addTarget:self action:@selector(prevSVideoFromList) forControlEvents:UIControlEventTouchUpInside];
        btnPrev.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:1.0f alpha:0.85f];
        btnPrev.hidden = YES;
        [viewBackground addSubview:btnPrev];
        
        btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
        btnNext.frame = CGRectMake(0, 0, scrollview.frame.size.width/4.0f, scrollview.frame.size.height);
        btnNext.center = CGPointMake(7.0f*scrollview.frame.size.width/8.0f, scrollview.frame.origin.y + scrollview.frame.size.height/2.0f);
        [btnNext setImage:[UIImage imageNamed:@"BackToList.png"] forState:UIControlStateNormal];
        btnNext.transform = CGAffineTransformMakeRotation(-M_PI);
        [btnNext addTarget:self action:@selector(nextSVideoFromList) forControlEvents:UIControlEventTouchUpInside];
        btnNext.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:1.0f alpha:0.85f];
        [viewBackground addSubview:btnNext];
        
        
        [itemArr addObject:btnPrev];
        [itemArr addObject:btnNext];
    } else {
        scrollview.contentSize = CGSizeMake(scrollview.frame.size.width * (listVideoCompare.count + 1), scrollview.frame.size.height);
        UIImageView * imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NoSwingVideo.png"]];
        [imageview setContentMode:UIViewContentModeScaleAspectFill];
        imageview.frame = CGRectMake(0, 0.25f*viewBackground.frame.size.height, viewBackground.frame.size.width, scrollview.frame.size.height);
        [viewBackground addSubview:imageview];
        [itemArr addObject:imageview];
    }
    
    // Pan gesture host
    tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGes.delegate = self;
    [scrollview addGestureRecognizer:tapGes];
    
}

-(void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {
    if(gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        CGPoint location = [gestureRecognizer locationInView:scrollview];
        if ([scrollview pointInside:location withEvent:nil]) {
            if ([listVideoCompare count] > 0) {                
                
                NSArray *viewsToRemove = [viewBackground subviews];
                for (UIView *view in viewsToRemove) {
                    [view removeFromSuperview];
                }
                
                NSArray *viewsToRemoveChild = [self.view subviews];
                for (UIView *view in viewsToRemoveChild) {
                    [view removeFromSuperview];
                }

                stringPathCompare = ((SVideoInfo*)[listVideoCompare objectAtIndex:pageControl.currentPage])._PathVideo;
                
                [self showCompareScreen:_SVideoHost withCompareStringPath: stringPathCompare];
            }
        }
    }
}

-(void)prevSVideoFromList
{
    if (pageControl.currentPage <= 1) {
        btnPrev.hidden = YES;
        if (pageControl.currentPage == 1) {
            [scrollview scrollRectToVisible:CGRectMake(((pageControl.currentPage - 1)%listVideoCompare.count)*scrollview.frame.size.width, 0, scrollview.frame.size.width, scrollview.frame.size.height) animated:YES];
            [pageControl setCurrentPage:((pageControl.currentPage - 1)%listVideoCompare.count)];
        }

    } else {
        btnNext.hidden = NO;
        btnPrev.hidden = NO;
        if (listVideoCompare.count) {
            [scrollview scrollRectToVisible:CGRectMake(((pageControl.currentPage - 1)%listVideoCompare.count)*scrollview.frame.size.width, 0, scrollview.frame.size.width, scrollview.frame.size.height) animated:YES];
            [pageControl setCurrentPage:((pageControl.currentPage - 1)%listVideoCompare.count)];
        }
    }
    
    
}

-(void)nextSVideoFromList
{
    if (pageControl.currentPage >= [listVideoCompare count] - 2) {
        btnNext.hidden = YES;
        if (pageControl.currentPage == [listVideoCompare count] - 2) {
            [scrollview scrollRectToVisible:CGRectMake(((pageControl.currentPage + 1)%listVideoCompare.count)*scrollview.frame.size.width, 0, scrollview.frame.size.width, scrollview.frame.size.height) animated:YES];
            [pageControl setCurrentPage:((pageControl.currentPage + 1)%listVideoCompare.count)];
        }
        
    } else {
        btnNext.hidden = NO;
        btnPrev.hidden = NO;
        if (listVideoCompare.count) {
            [scrollview scrollRectToVisible:CGRectMake(((pageControl.currentPage + 1)%listVideoCompare.count)*scrollview.frame.size.width, 0, scrollview.frame.size.width, scrollview.frame.size.height) animated:YES];
            [pageControl setCurrentPage:((pageControl.currentPage + 1)%listVideoCompare.count)];
        }
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    if ([listVideoCompare count] > 0) {
        previousTouchPoint = scrollView.contentOffset.x;
    }
}

- (void)pgCntlChanged:(UIPageControl *)sender {
    [scrollview scrollRectToVisible:CGRectMake(sender.currentPage*scrollview.frame.size.width, 0, scrollview.frame.size.width, scrollview.frame.size.height) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [pageControl setCurrentPage:scrollView.contentOffset.x/scrollView.frame.size.width];
    if (pageControl.currentPage == 0) {
        btnPrev.hidden = YES;
        btnNext.hidden = NO;
    } else {
        if (pageControl.currentPage == [listVideoCompare count] - 1) {
            btnPrev.hidden = NO;
            btnNext.hidden = YES;
        } else {
            btnPrev.hidden = NO;
            btnNext.hidden = NO;
        }
    }
    NSLog(@"Current pagging: %d", pageControl.currentPage);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([listVideoCompare count] > 0) {
        [scrollView setContentOffset: CGPointMake(scrollView.contentOffset.x, 0)];
        
        int page = floor((scrollView.contentOffset.x - self.view.frame.size.width) / self.view.frame.size.width) + 1;
        float OldMin = self.view.frame.size.width*page;
        int Value = scrollView.contentOffset.x - OldMin;
        float alpha = (Value % (int)self.view.frame.size.width) / self.view.frame.size.width;
        
        
        if (previousTouchPoint > scrollView.contentOffset.x)
            page = page + 2;
        else
            page = page + 1;
        
        UIView *nextPage = [scrollView.superview viewWithTag:page + 1];
        UIView *previousPage = [scrollView.superview viewWithTag:page - 1];
        UIView *currentPage = [scrollView.superview viewWithTag:page];
        
        if(previousTouchPoint <= scrollView.contentOffset.x){
            if ([currentPage isKindOfClass:[UIImageView class]])
                currentPage.alpha = 1 - alpha;
            if ([nextPage isKindOfClass:[UIImageView class]])
                nextPage.alpha = alpha;
            if ([previousPage isKindOfClass:[UIImageView class]])
                previousPage.alpha = 0;
        }else if(page != 0){
            if ([currentPage isKindOfClass:[UIImageView class]])
                currentPage.alpha = alpha;
            if ([nextPage isKindOfClass:[UIImageView class]])
                nextPage.alpha = 0;
            if ([previousPage isKindOfClass:[UIImageView class]])
                previousPage.alpha = 1 - alpha;
        }
        if (!didEndAnimate && pageControl.currentPage == 0) {
            for (UIView * imageView in viewBackground.subviews){
                if (imageView.tag != 1 && [imageView isKindOfClass:[UIImageView class]])
                    imageView.alpha = 0;
                else if([imageView isKindOfClass:[UIImageView class]])
                    imageView.alpha = 1 ;
            }
        }
    }
}


-(void)exitChooseScreen
{
    NSArray *viewsToRemove = [viewBackground subviews];
    for (UIView *view in viewsToRemove) {
        [view removeFromSuperview];
    }
    
    NSArray *viewsToRemoveChild = [self.view subviews];
    for (UIView *view in viewsToRemoveChild) {
        [view removeFromSuperview];
    }
    
    [_CoreGUI._Navi popViewControllerAnimated:YES];
}


-(void)showCompareScreen:(SVideoInfo*)hostSVideo withCompareStringPath:(NSString*)compareStrPath
{
    allowOrient = YES;
    // Video
    if (_IsMixed) {
        stringPathCompare = compareStrPath;
    }
    
    // AVPlayer host
    _PlayerHost = [AVPlayer playerWithURL:[[NSURL alloc] initFileURLWithPath:hostSVideo._PathVideo]];
    _PlayerHost.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    _PlayerHost.allowsExternalPlayback = YES;
    layerHost = [AVPlayerLayer playerLayerWithPlayer:_PlayerHost];
    [layerHost setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.view.layer addSublayer:layerHost];
    
    
    // AVPlayer compare
    self._PlayerCompare = [AVPlayer playerWithURL:[[NSURL alloc] initFileURLWithPath:compareStrPath]];
    self._PlayerCompare.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    layerCompare = [AVPlayerLayer playerLayerWithPlayer:self._PlayerCompare];
    [layerCompare setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.view.layer addSublayer:layerCompare];
    
    // Draw tool
    _DrawView = [[Draw2D alloc] init];
    _DrawView.frame = CGRectMake(0, 40, self.view.frame.size.width - 40.0f, self.view.frame.size.height - 40.0f);
    _DrawView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_DrawView];
    
    // Tranparency compare video
    transparentSlider = [[UISlider alloc] init];
    transparentSlider.frame = CGRectMake(0, 0, 100.0f, 20.0f);
    transparentSlider.minimumValue = 0.0f;
    transparentSlider.maximumValue = 1.0f;
    transparentSlider.value = 0.5f;
    transparentSlider.minimumTrackTintColor = [UIColor redColor];
    transparentSlider.tintColor = [UIColor blueColor];
    [transparentSlider addTarget:self action:@selector(changeOpacitySvideo) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:transparentSlider];
    
    // Top tool
    viewTopTool = [[UIView alloc] init];
    [viewTopTool setFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0f)];
    viewTopTool.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    [self.view addSubview:viewTopTool];
    
    btnBackToList = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBackToList setFrame:CGRectMake(15.0f, 5.0f, 30.0f, 30.0f)];
    [btnBackToList setImage:[UIImage imageNamed:@"BackToList.png"] forState:UIControlStateNormal];
    [btnBackToList addTarget:self action:@selector(backToListSVideo) forControlEvents:UIControlEventTouchUpInside];
    [viewTopTool addSubview:btnBackToList];
    
    btnModeView = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnModeView setFrame:CGRectMake(viewTopTool.frame.size.width/2.0f - 15.0f, 5.0, 30.0f, 30.0f)];
    [btnModeView setImage:[UIImage imageNamed:@"ModeView.png"] forState:UIControlStateNormal];
    [btnModeView addTarget:self action:@selector(modeViewSVideo) forControlEvents:UIControlEventTouchUpInside];
    [viewTopTool addSubview:btnModeView];
    
    btnSaveCompare = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSaveCompare setFrame:CGRectMake(viewTopTool.frame.size.width - 45.0f, 5.0f, 30.0f, 30.0f)];
    [btnSaveCompare setImage:[UIImage imageNamed:@"SaveCompare.png"] forState:UIControlStateNormal];
    [btnSaveCompare addTarget:self action:@selector(saveCompareSVideo) forControlEvents:UIControlEventTouchUpInside];
    [viewTopTool addSubview:btnSaveCompare];
    
    // Add Tool Draw
    viewDrawTool = [[UIView alloc] init];
    viewDrawTool.frame = CGRectMake(self.view.frame.size.width - 40.0f, 40.0f, 40.0f, self.view.frame.size.height - 40.0f);
    viewDrawTool.backgroundColor = [UIColor blackColor];
    [self.view addSubview:viewDrawTool];
    
    btnLine = [[UIButton alloc] init];
    btnLine.frame = CGRectMake(0, 0, 40.0f, 40.0f);
    btnLine.tag = 100;
    [btnLine addTarget:self action:@selector(drawForVideo:) forControlEvents:UIControlEventTouchUpInside];
    [btnLine setImage:[UIImage imageNamed:@"Line.png"] forState:UIControlStateNormal];
    
    btnCurve = [[UIButton alloc] init];
    btnCurve.frame = CGRectMake(0, btnLine.frame.origin.y + btnLine.frame.size.height + 5.0f, 40.0f, 40.0f);
    btnCurve.tag = 101;
    [btnCurve addTarget:self action:@selector(drawForVideo:) forControlEvents:UIControlEventTouchUpInside];
    [btnCurve setImage:[UIImage imageNamed:@"Curve.png"] forState:UIControlStateNormal];
    
    btnCircle = [[UIButton alloc] init];
    btnCircle.frame = CGRectMake(0, btnCurve.frame.origin.y + btnCurve.frame.size.height + 5.0f, 40.0f, 40.0f);
    btnCircle.tag = 102;
    [btnCircle addTarget:self action:@selector(drawForVideo:) forControlEvents:UIControlEventTouchUpInside];
    [btnCircle setImage:[UIImage imageNamed:@"Circle.png"] forState:UIControlStateNormal];
    
    btnRectangle = [[UIButton alloc] init];
    btnRectangle.frame = CGRectMake(0, btnCircle.frame.origin.y + btnCircle.frame.size.height + 5.0f, 40.0f, 40.0f);
    btnRectangle.tag = 103;
    [btnRectangle addTarget:self action:@selector(drawForVideo:) forControlEvents:UIControlEventTouchUpInside];
    [btnRectangle setImage:[UIImage imageNamed:@"Rectangle.png"] forState:UIControlStateNormal];
    
    btnDelete = [[UIButton alloc] init];
    btnDelete.frame = CGRectMake(0, btnRectangle.frame.origin.y + btnRectangle.frame.size.height + 5.0f, 40.0f, 40.0f);
    btnDelete.tag = 104;
    [btnDelete addTarget:self action:@selector(drawForVideo:) forControlEvents:UIControlEventTouchUpInside];
    [btnDelete setImage:[UIImage imageNamed:@"Trash.png"] forState:UIControlStateNormal];

    [viewDrawTool addSubview:btnLine];
    [viewDrawTool addSubview:btnCircle];
    [viewDrawTool addSubview:btnRectangle];
    [viewDrawTool addSubview:btnDelete];
    [viewDrawTool addSubview:btnCurve];
    
    // Speed view
    viewToolSpeed = [[UIView alloc] init];
    viewToolSpeed.frame = CGRectMake(5.0f, 0, 40.0f, 180.0f);
    viewToolSpeed.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewToolSpeed];
    
    btnAsc = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAsc.frame = CGRectMake(0, 0, 40.0f, 25.0f);
    btnAsc.tag = 1001;
    [btnAsc setBackgroundImage:[UIImage imageNamed:@"AcsSpeedVideo.png"] forState:UIControlStateNormal];
    [btnAsc addTarget:self action:@selector(controlSpeedSVideo:) forControlEvents:UIControlEventTouchDown];
    [viewToolSpeed addSubview:btnAsc];
    
    speedSlider = [[UISlider alloc] init];
    speedSlider.frame = CGRectMake(0, 40.0f, 100.0f, 30.0f);
    speedSlider.center = CGPointMake(viewToolSpeed.frame.size.width/2.0f, viewToolSpeed.frame.size.height/2.0f);
    speedSlider.minimumValue = 0.03f;
    speedSlider.maximumValue = 1.0f;
    speedSlider.value = 1.0f;
    speedSlider.backgroundColor = [UIColor clearColor];
    speedSlider.tintColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    speedSlider.userInteractionEnabled = YES;
    [speedSlider addTarget:self action:@selector(valueChangeSpeed) forControlEvents:UIControlEventTouchUpInside];
    CGAffineTransform trans = CGAffineTransformMakeRotation(-M_PI_2);
    speedSlider.transform = trans;
    [viewToolSpeed addSubview:speedSlider];
    
    btnDecs = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDecs.frame = CGRectMake(0, viewToolSpeed.frame.size.height - 25.0f, 40.0f, 25.0f);
    btnDecs.tag = 1002;
    [btnDecs setBackgroundImage:[UIImage imageNamed:@"DecsSpeedVideo.png"] forState:UIControlStateNormal];
    [btnDecs addTarget:self action:@selector(controlSpeedSVideo:) forControlEvents:UIControlEventTouchDown];
    [viewToolSpeed addSubview:btnDecs];

    // Control video
    btnControl = [UIButton buttonWithType:UIButtonTypeCustom];
    btnControl.frame = CGRectMake(0, self.view.frame.size.height - 40.0f, 40.0f, 40.0f);
    [btnControl setBackgroundImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
    [btnControl addTarget:self action:@selector(controlMovie) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnControl];
    
     // ----------- Host video
    progressPlayingHost = [[UIProgressView alloc] init];
    [progressPlayingHost setProgressTintColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f]];
    [progressPlayingHost setUserInteractionEnabled:NO];
    progressPlayingHost.progress = 1.0f;
    [progressPlayingHost setProgressViewStyle:UIProgressViewStyleBar];
    [progressPlayingHost setTrackTintColor:[UIColor whiteColor]];
    [self.view addSubview:progressPlayingHost];
    
    viewGestureHost = [[UIView alloc] init];
    viewGestureHost.backgroundColor = [UIColor clearColor];
    viewGestureHost.userInteractionEnabled = YES;
    [self.view addSubview:viewGestureHost];
    
    
    // Pan gesture host
    panHost = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panHost.delegate = self;
    [viewGestureHost addGestureRecognizer:panHost];
    
    // Total time
    iviewLabelTimeHost = [[UIImageView alloc] init];
    iviewLabelTimeHost.image = [UIImage imageNamed:@"SignLabelTimeVideo.png"];
    iviewLabelTimeHost.userInteractionEnabled = YES;
    lblcurrentTimeHost = [[UILabel alloc] init];
    [lblcurrentTimeHost setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:8.0f]];
    lblcurrentTimeHost.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    lblcurrentTimeHost.textAlignment = NSTextAlignmentCenter;
    lblcurrentTimeHost.text = [self secondsToMMSS:CMTimeGetSeconds(self._PlayerHost.currentItem.currentTime)];
    [iviewLabelTimeHost addSubview:lblcurrentTimeHost];
    [viewGestureHost addSubview:iviewLabelTimeHost];

    
    // ----------- Compare video
    progressPlaying = [[UIProgressView alloc] init];
    // Remove the slider filling default blue color
    [progressPlaying setProgressTintColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f]];
    [progressPlaying setUserInteractionEnabled:NO];
    progressPlaying.progress = 1.0f;
    [progressPlaying setProgressViewStyle:UIProgressViewStyleBar];
    [progressPlaying setTrackTintColor:[UIColor whiteColor]];
    [self.view addSubview:progressPlaying];
    
    viewGestureCompare = [[UIView alloc] init];
    viewGestureCompare.backgroundColor = [UIColor clearColor];
    viewGestureCompare.userInteractionEnabled = YES;
    [self.view addSubview:viewGestureCompare];

    // Pan gesture compare
    pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanCompare:)];
    pan.delegate = self;
    [viewGestureCompare addGestureRecognizer:pan];
    
    // Total time
    iviewLabelTime = [[UIImageView alloc] init];
    iviewLabelTime.image = [UIImage imageNamed:@"SignLabelTimeVideo.png"];
    iviewLabelTime.userInteractionEnabled = YES;
    lblcurrentTime = [[UILabel alloc] init];
    lblcurrentTime.text = [self secondsToMMSS:CMTimeGetSeconds(self._PlayerCompare.currentItem.currentTime)];
    [lblcurrentTime setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:8.0f]];
    lblcurrentTime.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    lblcurrentTime.textAlignment = NSTextAlignmentCenter;
    lblcurrentTime.text = [self secondsToMMSS:CMTimeGetSeconds(self._PlayerCompare.currentItem.currentTime)];

    [iviewLabelTime addSubview:lblcurrentTime];
    [viewGestureCompare addSubview:iviewLabelTime];
    
    [self modeViewSVideo];
}

-(void)controlSpeedSVideo:(UIButton*)sender {
    if (sender.tag == 1002) {
        if (speedSlider.value < 0.2f) {
            speedSlider.value = 0.03f;
            NSLog(@"Speed: %f", speedSlider.value);
        } else {
            speedSlider.value -= 0.2f;
        }
    } else {
        if (speedSlider.value > 0.8f) {
            speedSlider.value = 1.0f;
        } else {
            speedSlider.value += 0.2f;
        }
    }
    
    CMClockRef syncTime = CMClockGetHostTimeClock();
    CMTime hostTime = CMClockGetTime(syncTime);
    [_PlayerHost setRate:speedSlider.value time:kCMTimeInvalid atHostTime:hostTime];
    [_PlayerCompare setRate:speedSlider.value time:kCMTimeInvalid atHostTime:hostTime];
    isHostPlaying = YES;
    isComparePlaying = YES;
    [btnControl setBackgroundImage:[UIImage imageNamed:@"Pause.png"] forState:UIControlStateNormal];
    if (playingTimer == nil) {
        playingTimer = [[NSTimer alloc] init];
        playingTimer = [NSTimer scheduledTimerWithTimeInterval:0.03f
                                                        target:self
                                                      selector:@selector(updatePlayingTimer)
                                                      userInfo:nil
                                                       repeats:YES];
        
    }
}

-(void)modeViewSVideo
{
    if (isOrient) {
        if (self.view.frame.size.width <= 320.0f) {
            if (isTranparancy) {
                transparentSlider.hidden = NO;
                [layerCompare setOpacity:0.5f];
                
                [viewTopTool setFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0f)];
                [btnBackToList setFrame:CGRectMake(15.0f, 5.0f, 30.0f, 30.0f)];
                [btnModeView setFrame:CGRectMake(viewTopTool.frame.size.width/2.0f - 15.0f, 5.0, 30.0f, 30.0f)];
                [btnSaveCompare setFrame:CGRectMake(viewTopTool.frame.size.width - 45.0f, 5.0f, 30.0f, 30.0f)];
                viewDrawTool.frame = CGRectMake(self.view.frame.size.width - 40.0f, 40.0f, 40.0f, self.view.frame.size.height - 40.0f);
                viewToolSpeed.center = CGPointMake(25.0f, 40.0f + (self.view.frame.size.height - 40.0f)/2.0f);
                
                layerHost.frame = CGRectMake(0, 40.0f, self.view.frame.size.width - 40.0f, (self.view.frame.size.height - 40.0f));
                layerCompare.frame = CGRectMake(0, 40.0f, self.view.frame.size.width - 40.0f, (self.view.frame.size.height - 40.0f));
                _DrawView.frame = CGRectMake(0, 0, self.view.frame.size.width - 40.0f, self.view.frame.size.height - 40.0f);
                transparentSlider.center = CGPointMake((self.view.frame.size.width - 40.0f)/2.0f, 90.0f);
                btnControl.frame = CGRectMake(0, self.view.frame.size.height - 40.0f, 40.0f, 40.0f);
                progressPlayingHost.frame = CGRectMake(53.0f, btnControl.frame.origin.y + btnControl.frame.size.height/2.0f - 2.0f, (self.view.frame.size.width - 108.0f)/2.0f, 2.0f);
                progressPlaying.frame = CGRectMake(progressPlayingHost.frame.origin.x + progressPlayingHost.frame.size.width + 2.0f, progressPlayingHost.frame.origin.y, progressPlayingHost.frame.size.width, 2.0f);
                viewGestureHost.frame = CGRectMake(progressPlayingHost.frame.origin.x - 13.0f, progressPlayingHost.frame.origin.y - 23.0f, progressPlayingHost.frame.size.width + 26.0f, 26.0f);
                viewGestureCompare.frame = CGRectMake(progressPlaying.frame.origin.x - 13.0f, viewGestureHost.frame.origin.y, viewGestureHost.frame.size.width, 26.0f);
                iviewLabelTimeHost.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                lblcurrentTimeHost.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                
                self.view.alpha = 0.3f;
                [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.view setAlpha:1.0f];
                } completion:nil];
                
            } else {
                transparentSlider.hidden = YES;
                [layerCompare setOpacity:1.0f];
                
                [viewTopTool setFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0f)];
                [btnBackToList setFrame:CGRectMake(15.0f, 5.0f, 30.0f, 30.0f)];
                [btnModeView setFrame:CGRectMake(viewTopTool.frame.size.width/2.0f - 15.0f, 5.0, 30.0f, 30.0f)];
                [btnSaveCompare setFrame:CGRectMake(viewTopTool.frame.size.width - 45.0f, 5.0f, 30.0f, 30.0f)];
                viewDrawTool.frame = CGRectMake(self.view.frame.size.width - 40.0f, 40.0f, 40.0f, self.view.frame.size.height - 40.0f);
                viewToolSpeed.center = CGPointMake(25.0f, 40.0f + (self.view.frame.size.height - 40.0f)/2.0f);
                
                layerHost.frame = CGRectMake(0, 40.0f, self.view.frame.size.width - 40.0f, (self.view.frame.size.height - 40.0f)/2.0f);
                layerCompare.frame = CGRectMake(0, layerHost.frame.origin.y + layerHost.frame.size.height, self.view.frame.size.width - 40.0f, (self.view.frame.size.height - 40.0f)/2.0f);
                _DrawView.frame = CGRectMake(0, 40.0f, self.view.frame.size.width - 40.0f, self.view.frame.size.height - 40.0f);
                transparentSlider.center = CGPointMake((self.view.frame.size.width - 40.0f)/2.0f, 90.0f);
                btnControl.frame = CGRectMake(0, self.view.frame.size.height - 40.0f, 40.0f, 40.0f);
                progressPlayingHost.frame = CGRectMake(53.0f, btnControl.frame.origin.y + btnControl.frame.size.height/2.0f - 2.0f, (self.view.frame.size.width - 108.0f)/2.0f, 2.0f);
                progressPlaying.frame = CGRectMake(progressPlayingHost.frame.origin.x + progressPlayingHost.frame.size.width + 2.0f, progressPlayingHost.frame.origin.y, progressPlayingHost.frame.size.width, 2.0f);
                viewGestureHost.frame = CGRectMake(progressPlayingHost.frame.origin.x - 13.0f, progressPlayingHost.frame.origin.y - 23.0f, progressPlayingHost.frame.size.width + 26.0f, 26.0f);
                viewGestureCompare.frame = CGRectMake(progressPlaying.frame.origin.x - 13.0f, viewGestureHost.frame.origin.y, viewGestureHost.frame.size.width, 26.0f);
                iviewLabelTimeHost.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                lblcurrentTimeHost.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
            }
        } else {
            if (!isTranparancy) {
                transparentSlider.hidden = NO;
                [layerCompare setOpacity:0.5f];
                
                [viewTopTool setFrame:CGRectMake(0, 0, self.view.frame.size.height, 40.0f)];
                [btnBackToList setFrame:CGRectMake(15.0f, 5.0f, 30.0f, 30.0f)];
                [btnModeView setFrame:CGRectMake(viewTopTool.frame.size.width/2.0f - 15.0f, 5.0, 30.0f, 30.0f)];
                [btnSaveCompare setFrame:CGRectMake(viewTopTool.frame.size.width - 45.0f, 5.0f, 30.0f, 30.0f)];
                viewDrawTool.frame = CGRectMake(self.view.frame.size.height - 40.0f, 40.0f, 40.0f, self.view.frame.size.width - 40.0f);
                viewToolSpeed.center = CGPointMake(25.0f, 40.0f + (self.view.frame.size.width - 40.0f)/2.0f);
                
                layerHost.frame = CGRectMake(0, 40.0f, self.view.frame.size.height - 40.0f, (self.view.frame.size.width - 40.0f));
                layerCompare.frame = CGRectMake(0, 40.0f, self.view.frame.size.height - 40.0f, (self.view.frame.size.width - 40.0f));
                _DrawView.frame = CGRectMake(0, 0, self.view.frame.size.height - 40.0f, self.view.frame.size.width - 40.0f);
                transparentSlider.center = CGPointMake((self.view.frame.size.height - 40.0f)/2.0f, 90.0f);
                btnControl.frame = CGRectMake(0, self.view.frame.size.width - 40.0f, 40.0f, 40.0f);
                progressPlayingHost.frame = CGRectMake(53.0f, btnControl.frame.origin.y + btnControl.frame.size.height/2.0f - 2.0f, (self.view.frame.size.height - 108.0f)/2.0f, 2.0f);
                progressPlaying.frame = CGRectMake(progressPlayingHost.frame.origin.x + progressPlayingHost.frame.size.width + 2.0f, progressPlayingHost.frame.origin.y, progressPlayingHost.frame.size.width, 2.0f);
                viewGestureHost.frame = CGRectMake(progressPlayingHost.frame.origin.x - 13.0f, progressPlayingHost.frame.origin.y - 23.0f, progressPlayingHost.frame.size.width + 26.0f, 26.0f);
                viewGestureCompare.frame = CGRectMake(progressPlaying.frame.origin.x - 13.0f, viewGestureHost.frame.origin.y, viewGestureHost.frame.size.width, 26.0f);
                iviewLabelTimeHost.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                lblcurrentTimeHost.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
            } else {
                transparentSlider.hidden = YES;
                [layerCompare setOpacity:1.0f];
                
                [viewTopTool setFrame:CGRectMake(0, 0, self.view.frame.size.height, 40.0f)];
                [btnBackToList setFrame:CGRectMake(15.0f, 5.0f, 30.0f, 30.0f)];
                [btnModeView setFrame:CGRectMake(viewTopTool.frame.size.width/2.0f - 15.0f, 5.0, 30.0f, 30.0f)];
                [btnSaveCompare setFrame:CGRectMake(viewTopTool.frame.size.width - 45.0f, 5.0f, 30.0f, 30.0f)];
                viewDrawTool.frame = CGRectMake(self.view.frame.size.height - 40.0f, 40.0f, 40.0f, self.view.frame.size.width - 40.0f);
                viewToolSpeed.center = CGPointMake(25.0f, 40.0f + (self.view.frame.size.width - 40.0f)/2.0f);
                
                layerHost.frame = CGRectMake(0, 40.0f, self.view.frame.size.height - 40.0f, (self.view.frame.size.width - 40.0f)/2.0f);
                layerCompare.frame = CGRectMake(0, layerHost.frame.origin.y + layerHost.frame.size.height, self.view.frame.size.height - 40.0f, (self.view.frame.size.width - 40.0f)/2.0f);
                _DrawView.frame = CGRectMake(0, 40.0f, self.view.frame.size.height - 40.0f, self.view.frame.size.width - 40.0f);
                transparentSlider.center = CGPointMake((self.view.frame.size.height - 40.0f)/2.0f, 90.0f);
                btnControl.frame = CGRectMake(0, self.view.frame.size.width - 40.0f, 40.0f, 40.0f);
                progressPlayingHost.frame = CGRectMake(53.0f, btnControl.frame.origin.y + btnControl.frame.size.height/2.0f - 2.0f, (self.view.frame.size.height - 108.0f)/2.0f, 2.0f);
                progressPlaying.frame = CGRectMake(progressPlayingHost.frame.origin.x + progressPlayingHost.frame.size.width + 2.0f, progressPlayingHost.frame.origin.y, progressPlayingHost.frame.size.width, 2.0f);
                viewGestureHost.frame = CGRectMake(progressPlayingHost.frame.origin.x - 13.0f, progressPlayingHost.frame.origin.y - 23.0f, progressPlayingHost.frame.size.width + 26.0f, 26.0f);
                viewGestureCompare.frame = CGRectMake(progressPlaying.frame.origin.x - 13.0f, viewGestureHost.frame.origin.y, viewGestureHost.frame.size.width, 26.0f);
                iviewLabelTimeHost.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                lblcurrentTimeHost.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
            }
        }
    } else {
        if (self.view.frame.size.width <= 320.0f) {
            if (isTranparancy) {
                transparentSlider.hidden = YES;
                [layerCompare setOpacity:1.0f];
                
                [viewTopTool setFrame:CGRectMake(0, 0, self.view.frame.size.height, 40.0f)];
                [btnBackToList setFrame:CGRectMake(15.0f, 5.0f, 30.0f, 30.0f)];
                [btnModeView setFrame:CGRectMake(viewTopTool.frame.size.width/2.0f - 15.0f, 5.0, 30.0f, 30.0f)];
                [btnSaveCompare setFrame:CGRectMake(viewTopTool.frame.size.width - 45.0f, 5.0f, 30.0f, 30.0f)];
                viewDrawTool.frame = CGRectMake(self.view.frame.size.height - 40.0f, 40.0f, 40.0f, self.view.frame.size.width - 40.0f);
                viewToolSpeed.center = CGPointMake(25.0f, 40.0f + (self.view.frame.size.width - 40.0f)/2.0f);
                
                layerHost.frame = CGRectMake(0, 40.0f, self.view.frame.size.height - 40.0f, self.view.frame.size.width - 40.0f);
                layerCompare.frame = CGRectMake(0, layerHost.frame.origin.y + layerHost.frame.size.height, self.view.frame.size.height - 40.0f, self.view.frame.size.width - 40.0f);
                _DrawView.frame = CGRectMake(0, 40.0f, self.view.frame.size.height - 40.0f, self.view.frame.size.width - 40.0f);
                transparentSlider.center = CGPointMake((self.view.frame.size.height - 40.0f)/2.0f, 90.0f);
                btnControl.frame = CGRectMake(0, self.view.frame.size.width - 40.0f, 40.0f, 40.0f);
                progressPlayingHost.frame = CGRectMake(53.0f, btnControl.frame.origin.y + btnControl.frame.size.height/2.0f - 2.0f, (self.view.frame.size.height - 108.0f)/2.0f, 2.0f);
                progressPlaying.frame = CGRectMake(progressPlayingHost.frame.origin.x + progressPlayingHost.frame.size.width + 2.0f, progressPlayingHost.frame.origin.y, progressPlayingHost.frame.size.width, 2.0f);
                viewGestureHost.frame = CGRectMake(progressPlayingHost.frame.origin.x - 13.0f, progressPlayingHost.frame.origin.y - 23.0f, progressPlayingHost.frame.size.width + 26.0f, 26.0f);
                viewGestureCompare.frame = CGRectMake(progressPlaying.frame.origin.x - 13.0f, viewGestureHost.frame.origin.y, viewGestureHost.frame.size.width, 26.0f);
                iviewLabelTimeHost.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                lblcurrentTimeHost.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
            } else {
                transparentSlider.hidden = NO;
                [layerCompare setOpacity:0.5f];
                
                [viewTopTool setFrame:CGRectMake(0, 0, self.view.frame.size.height, 40.0f)];
                [btnBackToList setFrame:CGRectMake(15.0f, 5.0f, 30.0f, 30.0f)];
                [btnModeView setFrame:CGRectMake(viewTopTool.frame.size.width/2.0f - 15.0f, 5.0, 30.0f, 30.0f)];
                [btnSaveCompare setFrame:CGRectMake(viewTopTool.frame.size.width - 45.0f, 5.0f, 30.0f, 30.0f)];
                viewDrawTool.frame = CGRectMake(self.view.frame.size.height - 40.0f, 40.0f, 40.0f, self.view.frame.size.width - 40.0f);
                viewToolSpeed.center = CGPointMake(25.0f, 40.0f + (self.view.frame.size.width - 40.0f)/2.0f);
                
                layerHost.frame = CGRectMake(0, 40.0f, (self.view.frame.size.height - 40.0f)/2.0f, self.view.frame.size.width - 40.0f);
                layerCompare.frame = CGRectMake(0, layerHost.frame.origin.y + layerHost.frame.size.height, (self.view.frame.size.height - 40.0f)/2.0f, self.view.frame.size.width - 40.0f);
                _DrawView.frame = CGRectMake(0, 40.0f, self.view.frame.size.height - 40.0f, self.view.frame.size.width - 40.0f);
                transparentSlider.center = CGPointMake((self.view.frame.size.height - 40.0f)/2.0f, 90.0f);
                btnControl.frame = CGRectMake(0, self.view.frame.size.width - 40.0f, 40.0f, 40.0f);
                progressPlayingHost.frame = CGRectMake(53.0f, btnControl.frame.origin.y + btnControl.frame.size.height/2.0f - 2.0f, (self.view.frame.size.height - 108.0f)/2.0f, 2.0f);
                progressPlaying.frame = CGRectMake(progressPlayingHost.frame.origin.x + progressPlayingHost.frame.size.width + 2.0f, progressPlayingHost.frame.origin.y, progressPlayingHost.frame.size.width, 2.0f);
                viewGestureHost.frame = CGRectMake(progressPlayingHost.frame.origin.x - 13.0f, progressPlayingHost.frame.origin.y - 23.0f, progressPlayingHost.frame.size.width + 26.0f, 26.0f);
                viewGestureCompare.frame = CGRectMake(progressPlaying.frame.origin.x - 13.0f, viewGestureHost.frame.origin.y, viewGestureHost.frame.size.width, 26.0f);
                iviewLabelTimeHost.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                lblcurrentTimeHost.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
            }
            
        } else {
            if (!isTranparancy) {
                transparentSlider.hidden = YES;
                [layerCompare setOpacity:1.0f];
                
                [viewTopTool setFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0f)];
                [btnBackToList setFrame:CGRectMake(15.0f, 5.0f, 30.0f, 30.0f)];
                [btnModeView setFrame:CGRectMake(viewTopTool.frame.size.width/2.0f - 15.0f, 5.0, 30.0f, 30.0f)];
                [btnSaveCompare setFrame:CGRectMake(viewTopTool.frame.size.width - 45.0f, 5.0f, 30.0f, 30.0f)];
                viewDrawTool.frame = CGRectMake(self.view.frame.size.width - 40.0f, 40.0f, 40.0f, self.view.frame.size.height - 40.0f);
                viewToolSpeed.center = CGPointMake(25.0f, 40.0f + (self.view.frame.size.height - 40.0f)/2.0f);
                
                layerHost.frame = CGRectMake(0, 40.0f, (self.view.frame.size.width - 40.0f)/2.0f, self.view.frame.size.height - 40.0f);
                layerCompare.frame = CGRectMake(layerHost.frame.origin.x + layerHost.frame.size.width, 40.0f, (self.view.frame.size.width - 40.0f)/2.0f, self.view.frame.size.height - 40.0f);
                _DrawView.frame = CGRectMake(0, 40.0f, self.view.frame.size.width - 40.0f, self.view.frame.size.height - 40.0f);
                transparentSlider.center = CGPointMake((self.view.frame.size.width - 40.0f)/2.0f, 90.0f);
                btnControl.frame = CGRectMake(0, self.view.frame.size.height - 40.0f, 40.0f, 40.0f);
                progressPlayingHost.frame = CGRectMake(53.0f, btnControl.frame.origin.y + btnControl.frame.size.height/2.0f - 2.0f, (self.view.frame.size.width - 108.0f)/2.0f, 2.0f);
                progressPlaying.frame = CGRectMake(progressPlayingHost.frame.origin.x + progressPlayingHost.frame.size.width + 2.0f, progressPlayingHost.frame.origin.y, progressPlayingHost.frame.size.width, 2.0f);
                viewGestureHost.frame = CGRectMake(progressPlayingHost.frame.origin.x - 13.0f, progressPlayingHost.frame.origin.y - 23.0f, progressPlayingHost.frame.size.width + 26.0f, 26.0f);
                viewGestureCompare.frame = CGRectMake(progressPlaying.frame.origin.x - 13.0f, viewGestureHost.frame.origin.y, viewGestureHost.frame.size.width, 26.0f);
                iviewLabelTimeHost.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                lblcurrentTimeHost.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
            } else {
                transparentSlider.hidden = NO;
                [layerCompare setOpacity:0.5f];
                
                [viewTopTool setFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0f)];
                [btnBackToList setFrame:CGRectMake(15.0f, 5.0f, 30.0f, 30.0f)];
                [btnModeView setFrame:CGRectMake(viewTopTool.frame.size.width/2.0f - 15.0f, 5.0, 30.0f, 30.0f)];
                [btnSaveCompare setFrame:CGRectMake(viewTopTool.frame.size.width - 45.0f, 5.0f, 30.0f, 30.0f)];
                viewDrawTool.frame = CGRectMake(self.view.frame.size.width - 40.0f, 40.0f, 40.0f, self.view.frame.size.height - 40.0f);
                viewToolSpeed.center = CGPointMake(25.0f, 40.0f + (self.view.frame.size.height - 40.0f)/2.0f);
                
                layerHost.frame = CGRectMake(0, 40.0f, self.view.frame.size.width - 40.0f, self.view.frame.size.height - 40.0f);
                layerCompare.frame = CGRectMake(0, 40.0f, self.view.frame.size.width - 40.0f, self.view.frame.size.height - 40.0f);
                _DrawView.frame = CGRectMake(0, 40.0f, self.view.frame.size.width - 40.0f, self.view.frame.size.height - 40.0f);
                transparentSlider.center = CGPointMake((self.view.frame.size.width - 40.0f)/2.0f, 90.0f);
                btnControl.frame = CGRectMake(0, self.view.frame.size.height - 40.0f, 40.0f, 40.0f);
                progressPlayingHost.frame = CGRectMake(53.0f, btnControl.frame.origin.y + btnControl.frame.size.height/2.0f - 2.0f, (self.view.frame.size.width - 108.0f)/2.0f, 2.0f);
                progressPlaying.frame = CGRectMake(progressPlayingHost.frame.origin.x + progressPlayingHost.frame.size.width + 2.0f, progressPlayingHost.frame.origin.y, progressPlayingHost.frame.size.width, 2.0f);
                viewGestureHost.frame = CGRectMake(progressPlayingHost.frame.origin.x - 13.0f, progressPlayingHost.frame.origin.y - 23.0f, progressPlayingHost.frame.size.width + 26.0f, 26.0f);
                viewGestureCompare.frame = CGRectMake(progressPlaying.frame.origin.x - 13.0f, viewGestureHost.frame.origin.y, viewGestureHost.frame.size.width, 26.0f);
                iviewLabelTimeHost.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                lblcurrentTimeHost.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
            }
        }
    }
    
    lenghtTHost = progressPlayingHost.frame.size.width;
    durationTimeHost = self._PlayerHost.currentItem.asset.duration;
    durationTHost = (float)CMTimeGetSeconds(durationTimeHost);
    float value = CMTimeGetSeconds(self._PlayerHost.currentItem.currentTime)/CMTimeGetSeconds(durationTimeHost);
    progressPlayingHost.progress = value;
    
    
    lenghtT = progressPlaying.frame.size.width;
    durationTime = self._PlayerCompare.currentItem.asset.duration;
    durationT = (float)CMTimeGetSeconds(durationTime);
    float valueCompare = CMTimeGetSeconds(self._PlayerCompare.currentItem.currentTime)/CMTimeGetSeconds(durationTime);
    progressPlaying.progress = valueCompare;
    
    isTranparancy = !isTranparancy;
    
}

-(void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint location = [gestureRecognizer locationInView:viewGestureHost];
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        if ([viewGestureHost pointInside:location withEvent:nil]) {
            [_PlayerHost pause];
            [_PlayerCompare pause];
            [playingTimerHost invalidate];
            playingTimerHost = nil;
            [playingTimer invalidate];
            playingTimer = nil;
            [btnControl setBackgroundImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
            isSetPosition = YES;
        }
    } else {
        if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
            if (location.x <= 13.0f) {
                location.x = 13.0f;
            }
            if (location.x >= viewGestureHost.frame.size.width - 13.0f) {
                location.x = viewGestureHost.frame.size.width - 13.0f;
            }
            if (location.x <= 13.0f) {
                currentPointerHost = 0;
            } else {
                if (location.x >= viewGestureHost.frame.size.width - 13.0f) {
                    currentPointerHost = progressPlayingHost.frame.size.width;
                } else {
                    currentPointerHost = location.x - 13.0f;
                }
            }
            
            iviewLabelTimeHost.center = CGPointMake(location.x, 13.0f);
            double ratio = currentPointerHost/progressPlayingHost.frame.size.width;
            NSLog(@"%lf", ratio*durationTHost);
            lblcurrentTimeHost.text = [self secondsToMMSS:ratio*durationTHost];
            [_PlayerHost seekToTime:CMTimeMakeWithSeconds((float)ratio*durationTHost, NSEC_PER_SEC)];
            [progressPlayingHost setProgress:(float)ratio];
            
            if (playingTimerHost == nil) {
                playingTimerHost = [[NSTimer alloc] init];
                playingTimerHost = [NSTimer scheduledTimerWithTimeInterval:0.03f
                                                                target:self
                                                              selector:@selector(updatePlayingTimerHost)
                                                              userInfo:nil
                                                               repeats:YES];
            }
            
        } else {
            if (location.x <= 13.0f) {
                location.x = 13.0f;
            }
            if (location.x >= viewGestureHost.frame.size.width - 13.0f) {
                location.x = viewGestureHost.frame.size.width - 13.0f;
            }
            if (location.x <= 13.0f) {
                currentPointerHost = 0;
            } else {
                if (location.x >= viewGestureHost.frame.size.width - 13.0f) {
                    currentPointerHost = progressPlayingHost.frame.size.width;
                } else {
                    currentPointerHost = location.x - 13.0f;
                }
            }
            
            iviewLabelTimeHost.center = CGPointMake(location.x, 13.0f);
            double ratio = currentPointerHost/progressPlayingHost.frame.size.width;
            lblcurrentTimeHost.text = [self secondsToMMSS:ratio*durationTHost];
            [_PlayerHost seekToTime:CMTimeMakeWithSeconds((float)ratio*durationTHost, NSEC_PER_SEC)];
            [progressPlayingHost setProgress:(float)ratio];
        }
    }
}

- (void)handlePanCompare:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint location = [gestureRecognizer locationInView:viewGestureCompare];
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        if ([viewGestureCompare pointInside:location withEvent:nil]) {
            [_PlayerCompare pause];
            [_PlayerHost pause];
            [playingTimer invalidate];
            playingTimer = nil;
            [playingTimerHost invalidate];
            playingTimerHost = nil;
            [btnControl setBackgroundImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
            isSetPosition = YES;
        }
    } else {
        if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
            
            if (location.x <= 13.0f) {
                location.x = 13.0f;
            }
            if (location.x >= viewGestureCompare.frame.size.width - 13.0f) {
                location.x = viewGestureCompare.frame.size.width - 13.0f;
            }
            
            if (location.x <= 13.0f) {
                currentPointerCompare = 0;
            } else {
                if (location.x >= viewGestureCompare.frame.size.width - 13.0f) {
                    currentPointerCompare = progressPlaying.frame.size.width;
                } else {
                    currentPointerCompare = location.x - 13.0f;
                }
            }
            
            iviewLabelTime.center = CGPointMake(location.x, 13.0f);
            double ratio = currentPointerCompare/progressPlaying.frame.size.width;
            NSLog(@"%lf", ratio*durationT);
            lblcurrentTime.text = [self secondsToMMSS:ratio*durationT];
            [_PlayerCompare seekToTime:CMTimeMakeWithSeconds((float)ratio*durationT, NSEC_PER_SEC)];
            [progressPlaying setProgress:(float)ratio];
            
            if (playingTimer == nil) {
                playingTimer = [[NSTimer alloc] init];
                playingTimer = [NSTimer scheduledTimerWithTimeInterval:0.03f
                                                                    target:self
                                                                  selector:@selector(updatePlayingTimer)
                                                                  userInfo:nil
                                                                   repeats:YES];
            }
        } else {
            if (location.x <= 13.0f) {
                location.x = 13.0f;
            }
            if (location.x >= viewGestureCompare.frame.size.width - 13.0f) {
                location.x = viewGestureCompare.frame.size.width - 13.0f;
            }
            
            if (location.x <= 13.0f) {
                currentPointerCompare = 0;
            } else {
                if (location.x >= viewGestureCompare.frame.size.width - 13.0f) {
                    currentPointerCompare = progressPlaying.frame.size.width;
                } else {
                    currentPointerCompare = location.x - 13.0f;
                }
            }
            
            iviewLabelTime.center = CGPointMake(location.x, 13.0f);
            double ratio = currentPointerCompare/progressPlaying.frame.size.width;
            NSLog(@"%lf", ratio);
            lblcurrentTime.text = [self secondsToMMSS:ratio*durationT];
            [_PlayerCompare seekToTime:CMTimeMakeWithSeconds((float)ratio*durationT, NSEC_PER_SEC)];
            [progressPlaying setProgress:(float)ratio];
        }
    }
}

-(void)changeOpacitySvideo
{
    [layerCompare setOpacity:transparentSlider.value];
}

-(void)valueChangeSpeed
{
    CMClockRef syncTime = CMClockGetHostTimeClock();
    CMTime hostTime = CMClockGetTime(syncTime);
    [_PlayerHost setRate:speedSlider.value time:kCMTimeInvalid atHostTime:hostTime];
    [_PlayerCompare setRate:speedSlider.value time:kCMTimeInvalid atHostTime:hostTime];
    isHostPlaying = YES;
    isComparePlaying = YES;
    [btnControl setBackgroundImage:[UIImage imageNamed:@"Pause.png"] forState:UIControlStateNormal];
    if (playingTimerHost == nil) {
        playingTimerHost = [[NSTimer alloc] init];
        playingTimerHost = [NSTimer scheduledTimerWithTimeInterval:0.03f
                                                        target:self
                                                      selector:@selector(updatePlayingTimerHost)
                                                      userInfo:nil
                                                       repeats:YES];
    }
    if (playingTimer == nil) {
        playingTimer = [[NSTimer alloc] init];
        playingTimer = [NSTimer scheduledTimerWithTimeInterval:0.03f
                                                        target:self
                                                      selector:@selector(updatePlayingTimer)
                                                      userInfo:nil
                                                       repeats:YES];
    }
}

-(void)controlMovie
{
    // ----------- Host
    if ((isHostPlaying && !isComparePlaying) || (!isHostPlaying && isComparePlaying)) {
        [_PlayerHost pause];
        [_PlayerCompare pause];
        isHostPlaying = NO;
        isComparePlaying = NO;
    } else {
        if ([_PlayerHost rate] != 0)
        {
            if (!isHostPlaying) {
                CMClockRef syncTime = CMClockGetHostTimeClock();
                CMTime hostTime = CMClockGetTime(syncTime);
                [_PlayerHost setRate:speedSlider.value time:kCMTimeInvalid atHostTime:hostTime];
                isHostPlaying = YES;
                isBothPause = NO;
            } else {
                [_PlayerHost pause];
                isHostPlaying = NO;
            }
        } else {
            
            if (playingTimerHost == nil) {
                playingTimerHost = [[NSTimer alloc] init];
                playingTimerHost = [NSTimer scheduledTimerWithTimeInterval:0.03f
                                                                    target:self
                                                                  selector:@selector(updatePlayingTimerHost)
                                                                  userInfo:nil
                                                                   repeats:YES];
                
            }
            CMClockRef syncTime = CMClockGetHostTimeClock();
            CMTime hostTime = CMClockGetTime(syncTime);
            [_PlayerHost setRate:speedSlider.value time:kCMTimeInvalid atHostTime:hostTime];
            isHostPlaying = YES;
            isBothPause = NO;
        }
        
        // -----------Compare
        if ([_PlayerCompare rate] != 0)
        {
            if (!isComparePlaying) {
                CMClockRef syncTime = CMClockGetHostTimeClock();
                CMTime hostTime = CMClockGetTime(syncTime);
                [_PlayerCompare setRate:speedSlider.value time:kCMTimeInvalid atHostTime:hostTime];
                isComparePlaying = YES;
                isBothPause = NO;
            } else {
                [_PlayerCompare pause];
                isComparePlaying = NO;
            }
        } else {
            
            if (playingTimer == nil) {
                playingTimer = [[NSTimer alloc] init];
                playingTimer = [NSTimer scheduledTimerWithTimeInterval:0.03f
                                                                target:self
                                                              selector:@selector(updatePlayingTimer)
                                                              userInfo:nil
                                                               repeats:YES];
                
            }
            CMClockRef syncTime = CMClockGetHostTimeClock();
            CMTime hostTime = CMClockGetTime(syncTime);
            [_PlayerCompare setRate:speedSlider.value time:kCMTimeInvalid atHostTime:hostTime];
            isComparePlaying = YES;
            isBothPause = NO;
        }
    }
    
    // Set control image
    if (isHostPlaying && isComparePlaying) {
        [btnControl setBackgroundImage:[UIImage imageNamed:@"Pause.png"] forState:UIControlStateNormal];
    } else {
        if (!isHostPlaying && !isComparePlaying) {
            [btnControl setBackgroundImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
        } else {
            [btnControl setBackgroundImage:[UIImage imageNamed:@"Pause.png"] forState:UIControlStateNormal];
        }
    }
}

-(void)updatePlayingTimerHost
{
    double temp = CMTimeGetSeconds(_PlayerHost.currentItem.currentTime);
    float value = (float)temp/durationTHost;
    float xPoint = 13.0f + value*lenghtTHost;
    
    if (temp <= 0 && isSetPosition) {
        temp = (durationTHost*currentPointerHost)/progressPlayingHost.frame.size.width;
        value = (float)temp/durationTHost;
        xPoint = 13.0f + value*lenghtTHost;
        iviewLabelTimeHost.center = CGPointMake(xPoint, 13.0f);
        lblcurrentTimeHost.text = [self secondsToMMSS:temp];
        [progressPlayingHost setProgress:value animated:NO];
        isSetPosition = NO;
    } else {
        if (temp <= durationTHost || xPoint <= progressPlayingHost.frame.size.width + 13.0f) {
            iviewLabelTimeHost.center = CGPointMake(xPoint, 13.0f);
            lblcurrentTimeHost.text = [self secondsToMMSS:temp];
            [progressPlayingHost setProgress:value animated:NO];
            
        } else {
            iviewLabelTimeHost.center = CGPointMake(13.0f, 13.0f);
            lblcurrentTimeHost.text = @"00:00";
            [progressPlayingHost setProgress:0 animated:NO];
            [_PlayerHost seekToTime:kCMTimeZero];
            [_PlayerHost pause];
            isHostPlaying = NO;
            if (isBothPause) {
                [btnControl setBackgroundImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
                isBothPause = NO;
            } else {
                isBothPause = YES;
            }
        }
    }
    
    if (isSetPosition) {
        [playingTimer invalidate];
        playingTimer = nil;
        isSetPosition = NO;
    }
}


-(void)updatePlayingTimer
{
    double temp = CMTimeGetSeconds(_PlayerCompare.currentItem.currentTime);
    float value = (float)temp/durationT;
    float xPoint = 13.0f + value*lenghtT;
    
    if (temp <= 0 && isSetPosition) {
        temp = (durationT*currentPointerCompare)/progressPlaying.frame.size.width;
        value = (float)temp/durationT;
        xPoint = 13.0f + value*lenghtT;
        iviewLabelTime.center = CGPointMake(xPoint, 13.0f);
        lblcurrentTime.text = [self secondsToMMSS:temp];
        [progressPlaying setProgress:value animated:NO];
        isSetPosition = NO;
    } else {
        if ((temp <= durationT) || xPoint <= progressPlaying.frame.size.width + 13.0f) {
            iviewLabelTime.center = CGPointMake(xPoint, 13.0f);
            lblcurrentTime.text = [self secondsToMMSS:temp];
            [progressPlaying setProgress:value animated:NO];
            
        } else {
            iviewLabelTime.center = CGPointMake(13.0f, 13.0f);
            lblcurrentTime.text = @"00:00";
            [progressPlaying setProgress:0 animated:NO];
            [_PlayerCompare seekToTime:kCMTimeZero];
            [_PlayerCompare pause];
            isComparePlaying = NO;
            if (isBothPause) {
                [btnControl setBackgroundImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
                isBothPause = NO;
            } else {
                isBothPause = YES;
            }
            
        }
    }
    
    if (isSetPosition) {
        [playingTimer invalidate];
        playingTimer = nil;
        isSetPosition = NO;
    }

}


-(NSString *)secondsToMMSS:(double)seconds
{
    NSInteger time = floor(seconds);
    NSInteger hh = time / 3600;
    NSInteger mm = (time / 60) % 60;
    NSInteger ss = time % 60;
    float dtick = seconds - time;
    NSInteger itick = 100*dtick;
    
    if(hh > 0)
    {
        return  [NSString stringWithFormat:@"%02i:%02i:%02i", hh, mm, ss];
    }
    else
    {
        if (mm > 0) {
            return  [NSString stringWithFormat:@"%02i:%02i", mm, ss];
        }
        else
        {
            return  [NSString stringWithFormat:@"%02i:%02i", ss, itick];
        }
    }
    
}

-(void)drawForVideo:(UIButton*)sender
{
    if (sender.tag == 100) {
        _DrawView._Line = YES;
        _DrawView._Curve = NO;
        _DrawView._Circle = NO;
        _DrawView._Rect = NO;
        [btnLine setImage:[UIImage imageNamed:@"LineSelected.png"] forState:UIControlStateNormal];
        [btnCurve setImage:[UIImage imageNamed:@"Curve.png"] forState:UIControlStateNormal];
        [btnCircle setImage:[UIImage imageNamed:@"Circle.png"] forState:UIControlStateNormal];
        [btnRectangle setImage:[UIImage imageNamed:@"Rectangle.png"] forState:UIControlStateNormal];
        [btnDelete setImage:[UIImage imageNamed:@"Trash.png"] forState:UIControlStateNormal];
    }
    else {
        if (sender.tag == 101) {
            _DrawView._Line = NO;
            _DrawView._Curve = YES;
            _DrawView._Circle = NO;
            _DrawView._Rect = NO;
            [btnLine setImage:[UIImage imageNamed:@"Line.png"] forState:UIControlStateNormal];
            [btnCurve setImage:[UIImage imageNamed:@"CurveSelected.png"] forState:UIControlStateNormal];
            [btnCircle setImage:[UIImage imageNamed:@"Circle.png"] forState:UIControlStateNormal];
            [btnRectangle setImage:[UIImage imageNamed:@"Rectangle.png"] forState:UIControlStateNormal];
            [btnDelete setImage:[UIImage imageNamed:@"Trash.png"] forState:UIControlStateNormal];
        } else {
            if (sender.tag == 102) {
                _DrawView._Curve = NO;
                _DrawView._Line = NO;
                _DrawView._Circle = YES;
                _DrawView._Rect = NO;
                [btnLine setImage:[UIImage imageNamed:@"Line.png"] forState:UIControlStateNormal];
                [btnCurve setImage:[UIImage imageNamed:@"Curve.png"] forState:UIControlStateNormal];
                [btnCircle setImage:[UIImage imageNamed:@"CircleSelected.png"] forState:UIControlStateNormal];
                [btnRectangle setImage:[UIImage imageNamed:@"Rectangle.png"] forState:UIControlStateNormal];
                [btnDelete setImage:[UIImage imageNamed:@"Trash.png"] forState:UIControlStateNormal];
            } else {
                if (sender.tag == 103) {
                    _DrawView._Curve = NO;
                    _DrawView._Line = NO;
                    _DrawView._Circle = NO;
                    _DrawView._Rect = YES;
                    [btnLine setImage:[UIImage imageNamed:@"Line.png"] forState:UIControlStateNormal];
                    [btnCurve setImage:[UIImage imageNamed:@"Curve.png"] forState:UIControlStateNormal];
                    [btnCircle setImage:[UIImage imageNamed:@"Circle.png"] forState:UIControlStateNormal];
                    [btnRectangle setImage:[UIImage imageNamed:@"RectangleSelected.png"] forState:UIControlStateNormal];
                    [btnDelete setImage:[UIImage imageNamed:@"Trash.png"] forState:UIControlStateNormal];
                } else {
                    if (sender.tag == 104) {
                        [_DrawView clear];
                        _DrawView._Curve = NO;
                        _DrawView._Line = NO;
                        _DrawView._Circle = NO;
                        _DrawView._Rect = NO;
                        [btnLine setImage:[UIImage imageNamed:@"Line.png"] forState:UIControlStateNormal];
                        [btnCurve setImage:[UIImage imageNamed:@"Curve.png"] forState:UIControlStateNormal];
                        [btnCircle setImage:[UIImage imageNamed:@"Circle.png"] forState:UIControlStateNormal];
                        [btnRectangle setImage:[UIImage imageNamed:@"Rectangle.png"] forState:UIControlStateNormal];
                        [btnDelete setImage:[UIImage imageNamed:@"TrashSelected.png"] forState:UIControlStateNormal];
                    }
                }
                
            }
        }
    }
}

-(void)backToListSVideo
{
    if (playingTimerHost) {
        [playingTimerHost invalidate];
        playingTimerHost = nil;
    }
    
    if (playingTimer) {
        [playingTimer invalidate];
        playingTimer = nil;
    }
    
    NSArray *viewsToRemoveChild = [self.view subviews];
    for (UIView *view in viewsToRemoveChild) {
        [view removeFromSuperview];
    }
    
    [_CoreGUI finishedScreen:self withCode:103];
}

-(void)saveCompareSVideo
{
    if (playingTimerHost) {
        [playingTimerHost invalidate];
        playingTimerHost = nil;
    }
    
    if (playingTimer) {
        [playingTimer invalidate];
        playingTimer = nil;
    }
    
    NSArray *viewsToRemoveChild = [self.view subviews];
    for (UIView *view in viewsToRemoveChild) {
        [view removeFromSuperview];
    }
    

    if (stringPathCompare) {
        ((SwingVideoTableViewController*)[_CoreGUI._Navi.viewControllers objectAtIndex:0])._Video._PathCompare = stringPathCompare;
        [((SwingVideoTableViewController*)[_CoreGUI._Navi.viewControllers objectAtIndex:0]) updateInfoToDatabase];
    }
    
    [_CoreGUI finishedScreen:self withCode:103];
}


- (void)layoutOfScreenForOrientStatus:(BOOL)portrait
{
    if (!allowOrient) {
        viewBackground.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        lblTitle.frame = CGRectMake(0, 0, self.view.frame.size.width, 40.0f);
        [btnExit setFrame:CGRectMake(10.0f, 5.0f, 30.0f, 30.0f)];
        [btnMaster setFrame:CGRectMake(0.5f*self.view.frame.size.width, lblTitle.frame.origin.y + lblTitle.frame.size.height, 0.5f*self.view.frame.size.width, 30.0f)];
        [btnUser setFrame:CGRectMake(0, lblTitle.frame.origin.y + lblTitle.frame.size.height, 0.5f*self.view.frame.size.width, 30.0f)];
        scrollview.frame = CGRectMake(0, 0.25f*viewBackground.frame.size.height, viewBackground.frame.size.width, 0.5f*self.view.frame.size.height);
        scrollview.contentSize = CGSizeMake(scrollview.frame.size.width * listVideoCompare.count, scrollview.frame.size.height);
        pageControl.frame = CGRectMake(0, 0, 200.0f, 36.0f);
        pageControl.center = CGPointMake(viewBackground.frame.size.width/2.0f, viewBackground.frame.size.height - (viewBackground.frame.size.height - (scrollview.frame.origin.y + scrollview.frame.size.height))/2.0f);
        
        if (isMaster) {
            [self showSVideos:btnMaster];
        } else {
            [self showSVideos:btnUser];
        }
    } else {
        if (portrait) {
            if (self.view.frame.size.width <= 320.0f) {
                if (!isTranparancy) {
                    transparentSlider.hidden = NO;
                    [layerCompare setOpacity:transparentSlider.value];
                    
                    [viewTopTool setFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0f)];
                    [btnBackToList setFrame:CGRectMake(15.0f, 5.0f, 30.0f, 30.0f)];
                    [btnModeView setFrame:CGRectMake(viewTopTool.frame.size.width/2.0f - 15.0f, 5.0, 30.0f, 30.0f)];
                    [btnSaveCompare setFrame:CGRectMake(viewTopTool.frame.size.width - 45.0f, 5.0f, 30.0f, 30.0f)];
                    viewDrawTool.frame = CGRectMake(self.view.frame.size.width - 40.0f, 40.0f, 40.0f, self.view.frame.size.height - 40.0f);
                    viewToolSpeed.center = CGPointMake(25.0f, 40.0f + (self.view.frame.size.height - 40.0f)/2.0f);
                    
                    layerHost.frame = CGRectMake(0, 40.0f, self.view.frame.size.width - 40.0f, (self.view.frame.size.height - 40.0f));
                    layerCompare.frame = CGRectMake(0, 40.0f, self.view.frame.size.width - 40.0f, (self.view.frame.size.height - 40.0f));
                    _DrawView.frame = CGRectMake(0, 40.0f, self.view.frame.size.width - 40.0f, self.view.frame.size.height - 40.0f);
                    transparentSlider.center = CGPointMake((self.view.frame.size.width - 40.0f)/2.0f, 90.0f);
                    btnControl.frame = CGRectMake(0, self.view.frame.size.height - 40.0f, 40.0f, 40.0f);
                    progressPlayingHost.frame = CGRectMake(53.0f, btnControl.frame.origin.y + btnControl.frame.size.height/2.0f - 2.0f, (self.view.frame.size.width - 108.0f)/2.0f, 2.0f);
                    progressPlaying.frame = CGRectMake(progressPlayingHost.frame.origin.x + progressPlayingHost.frame.size.width + 2.0f, progressPlayingHost.frame.origin.y, progressPlayingHost.frame.size.width, 2.0f);
                    viewGestureHost.frame = CGRectMake(progressPlayingHost.frame.origin.x - 13.0f, progressPlayingHost.frame.origin.y - 23.0f, progressPlayingHost.frame.size.width + 26.0f, 26.0f);
                    viewGestureCompare.frame = CGRectMake(progressPlaying.frame.origin.x - 13.0f, viewGestureHost.frame.origin.y, viewGestureHost.frame.size.width, 26.0f);
                    iviewLabelTimeHost.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                    iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                    lblcurrentTimeHost.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                    lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                    
                } else {
                    transparentSlider.hidden = YES;
                    [layerCompare setOpacity:1.0f];
                    
                    [viewTopTool setFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0f)];
                    [btnBackToList setFrame:CGRectMake(15.0f, 5.0f, 30.0f, 30.0f)];
                    [btnModeView setFrame:CGRectMake(viewTopTool.frame.size.width/2.0f - 15.0f, 5.0, 30.0f, 30.0f)];
                    [btnSaveCompare setFrame:CGRectMake(viewTopTool.frame.size.width - 45.0f, 5.0f, 30.0f, 30.0f)];
                    viewDrawTool.frame = CGRectMake(self.view.frame.size.width - 40.0f, 40.0f, 40.0f, self.view.frame.size.height - 40.0f);
                    viewToolSpeed.center = CGPointMake(25.0f, 40.0f + (self.view.frame.size.height - 40.0f)/2.0f);
                    
                    layerHost.frame = CGRectMake(0, 40.0f, self.view.frame.size.width - 40.0f, (self.view.frame.size.height - 40.0f)/2.0f);
                    layerCompare.frame = CGRectMake(0, layerHost.frame.origin.y + layerHost.frame.size.height, self.view.frame.size.width - 40.0f, (self.view.frame.size.height - 40.0f)/2.0f);
                    _DrawView.frame = CGRectMake(0, 40.0f, self.view.frame.size.width - 40.0f, self.view.frame.size.height - 40.0f);
                    transparentSlider.center = CGPointMake((self.view.frame.size.width - 40.0f)/2.0f, 90.0f);
                    btnControl.frame = CGRectMake(0, self.view.frame.size.height - 40.0f, 40.0f, 40.0f);
                    progressPlayingHost.frame = CGRectMake(53.0f, btnControl.frame.origin.y + btnControl.frame.size.height/2.0f - 2.0f, (self.view.frame.size.width - 108.0f)/2.0f, 2.0f);
                    progressPlaying.frame = CGRectMake(progressPlayingHost.frame.origin.x + progressPlayingHost.frame.size.width + 2.0f, progressPlayingHost.frame.origin.y, progressPlayingHost.frame.size.width, 2.0f);
                    viewGestureHost.frame = CGRectMake(progressPlayingHost.frame.origin.x - 13.0f, progressPlayingHost.frame.origin.y - 23.0f, progressPlayingHost.frame.size.width + 26.0f, 26.0f);
                    viewGestureCompare.frame = CGRectMake(progressPlaying.frame.origin.x - 13.0f, viewGestureHost.frame.origin.y, viewGestureHost.frame.size.width, 26.0f);
                    iviewLabelTimeHost.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                    iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                    lblcurrentTimeHost.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                    lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                }
                
                lenghtTHost = progressPlayingHost.frame.size.width;
                durationTimeHost = self._PlayerHost.currentItem.asset.duration;
                durationTHost = (float)CMTimeGetSeconds(durationTimeHost);
                float value = CMTimeGetSeconds(self._PlayerHost.currentItem.currentTime)/CMTimeGetSeconds(durationTimeHost);
                progressPlayingHost.progress = value;
                
                
                lenghtT = progressPlaying.frame.size.width;
                durationTime = self._PlayerCompare.currentItem.asset.duration;
                durationT = (float)CMTimeGetSeconds(durationTime);
                float valueCompare = CMTimeGetSeconds(self._PlayerCompare.currentItem.currentTime)/CMTimeGetSeconds(durationTime);
                progressPlaying.progress = valueCompare;
                
            } else {
                if (!isTranparancy) {
                    transparentSlider.hidden = NO;
                    [layerCompare setOpacity:transparentSlider.value];
                    
                    [viewTopTool setFrame:CGRectMake(0, 0, self.view.frame.size.height, 40.0f)];
                    [btnBackToList setFrame:CGRectMake(15.0f, 5.0f, 30.0f, 30.0f)];
                    [btnModeView setFrame:CGRectMake(viewTopTool.frame.size.width/2.0f - 15.0f, 5.0, 30.0f, 30.0f)];
                    [btnSaveCompare setFrame:CGRectMake(viewTopTool.frame.size.width - 45.0f, 5.0f, 30.0f, 30.0f)];
                    viewDrawTool.frame = CGRectMake(self.view.frame.size.height - 40.0f, 40.0f, 40.0f, self.view.frame.size.width - 40.0f);
                    viewToolSpeed.center = CGPointMake(25.0f, 40.0f + (self.view.frame.size.width - 40.0f)/2.0f);
                    
                    layerHost.frame = CGRectMake(0, 40.0f, self.view.frame.size.height - 40.0f, (self.view.frame.size.width - 40.0f));
                    layerCompare.frame = CGRectMake(0, 40.0f, self.view.frame.size.height - 40.0f, (self.view.frame.size.width - 40.0f));
                    _DrawView.frame = CGRectMake(0, 40.0f, self.view.frame.size.height - 40.0f, self.view.frame.size.width - 40.0f);
                    transparentSlider.center = CGPointMake((self.view.frame.size.height - 40.0f)/2.0f, 90.0f);
                    btnControl.frame = CGRectMake(0, self.view.frame.size.width - 40.0f, 40.0f, 40.0f);
                    progressPlayingHost.frame = CGRectMake(53.0f, btnControl.frame.origin.y + btnControl.frame.size.height/2.0f - 2.0f, (self.view.frame.size.height - 108.0f)/2.0f, 2.0f);
                    progressPlaying.frame = CGRectMake(progressPlayingHost.frame.origin.x + progressPlayingHost.frame.size.width + 2.0f, progressPlayingHost.frame.origin.y, progressPlayingHost.frame.size.width, 2.0f);
                    viewGestureHost.frame = CGRectMake(progressPlayingHost.frame.origin.x - 13.0f, progressPlayingHost.frame.origin.y - 23.0f, progressPlayingHost.frame.size.width + 26.0f, 26.0f);
                    viewGestureCompare.frame = CGRectMake(progressPlaying.frame.origin.x - 13.0f, viewGestureHost.frame.origin.y, viewGestureHost.frame.size.width, 26.0f);
                    iviewLabelTimeHost.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                    iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                    lblcurrentTimeHost.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                    lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                    
                } else {
                    transparentSlider.hidden = YES;
                    [layerCompare setOpacity:1.0f];
                    
                    [viewTopTool setFrame:CGRectMake(0, 0, self.view.frame.size.height, 40.0f)];
                    [btnBackToList setFrame:CGRectMake(15.0f, 5.0f, 30.0f, 30.0f)];
                    [btnModeView setFrame:CGRectMake(viewTopTool.frame.size.width/2.0f - 15.0f, 5.0, 30.0f, 30.0f)];
                    [btnSaveCompare setFrame:CGRectMake(viewTopTool.frame.size.width - 45.0f, 5.0f, 30.0f, 30.0f)];
                    viewDrawTool.frame = CGRectMake(self.view.frame.size.height - 40.0f, 40.0f, 40.0f, self.view.frame.size.width - 40.0f);
                    viewToolSpeed.center = CGPointMake(25.0f, 40.0f + (self.view.frame.size.width - 40.0f)/2.0f);
                    
                    layerHost.frame = CGRectMake(0, 40.0f, self.view.frame.size.height - 40.0f, (self.view.frame.size.width - 40.0f)/2.0f);
                    layerCompare.frame = CGRectMake(0, layerHost.frame.origin.y + layerHost.frame.size.height, self.view.frame.size.height - 40.0f, (self.view.frame.size.width - 40.0f)/2.0f);
                    _DrawView.frame = CGRectMake(0, 40.0f, self.view.frame.size.height - 40.0f, self.view.frame.size.width - 40.0f);
                    transparentSlider.center = CGPointMake((self.view.frame.size.height - 40.0f)/2.0f, 90.0f);
                    btnControl.frame = CGRectMake(0, self.view.frame.size.width - 40.0f, 40.0f, 40.0f);
                    progressPlayingHost.frame = CGRectMake(53.0f, btnControl.frame.origin.y + btnControl.frame.size.height/2.0f - 2.0f, (self.view.frame.size.height - 108.0f)/2.0f, 2.0f);
                    progressPlaying.frame = CGRectMake(progressPlayingHost.frame.origin.x + progressPlayingHost.frame.size.width + 2.0f, progressPlayingHost.frame.origin.y, progressPlayingHost.frame.size.width, 2.0f);
                    viewGestureHost.frame = CGRectMake(progressPlayingHost.frame.origin.x - 13.0f, progressPlayingHost.frame.origin.y - 23.0f, progressPlayingHost.frame.size.width + 26.0f, 26.0f);
                    viewGestureCompare.frame = CGRectMake(progressPlaying.frame.origin.x - 13.0f, viewGestureHost.frame.origin.y, viewGestureHost.frame.size.width, 26.0f);
                    iviewLabelTimeHost.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                    iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                    lblcurrentTimeHost.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                    lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                    
                }
                
                lenghtTHost = progressPlayingHost.frame.size.width;
                durationTimeHost = self._PlayerHost.currentItem.asset.duration;
                durationTHost = (float)CMTimeGetSeconds(durationTimeHost);
                float value = CMTimeGetSeconds(self._PlayerHost.currentItem.currentTime)/CMTimeGetSeconds(durationTimeHost);
                progressPlayingHost.progress = value;
                
                
                lenghtT = progressPlaying.frame.size.width;
                durationTime = self._PlayerCompare.currentItem.asset.duration;
                durationT = (float)CMTimeGetSeconds(durationTime);
                float valueCompare = CMTimeGetSeconds(self._PlayerCompare.currentItem.currentTime)/CMTimeGetSeconds(durationTime);
                progressPlaying.progress = valueCompare;
            }
        } else {
            if (self.view.frame.size.width <= 320.0f) {
                if (isTranparancy) {
                    transparentSlider.hidden = YES;
                    [layerCompare setOpacity:1.0f];
                    
                    [viewTopTool setFrame:CGRectMake(0, 0, self.view.frame.size.height, 40.0f)];
                    [btnBackToList setFrame:CGRectMake(15.0f, 5.0f, 30.0f, 30.0f)];
                    [btnModeView setFrame:CGRectMake(viewTopTool.frame.size.width/2.0f - 15.0f, 5.0, 30.0f, 30.0f)];
                    [btnSaveCompare setFrame:CGRectMake(viewTopTool.frame.size.width - 45.0f, 5.0f, 30.0f, 30.0f)];
                    viewDrawTool.frame = CGRectMake(self.view.frame.size.height - 40.0f, 40.0f, 40.0f, self.view.frame.size.width - 40.0f);
                    viewToolSpeed.center = CGPointMake(25.0f, 40.0f + (self.view.frame.size.width - 40.0f)/2.0f);
                    
                    layerHost.frame = CGRectMake(0, 40.0f, self.view.frame.size.height - 40.0f, self.view.frame.size.width - 40.0f);
                    layerCompare.frame = CGRectMake(0, layerHost.frame.origin.y + layerHost.frame.size.height, self.view.frame.size.height - 40.0f, self.view.frame.size.width - 40.0f);
                    _DrawView.frame = CGRectMake(0, 40.0f, self.view.frame.size.height - 40.0f, self.view.frame.size.width - 40.0f);
                    transparentSlider.center = CGPointMake((self.view.frame.size.height - 40.0f)/2.0f, 90.0f);
                    btnControl.frame = CGRectMake(0, self.view.frame.size.width - 40.0f, 40.0f, 40.0f);
                    progressPlayingHost.frame = CGRectMake(53.0f, btnControl.frame.origin.y + btnControl.frame.size.height/2.0f - 2.0f, (self.view.frame.size.height - 108.0f)/2.0f, 2.0f);
                    progressPlaying.frame = CGRectMake(progressPlayingHost.frame.origin.x + progressPlayingHost.frame.size.width + 2.0f, progressPlayingHost.frame.origin.y, progressPlayingHost.frame.size.width, 2.0f);
                    viewGestureHost.frame = CGRectMake(progressPlayingHost.frame.origin.x - 13.0f, progressPlayingHost.frame.origin.y - 23.0f, progressPlayingHost.frame.size.width + 26.0f, 26.0f);
                    viewGestureCompare.frame = CGRectMake(progressPlaying.frame.origin.x - 13.0f, viewGestureHost.frame.origin.y, viewGestureHost.frame.size.width, 26.0f);
                    iviewLabelTimeHost.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                    iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                    lblcurrentTimeHost.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                    lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                    
                    self.view.alpha = 0.3f;
                    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        [self.view setAlpha:1.0f];
                    } completion:nil];
                } else {
                    transparentSlider.hidden = NO;
                    [layerCompare setOpacity:transparentSlider.value];
                    
                    [viewTopTool setFrame:CGRectMake(0, 0, self.view.frame.size.height, 40.0f)];
                    [btnBackToList setFrame:CGRectMake(15.0f, 5.0f, 30.0f, 30.0f)];
                    [btnModeView setFrame:CGRectMake(viewTopTool.frame.size.width/2.0f - 15.0f, 5.0, 30.0f, 30.0f)];
                    [btnSaveCompare setFrame:CGRectMake(viewTopTool.frame.size.width - 45.0f, 5.0f, 30.0f, 30.0f)];
                    viewDrawTool.frame = CGRectMake(self.view.frame.size.height - 40.0f, 40.0f, 40.0f, self.view.frame.size.width - 40.0f);
                    viewToolSpeed.center = CGPointMake(25.0f, 40.0f + (self.view.frame.size.width - 40.0f)/2.0f);
                    
                    layerHost.frame = CGRectMake(0, 40.0f, (self.view.frame.size.height - 40.0f)/2.0f, self.view.frame.size.width - 40.0f);
                    layerCompare.frame = CGRectMake(0, 40.0f, (self.view.frame.size.height - 40.0f)/2.0f, self.view.frame.size.width - 40.0f);
                    _DrawView.frame = CGRectMake(0, 40.0f, self.view.frame.size.height - 40.0f, self.view.frame.size.width - 40.0f);
                    transparentSlider.center = CGPointMake((self.view.frame.size.height - 40.0f)/2.0f, 90.0f);
                    btnControl.frame = CGRectMake(0, self.view.frame.size.width - 40.0f, 40.0f, 40.0f);
                    progressPlayingHost.frame = CGRectMake(53.0f, btnControl.frame.origin.y + btnControl.frame.size.height/2.0f - 2.0f, (self.view.frame.size.height - 108.0f)/2.0f, 2.0f);
                    progressPlaying.frame = CGRectMake(progressPlayingHost.frame.origin.x + progressPlayingHost.frame.size.width + 2.0f, progressPlayingHost.frame.origin.y, progressPlayingHost.frame.size.width, 2.0f);
                    viewGestureHost.frame = CGRectMake(progressPlayingHost.frame.origin.x - 13.0f, progressPlayingHost.frame.origin.y - 23.0f, progressPlayingHost.frame.size.width + 26.0f, 26.0f);
                    viewGestureCompare.frame = CGRectMake(progressPlaying.frame.origin.x - 13.0f, viewGestureHost.frame.origin.y, viewGestureHost.frame.size.width, 26.0f);
                    iviewLabelTimeHost.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                    iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                    lblcurrentTimeHost.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                    lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                }
                
                
                lenghtTHost = progressPlayingHost.frame.size.width;
                durationTimeHost = self._PlayerHost.currentItem.asset.duration;
                durationTHost = (float)CMTimeGetSeconds(durationTimeHost);
                float value = CMTimeGetSeconds(self._PlayerHost.currentItem.currentTime)/CMTimeGetSeconds(durationTimeHost);
                progressPlayingHost.progress = value;
                
                
                lenghtT = progressPlaying.frame.size.width;
                durationTime = self._PlayerCompare.currentItem.asset.duration;
                durationT = (float)CMTimeGetSeconds(durationTime);
                float valueCompare = CMTimeGetSeconds(self._PlayerCompare.currentItem.currentTime)/CMTimeGetSeconds(durationTime);
                progressPlaying.progress = valueCompare;
                
            } else {
                if (isTranparancy) {
                    transparentSlider.hidden = YES;
                    [layerCompare setOpacity:1.0f];
                    
                    [viewTopTool setFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0f)];
                    [btnBackToList setFrame:CGRectMake(15.0f, 5.0f, 30.0f, 30.0f)];
                    [btnModeView setFrame:CGRectMake(viewTopTool.frame.size.width/2.0f - 15.0f, 5.0, 30.0f, 30.0f)];
                    [btnSaveCompare setFrame:CGRectMake(viewTopTool.frame.size.width - 45.0f, 5.0f, 30.0f, 30.0f)];
                    viewDrawTool.frame = CGRectMake(self.view.frame.size.width - 40.0f, 40.0f, 40.0f, self.view.frame.size.height - 40.0f);
                    viewToolSpeed.center = CGPointMake(25.0f, 40.0f + (self.view.frame.size.height - 40.0f)/2.0f);
                    
                    layerHost.frame = CGRectMake(0, 40.0f, (self.view.frame.size.width - 40.0f)/2.0f, self.view.frame.size.height - 40.0f);
                    layerCompare.frame = CGRectMake(layerHost.frame.origin.x + layerHost.frame.size.width, 40.0f, (self.view.frame.size.width - 40.0f)/2.0f, self.view.frame.size.height - 40.0f);
                    _DrawView.frame = CGRectMake(0, 40.0f, self.view.frame.size.width - 40.0f, self.view.frame.size.height - 40.0f);
                    transparentSlider.center = CGPointMake((self.view.frame.size.width - 40.0f)/2.0f, 90.0f);
                    btnControl.frame = CGRectMake(0, self.view.frame.size.height - 40.0f, 40.0f, 40.0f);
                    progressPlayingHost.frame = CGRectMake(53.0f, btnControl.frame.origin.y + btnControl.frame.size.height/2.0f - 2.0f, (self.view.frame.size.width - 108.0f)/2.0f, 2.0f);
                    progressPlaying.frame = CGRectMake(progressPlayingHost.frame.origin.x + progressPlayingHost.frame.size.width + 2.0f, progressPlayingHost.frame.origin.y, progressPlayingHost.frame.size.width, 2.0f);
                    viewGestureHost.frame = CGRectMake(progressPlayingHost.frame.origin.x - 13.0f, progressPlayingHost.frame.origin.y - 23.0f, progressPlayingHost.frame.size.width + 26.0f, 26.0f);
                    viewGestureCompare.frame = CGRectMake(progressPlaying.frame.origin.x - 13.0f, viewGestureHost.frame.origin.y, viewGestureHost.frame.size.width, 26.0f);
                    iviewLabelTimeHost.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                    iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                    lblcurrentTimeHost.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                    lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                } else {
                    transparentSlider.hidden = NO;
                    [layerCompare setOpacity:transparentSlider.value];
                    
                    [viewTopTool setFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0f)];
                    [btnBackToList setFrame:CGRectMake(15.0f, 5.0f, 30.0f, 30.0f)];
                    [btnModeView setFrame:CGRectMake(viewTopTool.frame.size.width/2.0f - 15.0f, 5.0, 30.0f, 30.0f)];
                    [btnSaveCompare setFrame:CGRectMake(viewTopTool.frame.size.width - 45.0f, 5.0f, 30.0f, 30.0f)];
                    viewDrawTool.frame = CGRectMake(self.view.frame.size.width - 40.0f, 40.0f, 40.0f, self.view.frame.size.height - 40.0f);
                    viewToolSpeed.center = CGPointMake(25.0f, 40.0f + (self.view.frame.size.height - 40.0f)/2.0f);
                    
                    layerHost.frame = CGRectMake(0, 40.0f, self.view.frame.size.width - 40.0f, self.view.frame.size.height - 40.0f);
                    layerCompare.frame = CGRectMake(0, 40.0f, self.view.frame.size.width - 40.0f, self.view.frame.size.height - 40.0f);
                    _DrawView.frame = CGRectMake(0, 40.0f, self.view.frame.size.width - 40.0f, self.view.frame.size.height - 40.0f);
                    transparentSlider.center = CGPointMake((self.view.frame.size.width - 40.0f)/2.0f, 90.0f);
                    btnControl.frame = CGRectMake(0, self.view.frame.size.height - 40.0f, 40.0f, 40.0f);
                    progressPlayingHost.frame = CGRectMake(53.0f, btnControl.frame.origin.y + btnControl.frame.size.height/2.0f - 2.0f, (self.view.frame.size.width - 108.0f)/2.0f, 2.0f);
                    progressPlaying.frame = CGRectMake(progressPlayingHost.frame.origin.x + progressPlayingHost.frame.size.width + 2.0f, progressPlayingHost.frame.origin.y, progressPlayingHost.frame.size.width, 2.0f);
                    viewGestureHost.frame = CGRectMake(progressPlayingHost.frame.origin.x - 13.0f, progressPlayingHost.frame.origin.y - 23.0f, progressPlayingHost.frame.size.width + 26.0f, 26.0f);
                    viewGestureCompare.frame = CGRectMake(progressPlaying.frame.origin.x - 13.0f, viewGestureHost.frame.origin.y, viewGestureHost.frame.size.width, 26.0f);
                    iviewLabelTimeHost.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                    iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
                    lblcurrentTimeHost.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                    lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
                }
                
                
                lenghtTHost = progressPlayingHost.frame.size.width;
                durationTimeHost = self._PlayerHost.currentItem.asset.duration;
                durationTHost = (float)CMTimeGetSeconds(durationTimeHost);
                float value = CMTimeGetSeconds(self._PlayerHost.currentItem.currentTime)/CMTimeGetSeconds(durationTimeHost);
                progressPlayingHost.progress = value;
                
                
                lenghtT = progressPlaying.frame.size.width;
                durationTime = self._PlayerCompare.currentItem.asset.duration;
                durationT = (float)CMTimeGetSeconds(durationTime);
                float valueCompare = CMTimeGetSeconds(self._PlayerCompare.currentItem.currentTime)/CMTimeGetSeconds(durationTime);
                progressPlaying.progress = valueCompare;
            }
        }
    }
    
    
    NSLog(@"Width-ToolTop: %f", viewTopTool.frame.size.width);
}

- (void)orientationChanged:(NSNotification *)notification
{
    UIDevice * device = notification.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
            if (1 == 1) {
                isOrient = YES;
                [self layoutOfScreenForOrientStatus:YES];
            }
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            if (1 == 1) {
                //[self layoutOfScreenForOrientStatus:NO];
            }
            break;
        case UIDeviceOrientationLandscapeLeft:
            if (1 == 1) {
                isOrient = NO;
                [self layoutOfScreenForOrientStatus:NO];
            }
            break;
        case UIDeviceOrientationLandscapeRight:
            if (1 == 1) {
                isOrient = NO;
                [self layoutOfScreenForOrientStatus:NO];
            }
            break;
        default:
            break;
    };
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
