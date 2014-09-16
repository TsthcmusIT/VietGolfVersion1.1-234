//
//  CompletedCreateVideoViewController.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "CompletedCreateVideoViewController.h"
#import "CoreGUIController.h"

@interface CompletedCreateVideoViewController ()

@end

@implementation CompletedCreateVideoViewController

@synthesize _VideoInfoC;


- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Bổ sung";
    _ScreenName = CompleteCreateScreen;
    self.navigationItem.hidesBackButton = YES;
    
    UIButton *btnComplete = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnComplete setFrame:CGRectMake(0, 0, 80.0f, 40.0f)];
    [btnComplete setTitle:@"Kết thúc" forState:UIControlStateNormal];
    [btnComplete addTarget:self action:@selector(completedCreateVideo) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnComplete];
    
    arrayOfVideo = [[NSMutableArray alloc] init];
    arrayOfVideo = [_CoreGUI loadVideoWithType:1];
    NSString *stringThumnail = [NSString stringWithString:[self getThumnailAndWriteToNSDocumentDictionary]];
    
    golferArray = [[NSMutableArray alloc]initWithObjects:@"Driver", @"Woods", @"Hybrid", @"Pitching Wedge", @"Sand Wedge", @"Putter", @"9 Iron", @"8 Iron", @"7 Iron", @"6 Iron", @"5 Iron", @"4 Iron", @"3 Iron", nil];
    
    // -- View username
    viewUserName = [[UIView alloc] init];
    viewUserName.frame = CGRectMake(20.0f, self.navigationController.navigationBar.frame.size.height + 20.0f + 20.0f, self.view.frame.size.width - 40.0f, self.view.frame.size.height/10.0f);
    viewUserName.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:0.9f];
    viewUserName.clipsToBounds = YES;
    viewUserName.layer.cornerRadius = 6.0f;
    
    btnUserName = [UIButton buttonWithType:UIButtonTypeCustom];
    btnUserName.frame = CGRectMake(10.0f, 0, viewUserName.frame.size.height, viewUserName.frame.size.height);
    [btnUserName setImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
    [btnUserName addTarget:self action:@selector(showSuggest:) forControlEvents:UIControlEventTouchUpInside];
    btnUserName.tag = 500;
    
    txtFUserName = [[UITextField alloc]init];
    txtFUserName.delegate = self;
    txtFUserName.frame = CGRectMake(btnUserName.frame.origin.x + btnUserName.frame.size.width, 0, viewUserName.frame.size.width - btnUserName.frame.origin.x - btnUserName.frame.size.width, btnUserName.frame.size.height);
    txtFUserName.backgroundColor = [UIColor clearColor];
    txtFUserName.textAlignment = NSTextAlignmentCenter;
    txtFUserName.textColor = [UIColor whiteColor];
    [txtFUserName setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:25.0f]];
    [txtFUserName setText:@"Tôi"];
    
    // -- View golf tree
    viewGolfTree = [[UIView alloc] init];
    viewGolfTree.frame = CGRectMake(20.0f, viewUserName.frame.origin.y + viewUserName.frame.size.height + 10.0f, self.view.frame.size.width - 40.0f, self.view.frame.size.height/10.0f);
    viewGolfTree.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:0.9f];
    viewGolfTree.clipsToBounds = YES;
    viewGolfTree.layer.cornerRadius = 6.0f;
    
    btnGolfTree = [UIButton buttonWithType:UIButtonTypeCustom];
    btnGolfTree.frame = CGRectMake(10.0f, 0, viewGolfTree.frame.size.height, viewGolfTree.frame.size.height);
    [btnGolfTree setImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
    [btnGolfTree addTarget:self action:@selector(showSuggest:) forControlEvents:UIControlEventTouchUpInside];
    btnGolfTree.tag = 501;
    
    btnValueGolfTree = [UIButton buttonWithType:UIButtonTypeCustom];
    btnValueGolfTree.frame = CGRectMake(btnGolfTree.frame.origin.x + btnGolfTree.frame.size.width, 0, viewGolfTree.frame.size.width - btnGolfTree.frame.origin.x - btnGolfTree.frame.size.width, btnGolfTree.frame.size.height);
    btnValueGolfTree.backgroundColor = [UIColor clearColor];
    [btnValueGolfTree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnValueGolfTree setTitle: @"Driver" forState:UIControlStateNormal];
    [btnValueGolfTree.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:25.0f]];
    [btnValueGolfTree addTarget:self action:@selector(updateGolfTree) forControlEvents:UIControlEventTouchUpInside];
    
    picVGolfTree = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2.0f, 100.0f)];
    picVGolfTree.delegate = self;
    picVGolfTree.dataSource = self;
    picVGolfTree.showsSelectionIndicator = YES;
    
    // -- View post
    viewPost = [[UIView alloc] init];
    viewPost.frame = CGRectMake(20.0f, viewGolfTree.frame.origin.y + viewGolfTree.frame.size.height + 10.0f, self.view.frame.size.width - 40.0f, self.view.frame.size.height/10.0f);
    viewPost.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:0.9f];
    viewPost.clipsToBounds = YES;
    viewPost.layer.cornerRadius = 6.0f;
    
    btnPost = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPost.frame = CGRectMake(10.0f, 0, viewPost.frame.size.height, viewPost.frame.size.height);
    [btnPost setImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
    [btnPost addTarget:self action:@selector(showSuggest:) forControlEvents:UIControlEventTouchUpInside];
    btnPost.tag = 502;
    
    switchPost = [[UISwitch alloc]init];
    switchPost.frame = CGRectMake(0, 0, 100.0f, viewPost.frame.size.height);
    switchPost.center = CGPointMake(btnValueGolfTree.frame.origin.x + btnValueGolfTree.frame.size.width/2.0f, viewPost.frame.size.height/2.0f);
    [switchPost setOn:NO];
    [switchPost addTarget:self action:@selector(changeSwitchPost:) forControlEvents:UIControlEventValueChanged];
    
    btnPlay = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPlay.frame = CGRectMake(20.0f, viewPost.frame.origin.y + viewPost.frame.size.height + 10.0f, self.view.frame.size.width - 40.0f, self.view.frame.size.height - 20.0f - (viewPost.frame.origin.y + viewPost.frame.size.height + 10.0f));
    btnPlay.backgroundColor = [UIColor whiteColor];
    [btnPlay setImage:[UIImage imageWithContentsOfFile:stringThumnail] forState:UIControlStateNormal];
    btnPlay.clipsToBounds = YES;
    btnPlay.layer.cornerRadius = 6.0f;
    
    lblSuggest = [[UILabel alloc] init];
    lblSuggest.frame = CGRectMake(self.view.frame.size.width, 0, btnPlay.frame.size.width, btnPlay.frame.size.height);
    lblSuggest.numberOfLines = 5;
    lblSuggest.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:0.9f];
    [lblSuggest setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]];
    [lblSuggest setTextColor:[UIColor whiteColor]];
    [lblSuggest setTextAlignment:NSTextAlignmentCenter];
    lblSuggest.clipsToBounds = YES;
    lblSuggest.layer.cornerRadius = 5.0f;
    
    [self.view addSubview:viewUserName];
    [viewUserName addSubview:btnUserName];
    [viewUserName addSubview:txtFUserName];
    [self.view addSubview:viewGolfTree];
    [viewGolfTree addSubview:btnGolfTree];
    [viewGolfTree addSubview:btnValueGolfTree];
    [self.view addSubview:viewPost];
    [viewPost addSubview:btnPost];
    [viewPost addSubview:switchPost];
    [self.view addSubview:btnPlay];
    [btnPlay addSubview:lblSuggest];
    
}

-(void)showSuggest:(UIButton*)sender
{
    if (sender.tag == 500) {
        if (isShowSuggest) {
            [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                lblSuggest.frame = CGRectMake(self.view.frame.size.width, 0, btnPlay.frame.size.width, btnPlay.frame.size.height);
            } completion:nil];
            isShowSuggest = NO;
        } else {
            isShowSuggest = YES;
            lblSuggest.alpha = 0.5f;
            lblSuggest.frame = CGRectMake(0, 0, btnPlay.frame.size.width, btnPlay.frame.size.height);
            [UIView animateWithDuration:2.0f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                lblSuggest.text = @"Tên (biệt danh) người đánh";
                lblSuggest.alpha = 1.0f;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:1.0f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    lblSuggest.alpha = 0;
                    isShowSuggest = NO;
                } completion:nil];
            }];
        }
    } else {
        if (sender.tag == 501) {
            if (isShowSuggest) {
                [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    lblSuggest.frame = CGRectMake(self.view.frame.size.width, 0, btnPlay.frame.size.width, btnPlay.frame.size.height);
                } completion:nil];
                isShowSuggest = NO;
            } else {
                isShowSuggest = YES;
                lblSuggest.alpha = 0.5f;
                lblSuggest.frame = CGRectMake(0, 0, btnPlay.frame.size.width, btnPlay.frame.size.height);
                [UIView animateWithDuration:2.0f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    lblSuggest.text = @"Thông tin loại gậy sử dụng";
                    lblSuggest.alpha = 1.0f;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:1.0f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                        lblSuggest.alpha = 0;
                        isShowSuggest = NO;
                    } completion:nil];
                }];
            }
        } else {
            if (sender.tag == 502) {
                if (isShowSuggest) {
                    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                        lblSuggest.frame = CGRectMake(self.view.frame.size.width, 0, btnPlay.frame.size.width, btnPlay.frame.size.height);
                    } completion:nil];
                    isShowSuggest = NO;
                } else {
                    isShowSuggest = YES;
                    lblSuggest.alpha = 0.5f;
                    lblSuggest.frame = CGRectMake(0, 0, btnPlay.frame.size.width, btnPlay.frame.size.height);
                    [UIView animateWithDuration:2.0f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                        lblSuggest.text = @"Bạn muốn tải lên swing video này lên hệ thống? Video của bạn sẽ được kiểm duyệt trước khi hiển thị lên Viet Golf website";
                        lblSuggest.alpha = 1.0f;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:1.0f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                            lblSuggest.alpha = 0;
                            isShowSuggest = NO;
                        } completion:nil];
                    }];
                }
            }

        }
    }
}

- (void)changeSwitchPost:(id)sender{
    if([sender isOn]){
        // Execute any code when the switch is ON
    } else{
        // Execute any code when the switch is OFF
    }
}


-(void)updateGolfTree
{
    viewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.88f*self.view.frame.size.height)];
    viewBackground.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
    
    viewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0f)];
    viewTitle.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:0.95f];
    btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(0, 0, 80.0f, 40.0f);
    [btnDone.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f]];
    btnDone.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    [btnDone setTitle:@"Chọn" forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(selectGolfTree) forControlEvents:UIControlEventTouchUpInside];
    
    
    [viewTitle addSubview:btnDone];
    [viewBackground addSubview:viewTitle];
    [viewBackground addSubview:picVGolfTree];
    [self.view addSubview:viewBackground];
    
    viewBackground.alpha = 0;
    viewBackground.center = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height);
    [UIView beginAnimations:NULL context:nil];
    [UIView setAnimationDuration:1.0f];
    
    viewBackground.alpha = 0.98f;
    viewBackground.center = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height - 100.0f);
    [UIView commitAnimations];
}

-(void)selectGolfTree
{
    [btnDone removeFromSuperview];
    [picVGolfTree removeFromSuperview];
    [viewBackground removeFromSuperview];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [golferArray count];
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row  forComponent:(NSInteger)component
{
    
    return [golferArray objectAtIndex:row];
    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0f;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row  inComponent:(NSInteger)component
{
    switch(row)
    {
        case 0:
            _VideoInfoC._GolfTree = @"Driver";
            [btnGolfTree setTitle:@"Driver" forState:UIControlStateNormal];
            break;
        case 1:
            _VideoInfoC._GolfTree = @"Woods";
            [btnGolfTree setTitle:@"Woods" forState:UIControlStateNormal];
            break;
        case 2:
            _VideoInfoC._GolfTree = @"Hybrid";
            [btnGolfTree setTitle:@"Hybrid" forState:UIControlStateNormal];
            
            break;
        case 3:
            _VideoInfoC._GolfTree = @"Pitching Wedge";
            [btnGolfTree setTitle:@"Pitching Wedge" forState:UIControlStateNormal];
            break;
        case 4:
            _VideoInfoC._GolfTree = @"Sand Wedge";
            [btnGolfTree setTitle:@"Sand Wedge" forState:UIControlStateNormal];
            break;
        case 5:
            _VideoInfoC._GolfTree = @"Putter";
            [btnGolfTree setTitle:@"Putter" forState:UIControlStateNormal];
            break;
        case 6:
            _VideoInfoC._GolfTree = @"9 Iron";
            [btnGolfTree setTitle:@"9 Iron" forState:UIControlStateNormal];
            break;
        case 7:
            _VideoInfoC._GolfTree = @"8 Iron";
            [btnGolfTree setTitle:@"8 Iron" forState:UIControlStateNormal];
            break;
        case 8:
            _VideoInfoC._GolfTree = @"7 Iron";
            [btnGolfTree setTitle:@"7 Iron" forState:UIControlStateNormal];
            break;
        case 9:
            _VideoInfoC._GolfTree = @"6 Iron";
            [btnGolfTree setTitle:@"6 Iron" forState:UIControlStateNormal];
            break;
        case 10:
            _VideoInfoC._GolfTree = @"5 Iron";
            [btnGolfTree setTitle:@"5 Iron" forState:UIControlStateNormal];
            break;
        case 11:
            _VideoInfoC._GolfTree = @"4 Iron";
            [btnGolfTree setTitle:@"4 Iron" forState:UIControlStateNormal];
            break;
        case 12:
            _VideoInfoC._GolfTree = @"3 Iron";
            [btnGolfTree setTitle:@"3 Iron" forState:UIControlStateNormal];
            break;
        default:
            _VideoInfoC._GolfTree = @"Driver";
            [btnGolfTree setTitle:@"Driver" forState:UIControlStateNormal];
            break;
            
    }
    [btnGolfTree.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:25.0f]];
    [btnGolfTree setTitleColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (pickerLabel == nil) {
        //label size
        CGRect frame = CGRectMake(0.0, 0.0, self.view.frame.size.width/2.0f, 25.0f);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentLeft];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        
        [pickerLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]];
    }
    //picker view array is the datasource
    [pickerLabel setText:[golferArray objectAtIndex:row]];
    return pickerLabel;
}


-(void)completedCreateVideo
{
    _VideoInfoC._Owner = txtFUserName.text;
    _VideoInfoC._GolfTree = btnValueGolfTree.titleLabel.text;
    _VideoInfoC._VideoType = @"User";
    _VideoInfoC._Time = [[NSDate alloc] init];
    _VideoInfoC._Prepare = NO;
    _VideoInfoC._IsPosted = NO;
    _VideoInfoC._IsFavorited = NO;
    _VideoInfoC._Voice = NO;
    _VideoInfoC._Thumnail = [self getThumnailAndWriteToNSDocumentDictionary];
    
    if ([switchPost isOn])
    {
        [_CoreGUI uploadVideoToServerWithStringPath:_VideoInfoC._PathVideo andGolfClub:_VideoInfoC._GolfTree];
        _VideoInfoC._Prepare = YES;
    }
    else
    {
        _VideoInfoC._Prepare = NO;
    }
    [_CoreGUI commitSwingVideo:_VideoInfoC withType:1];
    self.navigationItem.hidesBackButton = NO;
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [_CoreGUI._TabBar.tabBar setHidden:NO];
    ((SwingVideoTableViewController*)[_CoreGUI._Navi.viewControllers objectAtIndex:0])._IsMaster = NO;
    ((SwingVideoTableViewController*)[_CoreGUI._Navi.viewControllers objectAtIndex:0])._FlagUpdate = YES;
    
    [_CoreGUI._TabBar setSelectedIndex:0];
    [_CoreGUI._Navi03 popToRootViewControllerAnimated:YES];
}

-(NSString*)getThumnailAndWriteToNSDocumentDictionary
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:_CoreGUI._SVideoInfoGUI._PathVideo] options:nil];
    AVAssetImageGenerator *generateImg = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generateImg.appliesPreferredTrackTransform = YES;
    NSError *error = NULL;
    CMTime time = CMTimeMake(1, 65);
    CGImageRef refImg = [generateImg copyCGImageAtTime:time actualTime:NULL error:&error];
    UIImage *FrameImage= [[UIImage alloc] initWithCGImage:refImg];
    
    // Create a thumbnail version of the image for the event object.
    CGSize size = FrameImage.size;
    
    CGRect clippedRect = CGRectMake(0, 0, 2.0f*size.width, 2.0f*size.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([FrameImage CGImage], clippedRect);
    
    // Resize the image
    CGRect rect = CGRectMake(1.0, 1.0, 508.0f, 313.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    [[UIImage imageWithCGImage:imageRef] drawInRect:rect];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // Done Resizing
    // Write
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/CreateThumnail%f.png",[[NSDate date] timeIntervalSince1970]]];
    NSData *imageData = UIImagePNGRepresentation(thumbnail);
    [imageData writeToFile:savedImagePath atomically:NO];
    
    return savedImagePath;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [_CoreGUI._TabBar.tabBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_CoreGUI._TabBar.tabBar setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
