//
//  SwingVideoTableViewController.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "SwingVideoTableViewController.h"
#import "CoreGUIController.h"

@interface SwingVideoTableViewController ()

@end

@implementation SwingVideoTableViewController

@synthesize _CoreGUI, _CurrentRow, _FlagUpdate, _IsMaster;
@synthesize _FlagEdit, _Video;


-(id)initWithCoreGUI:(CoreGUIController *)coreGUI style:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _CoreGUI = coreGUI;
    }
    return self;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewController
////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Swing";
    self.navigationController.title = @"Swing";
    self.view.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    listVideo = [[NSMutableArray alloc]init];
	listUser = [[NSMutableArray alloc] init];
    listView = [[NSMutableArray alloc] init];
    _Video = [[SVideoInfo alloc] init];
    _CurrentRow = 0;
    _IsMaster = NO;
    _FlagUpdate = YES;
    checkUpdateMaster = YES;
    countIndex0 = 0;
    checkSuccessUpdate = 0;
    
    viewTags = [[UIView alloc] init];
    viewTags.backgroundColor = [UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:1.0f];
    viewTags.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/16.0f);
    
    CGSize btnSize;
    
    btnSize = CGSizeMake(self.view.frame.size.width/2.0f, viewTags.frame.size.height);
    
    btnTagUser = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTagUser.frame = CGRectMake(0, 0, btnSize.width, btnSize.height);
    btnTagUser.center = CGPointMake(viewTags.frame.size.width/4.0f, viewTags.frame.size.height/2.0f);
    [btnTagUser setTitle:@"Của Tôi" forState:UIControlStateNormal];
    [btnTagUser.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:0.5f*btnSize.height]];
    [btnTagUser addTarget:self action:@selector(loadSwingVideoOfUser) forControlEvents:UIControlEventTouchUpInside];
    
    
    btnTagSystem = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTagSystem.frame = CGRectMake(0, 0, btnSize.width, btnSize.height);
    btnTagSystem.center = CGPointMake(3.0f*viewTags.frame.size.width/4.0f, viewTags.frame.size.height/2.0f);
    [btnTagSystem setTitle:@"Master" forState:UIControlStateNormal];
    [btnTagSystem.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:0.5f*btnSize.height]];
    
    [btnTagSystem addTarget:self action:@selector(loadSwingVideoOfSystem) forControlEvents:UIControlEventTouchUpInside];
    
    [viewTags addSubview:btnTagUser];
    [viewTags addSubview:btnTagSystem];
    
}


-(void)loadSwingVideoOfUser
{
    for (int i = 0; i < [listView count]; i++) {
        [[listView objectAtIndex:i] removeFromSuperview];
    }
    [listView removeAllObjects];
    listCell = [[NSMutableArray alloc] init];
    countIndex0 = 0;
    
    _IsMaster = NO;
    listUser = [_CoreGUI loadVideoWithType:1];
    numRows = [listUser count];
    
    if (numRows <= 0) {
        UIImageView *tempImageView = [[UIImageView alloc] init];
        if ([[UIScreen mainScreen] bounds].size.height >= 568.0f) {
            tempImageView.image = [UIImage imageNamed:@"SwingVideoOfUserBackg.png"];
        } else {
            tempImageView.image = [UIImage imageNamed:@"SwingVideoOfUser4InchesBackg.png"];
        }

        [tempImageView setFrame:self.tableView.frame];
        self.tableView.backgroundView = tempImageView;
    } else {
        self.tableView.backgroundView = nil;
    }
    
    [btnTagUser setTitleColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [btnTagSystem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnTagUser.backgroundColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
    btnTagSystem.backgroundColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
    
    [self.tableView reloadData];
}

-(void)loadSwingVideoOfSystem
{
    if (checkUpdateMaster) {
        checkUpdateMaster = NO;
        if (!_CoreGUI._UserProfile._AllowUpdate) {
            UIView *viewBackg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            viewBackg.backgroundColor = [UIColor colorWithWhite:0.6f alpha:1.0f];
            
            UIView *viewTit = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewBackg.frame.size.width - 20.0f, viewBackg.frame.size.width - 20.0f)];
            viewTit.backgroundColor = [UIColor colorWithWhite:0.2f alpha:0.9f];
            viewTit.layer.cornerRadius = 10.0f;
            viewTit.center = CGPointMake(viewBackg.frame.size.width/2.0f, (viewBackg.frame.size.height)/2.0f - 64.0f);
            UILabel *lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewTit.frame.size.width - 40.0f, self.view.frame.size.height/3.0f)];
            lblMessage.center = CGPointMake(viewTit.frame.size.width/2.0f, viewTit.frame.size.height/2.0f);
            lblMessage.backgroundColor = [UIColor clearColor];
            lblMessage.textAlignment = NSTextAlignmentCenter;
            [lblMessage setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0f]];
            lblMessage.numberOfLines = 4;
            [lblMessage setTextColor:[UIColor whiteColor]];
            
            lblMessage.text = @"Bạn cần chuyển đến màn hình Thông tin chi tiết tài khoản để bật chế độ đồng bộ dữ liệu nhằm cập nhật video mới!";
            
            [viewTit addSubview:lblMessage];
            [viewBackg addSubview:viewTit];
            [self.view addSubview:viewBackg];
            
            [UIView animateWithDuration:3.0f delay:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^{
                [viewBackg setAlpha:1.0f];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:3.0f delay:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [viewBackg setAlpha:0.0f];
                } completion:nil];
            }];
        }
    }
    for (int i = 0; i < [listView count]; i++) {
        [[listView objectAtIndex:i] removeFromSuperview];
    }
    [listView removeAllObjects];
    listCell = [[NSMutableArray alloc] init];
    countIndex0 = 0;
    
    self.tableView.backgroundView = nil;
    _IsMaster = YES;
    listVideo = [_CoreGUI loadVideoWithType:0];
    numRows = [listVideo count];
    [btnTagSystem setTitleColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [btnTagUser setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnTagUser.backgroundColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
    btnTagSystem.backgroundColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
    
    [self.tableView reloadData];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource
////////////////////////////////////////////////////////////////////////

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"MSCMoreOptionTableViewCell";
    if (_IsMaster) {
        _Video = [listVideo objectAtIndex:indexPath.row];
    } else {
        _Video = [listUser objectAtIndex:indexPath.row];
    }
    
    MSCMoreOptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MSCMoreOptionTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell._Delegate = self;
    }
    
    if (indexPath.row != 0)
    {
        if (indexPath.row >= [listCell count]) {
            [listCell insertObject:cell atIndex:0];
        }
    } else {
        if (countIndex0 == 0) {
            countIndex0++;
            [listCell insertObject:cell atIndex:0];
        }
    }
    
    if(_Video._IsFavorited)
    {
        [cell._BtnFavorited setBackgroundImage:[UIImage imageNamed:@"FavoritedSVideo.png"] forState:UIControlStateNormal];
    } else {
        [cell._BtnFavorited setBackgroundImage:nil forState:UIControlStateNormal];
    }
    cell.textLabel.text = _Video._GolfTree;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
    
    cell.detailTextLabel.text = _Video._Owner;
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0f];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80.0f, 50.0f)];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM,dd-yyyy"];
    // Optionally for time zone converstions
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    
    lbl.text = [formatter stringFromDate:_Video._Time];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [UIColor blackColor];
    [lbl setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0f]];
    cell.accessoryView = lbl;
    
    UIButton *btnView = [UIButton buttonWithType:UIButtonTypeCustom];
    btnView.frame = CGRectMake(10.0f, 10.0f , 60.0f, 60.0f);
    btnView.layer.cornerRadius = 5.0f;
    btnView.clipsToBounds = YES;
    btnView.contentMode = UIViewContentModeScaleToFill;
    if (![_Video._PathCompare isEqualToString:@"nothing"]) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Đã chỉnh sửa: %@", _Video._GolfTree];
        [btnView setImage:[UIImage imageNamed:@"MergeThumnail.png"] forState:UIControlStateNormal];
    } else{
        if (_Video._Voice) {
            [btnView setImage:[UIImage imageNamed:@"VoiceThumnail.png"] forState:UIControlStateNormal];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"Đã chỉnh sửa: %@", _Video._GolfTree];
        }
    }
    [btnView setBackgroundImage:[UIImage imageWithContentsOfFile:_Video._Thumnail] forState:UIControlStateNormal];
    
    [cell.contentView addSubview:btnView];
    cell.imageView.image = [UIImage imageNamed:@"Thumnail.png"];
    // Set contentMode to scale aspect to fit
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
    
    if (btnView.currentBackgroundImage == nil) {
        if (_Video._PathVideo != nil && ![_Video._PathVideo isEqualToString:@""]) {
            [btnView setBackgroundImage:[self getThumnailFromVideoFromPath:_Video._PathVideo] forState:UIControlStateNormal];
        } else {
            [btnView setBackgroundImage:[UIImage imageNamed:@"NoSwingVideo.png"] forState:UIControlStateNormal];
        }
    }
    
    [listView addObject:btnView];
    
    if (![_Video._VideoType isEqualToString:@"User"]) {
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        btnView.layer.mask = maskLayer;
        _MaskLayer = maskLayer;
        
        // Create shape layer for circle we'll draw on top of image (the boundary of the circle)
        
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        circleLayer.lineWidth = 2.0f;
        circleLayer.fillColor = [[UIColor clearColor] CGColor];
        circleLayer.strokeColor = [[UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:0.4f] CGColor];
        [btnView.layer addSublayer:circleLayer];
        _CircleLayer = circleLayer;
        
        [self updateCirclePathAtLocation:CGPointMake(30.0f, 30.0f) radius:60.0f * 0.480f];
    }
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return viewTags;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
    // Called when "DELETE" button is pushed.
    
    // Remove the row from data model
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    // Get documents path
    NSString *documentsPath = [paths objectAtIndex:0];
    // Get the path to our data/plist file
    
    NSString *stringDBName;
    if (!_IsMaster) {
        stringDBName = @"SVideosUser";
    }
    else
    {
        stringDBName = @"SVideosMaster";
    }
    
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", stringDBName]];
    NSMutableArray *mountainsArray = [[[NSMutableArray alloc] initWithContentsOfFile:plistPath]mutableCopy];
    
    [mountainsArray removeObjectAtIndex:indexPath.row];
    [mountainsArray writeToFile:plistPath atomically:YES];
    
    if (_IsMaster)
    {
        [listVideo removeObjectAtIndex:indexPath.row];
        listVideo = [_CoreGUI loadVideoWithType:0];
        numRows = [listVideo count];

    } else {
        [listUser removeObjectAtIndex:indexPath.row];
        listUser = [_CoreGUI loadVideoWithType:1];
        numRows = [listUser count];
    }
    
    [listCell removeObjectAtIndex:indexPath.row];
    
    // Request table view to reload    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return numRows;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate
////////////////////////////////////////////////////////////////////////

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.view.frame.size.height/16.0f;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Xoá";
}

////////////////////////////////////////////////////////////////////////
#pragma mark - MSCMoreOptionTableViewCellDelegate
////////////////////////////////////////////////////////////////////////

- (void)tableView:(UITableView *)tableView moreOptionButtonPressedInRowAtIndexPath:(NSIndexPath *)indexPath {
    // Called when "MORE" button is pushed.
    _CurrentRow = indexPath.row;
    SVideoInfo *tempVideo = [[SVideoInfo alloc] init];
    if (_IsMaster) {
        tempVideo = [listVideo objectAtIndex:_CurrentRow];
    } else {
        tempVideo = [listUser objectAtIndex:_CurrentRow];
    }
    
    
    NSString *stringFavorited = [[NSString alloc] init];
    isFavorited = tempVideo._IsFavorited;
    if (isFavorited)
    {
        stringFavorited = @"Bỏ thích";
    }
    else
    {
        stringFavorited = @"Yêu thích";
    }
    
    UIActionSheet *actionSheet;
    if ([tempVideo._VideoType isEqualToString:@"Master"]) {
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Huỷ" destructiveButtonTitle:nil otherButtonTitles:@"Đi đến website", stringFavorited, @"Tin tức hướng dẫn", @"Cập nhật thông tin video", @"So sánh video", @"Chia đoạn video", nil];
    } else {
        if (tempVideo._Prepare) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Huỷ" destructiveButtonTitle:nil otherButtonTitles:@"Đi đến website", stringFavorited,  @"Tin tức hướng dẫn", @"Cập nhật thông tin video", @"So sánh video", @"Chia đoạn video", @"Tải lên", nil];
        } else {
            actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Huỷ" destructiveButtonTitle:nil otherButtonTitles:@"Đi đến website", stringFavorited,  @"Tin tức hướng dẫn", @"Cập nhật thông tin video", @"So sánh video", @"Chia đoạn video", @"Tải lên", nil];
        }
    }
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}

- (NSString *)tableView:(UITableView *)tableView titleForMoreOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Khác";
}

// -- Load du lieu

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _CurrentRow = indexPath.row;
    if (_IsMaster) {
        _Video = [listVideo objectAtIndex:_CurrentRow];
    } else {
        _Video = [listUser objectAtIndex:_CurrentRow];
    }
    
    if (_Video._Voice)
    {
        [_CoreGUI goToReviewSVideo:self withData:_Video];
    } else {
        if ([_Video._PathCompare isEqualToString:@"nothing"]) {
            if (_Video._PathVideo != nil && ![_Video._PathVideo isEqualToString:@""])
            {
                [_CoreGUI passingFromSwingToDisplay:self withData:_Video withCurrentRow:_CurrentRow withType:_IsMaster];
            } else {
                [_CoreGUI goToReviewSVideo:self withData:_Video];
            }
        } else {
            [_CoreGUI goToCompareScreen:self withData:_Video withCode:1];
        }
    }
}


// ----------------------------------------------------------------


-(UIImage*)getThumnailFromVideoFromPath:(NSString*)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:path] options:nil];
    AVAssetImageGenerator *generateImg = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generateImg.appliesPreferredTrackTransform = YES;
    NSError *error = NULL;
    CMTime time = CMTimeMake(1, 65);
    CGImageRef refImg = [generateImg copyCGImageAtTime:time actualTime:NULL error:&error];
    UIImage *FrameImage= [[UIImage alloc] initWithCGImage:refImg];
    
    // Create a thumbnail version of the image for the event object.
    CGSize size = FrameImage.size;
    CGSize croppedSize;
    
    CGFloat offsetX = 0.0f;
    CGFloat offsetY = 0.0f;
    
    // check the size of the image, we want to make it
    // a square with sides the size of the smallest dimension.
    // So clip the extra portion from x or y coordinate
    if (size.width > size.height) {
        offsetX = (size.height - size.width)/2.0f;
        croppedSize = CGSizeMake(size.height, size.height);
    } else {
        offsetY = (size.width - size.height)/2.0f;
        croppedSize = CGSizeMake(size.width, size.width);
    }
    
    // Crop the image before resize
    CGRect clippedRect = CGRectMake(offsetX * -1, offsetY * -1, croppedSize.width, croppedSize.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([FrameImage CGImage], clippedRect);
    // Done cropping
    
    // Resize the image
    CGRect rect = CGRectMake(1.0f, 1.0f, 508.0f, 313.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    [[UIImage imageWithCGImage:imageRef] drawInRect:rect];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // Done Resizing
    
    return thumbnail;
}

-(void)stopHiddenTableView
{
    self.tableView.hidden = NO;
    if (_FlagUpdate) {
        [self performSelector:@selector(stopAnimating) withObject:nil afterDelay:1.0f];
        _FlagUpdate = NO;
    }
}

-(void)stopAnimating
{
    [spinner stopAnimating];
    [spinner removeFromSuperview];
    [viewProcess removeFromSuperview];
}

- (void)updateCirclePathAtLocation:(CGPoint)location radius:(CGFloat)radius
{
    _CircleCenter = location;
    _CircleRadius = radius;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:_CircleCenter
                    radius:_CircleRadius
                startAngle:0.0f
                  endAngle:M_PI*2.0f
                 clockwise:YES];
    
    _MaskLayer.path = [path CGPath];
    _CircleLayer.path = [path CGPath];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_IsMaster) {
        _Video = [listVideo objectAtIndex:_CurrentRow];
    } else {
        _Video = [listUser objectAtIndex:_CurrentRow];
    }

    switch (buttonIndex)
    {
        case 0:
            if (1 == 1) {
                [_CoreGUI._TabBar.tabBar setHidden:YES];
                GoToWebViewController *goToWebVC = [[GoToWebViewController alloc] initWithCoreGUI:_CoreGUI];
                goToWebVC._FlagNews = NO;
                goToWebVC._FlagDetailVideo = NO;
                goToWebVC._FlagVideos = YES;
                goToWebVC._StringLink = @"http://www.vietgolfvn.com/articles.html";
                [_CoreGUI._Navi pushViewController:goToWebVC animated:YES];
            }
            break;
        case 1:
            /*if (1 == 1) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_CurrentRow inSection:0];
                NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
                [self.tableView beginUpdates];
                [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
                [self.tableView endUpdates];
            }*/
            
            isFavorited = !isFavorited;
            _Video._IsFavorited = isFavorited;
            [self updateInfoToDatabase];
            if (isFavorited) {
                [_CoreGUI updateUserProfileWithCode:2];
            }
            else
            {
                [_CoreGUI updateUserProfileWithCode:1];
            }
            break;
        case 2:
            if (1 == 1) {
                [_CoreGUI._TabBar.tabBar setHidden:YES];
                GoToWebViewController *goToWebVC = [[GoToWebViewController alloc] initWithCoreGUI:_CoreGUI];
                goToWebVC._FlagNews = NO;
                goToWebVC._FlagDetailVideo = NO;
                goToWebVC._FlagVideos = YES;
                goToWebVC._StringLink = @"http://www.vietgolfvn.com/articles.html";
                [_CoreGUI._Navi pushViewController:goToWebVC animated:YES];
            }
            break;
        case 3:
            [self showViewUpdateInfoSVideo];
            break;
        case 4:
            [_CoreGUI goToCompareScreen:self withData:_Video withCode:0];
            break;
        case 5:
            [_CoreGUI goToTrimScreen:self withData:_Video];
            break;
        case 6:
            if (!_IsMaster) {
                if (!_IsMaster && !_Video._Prepare) {
                    checkSuccessUpdate = [_CoreGUI uploadVideoToServerWithStringPath:_Video._PathVideo andGolfClub:_Video._GolfTree];
                    [self showViewUpload];
                    _Video._Prepare = YES;
                    [self updateInfoToDatabase];
                } else {
                    [self showViewUpload];
                }
            }
            break;
    }
}


-(void)showViewUpload
{
    UIView *viewBackg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    viewBackg.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    
    UIView *viewTit = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewBackg.frame.size.width - 20.0f, viewBackg.frame.size.width - 20.0f)];
    viewTit.backgroundColor = [UIColor colorWithWhite:0.6f alpha:0.8f];
    viewTit.layer.cornerRadius = 10.0f;
    viewTit.center = CGPointMake(viewBackg.frame.size.width/2.0f, 20.0f + (viewBackg.frame.size.width)/2.0f);
    UILabel *lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewTit.frame.size.width - 40.0f, self.view.frame.size.height/3.0f)];
    lblMessage.center = CGPointMake(viewTit.frame.size.width/2.0f, viewTit.frame.size.height/2.0f);
    lblMessage.backgroundColor = [UIColor clearColor];
    lblMessage.textAlignment = NSTextAlignmentCenter;
    [lblMessage setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0f]];
    lblMessage.numberOfLines = 2;
    [lblMessage setTextColor:[UIColor whiteColor]];
    
    if (!_Video._Prepare) {
        if (checkSuccessUpdate == 1) {
            lblMessage.text = @"Tải lên thành công!";
        } else {
            lblMessage.text = @"Kết nối thất bại!";
        }
    } else {
        lblMessage.text = @"Rất tiếc! Video của bạn từng được tải lên trước đây!";
    }
    
    [viewTit addSubview:lblMessage];
    [viewBackg addSubview:viewTit];
    [self.view addSubview:viewBackg];
    
    [UIView animateWithDuration:2.0f delay:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [viewBackg setAlpha:1.0f];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2.0f delay:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [viewBackg setAlpha:0.0f];
        } completion:nil];
    }];
}

-(void)updateInfoToDatabase
{
    if (isFavorited) {
        [((MSCMoreOptionTableViewCell*)[listCell objectAtIndex:_CurrentRow])._BtnFavorited setBackgroundImage:[UIImage imageNamed:@"FavoritedSVideo.png"] forState:UIControlStateNormal];
    }
    else
    {
        [((MSCMoreOptionTableViewCell*)[listCell objectAtIndex:_CurrentRow])._BtnFavorited setBackgroundImage:nil forState:UIControlStateNormal];
    }
    
    //[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NSString *stringDBName;
    if (!_IsMaster) {
        stringDBName = @"SVideosUser";
    }
    else
    {
        stringDBName = @"SVideosMaster";
    }
    
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", stringDBName]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:stringDBName ofType: @"plist"];
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    NSMutableArray *mountainsArray = [[[NSMutableArray alloc] initWithContentsOfFile:path]mutableCopy];
    
    for (int i = 0; i < [mountainsArray count]; i++) {
        NSMutableDictionary *dict = [mountainsArray objectAtIndex:i];
        
        if (i == _CurrentRow) {
            [dict setObject:[NSNumber numberWithInt:_Video._Id] forKey:@"id"];
            [dict setObject:_Video._GolfTree forKey:@"golftree"];
            [dict setObject:_Video._Owner forKey:@"owner"];
            [dict setObject:_Video._PathVideo forKey:@"path"];
            [dict setObject:_Video._PathCompare forKey:@"pathcompare"];
            [dict setObject:_Video._VideoType forKey:@"videotype"];
            [dict setObject:_Video._Time forKey:@"time"];
            [dict setObject:[NSNumber numberWithBool:_Video._Prepare] forKey:@"prepare"];
            [dict setObject:[NSNumber numberWithBool:_Video._Voice] forKey:@"voice"];
            [dict setObject:[NSNumber numberWithBool:isFavorited] forKey:@"favorited"];
        }
        [mountainsArray replaceObjectAtIndex:i withObject:dict];
    }
    [mountainsArray writeToFile:path atomically:YES];
    
    /*NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_CurrentRow inSection:0];
    NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];*/
    
}

-(void)showViewUpdateInfoSVideo
{
    viewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    viewBackground.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
    
    viewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0f)];
    viewTitle.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:0.95f];
    
    btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(0, 0, 70.0f, 40.0f);
    btnDone.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:130.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    [btnDone setTitle:@"Huỷ" forState:UIControlStateNormal];
    btnDone.layer.cornerRadius = 5.0f;
    btnDone.clipsToBounds = YES;
    [btnDone addTarget:self action:@selector(noChange) forControlEvents:UIControlEventTouchUpInside];
    
    btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSave.frame = CGRectMake(self.view.frame.size.width - 70.0f, 0, 70.0f, 40.0f);
    btnSave.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:130.0f/255.0f blue:232.0f/255.0f alpha:0.95f];
    [btnSave setTitle:@"Lưu" forState:UIControlStateNormal];
    btnSave.layer.cornerRadius = 5.0f;
    btnSave.clipsToBounds = YES;
    [btnSave addTarget:self action:@selector(saveChange) forControlEvents:UIControlEventTouchUpInside];
    
    lblOwner = [[UILabel alloc] init];
    lblOwner.frame = CGRectMake(15.0f, viewTitle.frame.origin.y + viewTitle.frame.size.height + self.view.frame.size.height/50.0f, self.view.frame.size.width - 20.0f, self.view.frame.size.height/15.0f);
    lblOwner.backgroundColor = [UIColor clearColor];
    lblOwner.textColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    [lblOwner setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0f]];
    lblOwner.text = @"Chủ sở hữu:";
    
    sVideoUpdateInfo = [[SVideoInfo alloc] init];
    if (_IsMaster) {
        sVideoUpdateInfo = [listVideo objectAtIndex:_CurrentRow];
    } else {
        sVideoUpdateInfo = [listUser objectAtIndex:_CurrentRow];
    }
    
    txtFOwner = [[UITextField alloc] initWithFrame:CGRectMake(20.0f, lblOwner.frame.origin.y + lblOwner.frame.size.height + self.view.frame.size.height/100.0f, self.view.frame.size.width - 40.0f, self.view.frame.size.height/15.0f)];
    txtFOwner.text = [NSString stringWithFormat:@"  %@", sVideoUpdateInfo._Owner];
    [txtFOwner setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0f]];
    txtFOwner.textColor = [UIColor whiteColor];
    txtFOwner.delegate = self;
    txtFOwner.layer.cornerRadius = 8.0f;
    txtFOwner.clipsToBounds = YES;
    txtFOwner.backgroundColor = [UIColor colorWithWhite:0.2f alpha:0.9f];
    txtFOwner.textAlignment = NSTextAlignmentLeft;
    
    lblGolfTree = [[UILabel alloc] init];
    lblGolfTree.frame = CGRectMake(15.0f, txtFOwner.frame.origin.y + txtFOwner.frame.size.height + self.view.frame.size.height/50.0f, self.view.frame.size.width - 20.0f, self.view.frame.size.height/15.0f);
    lblGolfTree.backgroundColor = [UIColor clearColor];
    lblGolfTree.textColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    [lblGolfTree setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0f]];
    lblGolfTree.text = @"Loại gậy:";
    
    CGPoint pointStart = CGPointMake(20.0f, lblGolfTree.frame.origin.y + lblGolfTree.frame.size.height + self.view.frame.size.height/100.0f);
    int paddingBetween = 10.0f;
    CGSize btnSize = CGSizeMake((self.view.frame.size.width - 40.0f - 2*paddingBetween)/3.0f, self.view.frame.size.height/15.0f);
    arrGolfTree = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 3; j++) {
            if (i*3 + j >= 13) {
                break;
            }
            UIButton *btnGolfTree = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btnGolfTree.frame = CGRectMake(pointStart.x, pointStart.y, btnSize.width, btnSize.height);
            [btnGolfTree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btnGolfTree.backgroundColor = [UIColor colorWithWhite:0.2f alpha:0.9f];
            btnGolfTree.layer.cornerRadius = 7.0f;
            btnGolfTree.clipsToBounds = YES;
            [btnGolfTree addTarget:self action:@selector(chooseGolfTree:) forControlEvents:UIControlEventTouchUpInside];
            btnGolfTree.tag = 1000 + i*3 + j;
            
            if (i*3 + j == 0) {
                [btnGolfTree setTitle:@"Driver" forState:UIControlStateNormal];
                [btnGolfTree.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f]];
            } else {
                if (i*3 + j == 1) {
                    [btnGolfTree setTitle:@"Wood" forState:UIControlStateNormal];
                    [btnGolfTree.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f]];
                } else {
                    if (i*3 + j == 2) {
                        [btnGolfTree setTitle:@"Sand Wedge" forState:UIControlStateNormal];
                        [btnGolfTree.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13.0f]];
                    } else {
                        if (i*3 + j == 10) {
                            [btnGolfTree setTitle:@"Hybrid" forState:UIControlStateNormal];
                            [btnGolfTree.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f]];
                        } else {
                            if (i*3 + j == 11) {
                                [btnGolfTree setTitle:@"Pitching Wedge" forState:UIControlStateNormal];
                                [btnGolfTree.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:11.0f]];
                            } else {
                                if (i*3 + j == 12) {
                                    [btnGolfTree setTitle:@"Putter" forState:UIControlStateNormal];
                                    [btnGolfTree.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f]];
                                } else {
                                    [btnGolfTree setTitle:[NSString stringWithFormat:@"%d Iron", i*3 + j] forState:UIControlStateNormal];
                                    [btnGolfTree.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f]];
                                }
                            }
                        }
                    }
                }
            }
            [viewBackground addSubview:btnGolfTree];
            [arrGolfTree addObject:btnGolfTree];
            pointStart.x += btnSize.width + self.view.frame.size.height/48.0f;
        }
        pointStart.x = 20.0f;
        pointStart.y += btnSize.height + self.view.frame.size.height/48.0f;

    }
    
    [viewTitle addSubview:btnSave];
    [viewTitle addSubview:btnDone];
    [viewBackground addSubview:viewTitle];
    [viewBackground addSubview:lblOwner];
    [viewBackground addSubview:txtFOwner];
    [viewBackground addSubview:lblGolfTree];
    [self.view addSubview:viewBackground];
    
    
    viewBackground.alpha = 0;
    viewBackground.center = CGPointMake(self.view.frame.size.width/2.0f, 0);
    [UIView beginAnimations:NULL context:nil];
    [UIView setAnimationDuration:1.0f];
    
    viewBackground.alpha = 0.98f;
    viewBackground.center = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height/2.0f);
    [UIView commitAnimations];
}

-(void)chooseGolfTree:(UIButton*)sender
{
    sVideoUpdateInfo._GolfTree = sender.titleLabel.text;
    for (int z = 0; z < [arrGolfTree count]; z++) {
        if (((UIButton*)[arrGolfTree objectAtIndex:z]).tag == sender.tag) {
            [((UIButton*)[arrGolfTree objectAtIndex:z]) setEnabled:YES];
            [((UIButton*)[arrGolfTree objectAtIndex:z]) setBackgroundColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:0.95f]];
        } else {
            [((UIButton*)[arrGolfTree objectAtIndex:z]) setAlpha:0.5f];
            [((UIButton*)[arrGolfTree objectAtIndex:z]) setEnabled:NO];
        }
    }
}

-(void)noChange
{
    [btnDone removeFromSuperview];
    [btnSave removeFromSuperview];
    [viewBackground removeFromSuperview];
}

-(void)saveChange
{
    sVideoUpdateInfo._Owner = txtFOwner.text;
    [self updateSVideoToDB];
    [btnDone removeFromSuperview];
    [btnSave removeFromSuperview];
    [viewBackground removeFromSuperview];
}

-(void)updateSVideoToDB
{
    NSString *stringDBName;
    if (!_IsMaster) {
        stringDBName = @"SVideosUser";
    }
    else
    {
        stringDBName = @"SVideosMaster";
    }
    
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", stringDBName]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:stringDBName ofType: @"plist"];
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    NSMutableArray *mountainsArray = [[[NSMutableArray alloc] initWithContentsOfFile:path]mutableCopy];
    
    for (int i = 0; i < [mountainsArray count]; i++) {
        NSMutableDictionary *dict = [mountainsArray objectAtIndex:i];
        
        if (i == _CurrentRow) {
            [dict setObject:sVideoUpdateInfo._GolfTree forKey:@"golftree"];
            [dict setObject:sVideoUpdateInfo._Owner forKey:@"owner"];
        }
        [mountainsArray replaceObjectAtIndex:i withObject:dict];
    }
    [mountainsArray writeToFile:path atomically:YES];
    
    if (!_IsMaster) {
        for (int i = 0; i < [listView count]; i++) {
            [[listView objectAtIndex:i] removeFromSuperview];
        }
        [listView removeAllObjects];
        listCell = [[NSMutableArray alloc] init];
        countIndex0 = 0;
        
        listUser = [_CoreGUI loadVideoWithType:1];
        numRows = [listUser count];
        [btnTagUser setTitleColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [btnTagSystem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnTagUser.backgroundColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
        btnTagSystem.backgroundColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
        
        [self.tableView reloadData];

    }
    else
    {
        for (int i = 0; i < [listView count]; i++) {
            [[listView objectAtIndex:i] removeFromSuperview];
        }
        [listView removeAllObjects];
        listCell = [[NSMutableArray alloc] init];
        countIndex0 = 0;
        
        listVideo = [_CoreGUI loadVideoWithType:0];
        numRows = [listVideo count];
        [btnTagUser setTitleColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [btnTagSystem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnTagUser.backgroundColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
        btnTagSystem.backgroundColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
        
        [self.tableView reloadData];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [_CoreGUI._TabBar.tabBar setHidden:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    if (_FlagUpdate) {
        viewProcess = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        viewProcess.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.5f];
        spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.center = CGPointMake((self.view.frame.size.width)/2.0f, (self.view.frame.size.height)/2.0f - 50.0f);
        spinner.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
        [viewProcess addSubview:spinner];
        [self.view addSubview:viewProcess];
        [spinner startAnimating];
    }
    
    self.tableView.hidden = YES;
    
    if (_IsMaster == YES) {
        [self loadSwingVideoOfSystem];
        
        [self performSelector:@selector(stopHiddenTableView) withObject:nil afterDelay:0.8f];
        self.navigationController.navigationBarHidden = NO;
        
        if (_FlagUpdate && [listVideo count] != 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_CurrentRow inSection:0];
            NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
            [self.tableView beginUpdates];
            [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }
    } else {
        [self loadSwingVideoOfUser];
        
        [self performSelector:@selector(stopHiddenTableView) withObject:nil afterDelay:0.5f];
        self.navigationController.navigationBarHidden = NO;
        
        if (_FlagEdit && [listUser count] != 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_CurrentRow inSection:0];
            NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
            [self.tableView beginUpdates];
            [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
            _FlagEdit = NO;
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    // [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)orientationChanged:(NSNotification *)notification
{
    [self supportedInterfaceOrientations];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.


-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}
// Override to allow orientations other than the default portrait orientation.

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


@end
