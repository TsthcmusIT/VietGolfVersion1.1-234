//
//  CreateVideoViewController.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "CreateVideoViewController.h"
#import "CoreGUIController.h"

@interface CreateVideoViewController ()

@end

@implementation CreateVideoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Tạo video";
    _ScreenName = CreateVideoSwing;
    
    imaBackground = [[UIImageView alloc] init];
    imaBackground.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //imaBackground.image = [UIImage imageNamed:@""];
    imaBackground.backgroundColor = [UIColor whiteColor];
    
    imaVTitle = [[UIImageView alloc] init];
    imaVTitle.frame = CGRectMake(0, 0, self.view.frame.size.width/2.0f, 100.0f);
    imaVTitle.image = [UIImage imageNamed:@"TitleCreateVideoScreen.png"];
    
    btnTutorial = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnTutorial.frame = CGRectMake(0, 0, 60.0f, 60.0f);
    btnTutorial.center = CGPointMake((3.0f/4.0f)*self.view.frame.size.width, imaVTitle.frame.origin.y + 50.0f);
    [btnTutorial setBackgroundImage:[UIImage imageNamed:@"Tutorial.png"] forState:UIControlStateNormal];
    [btnTutorial addTarget:self action:@selector(recordVideoForTagging) forControlEvents:UIControlEventTouchUpInside];
    
    // --
    btnGoToList = [UIButton buttonWithType:UIButtonTypeCustom];
    btnGoToList.frame = CGRectMake(10.0f, self.view.frame.size.height - 130.0f, self.view.frame.size.width - 20.0f, 50.0f);
    btnGoToList.clipsToBounds = YES;
    btnGoToList.layer.cornerRadius = 8.0f;
    [btnGoToList setBackgroundImage:[UIImage imageNamed:@"LibraryButton.png"] forState:UIControlStateNormal];
    btnGoToList.adjustsImageWhenHighlighted = NO;
    
    [btnGoToList addTarget:self action:@selector(gotoListVideo) forControlEvents:UIControlEventTouchUpInside];
    
    imaVGoToList = [[UIImageView alloc] init];
    imaVGoToList.frame = CGRectMake(0, 0, 60, 60.0f);
    imaVGoToList.center = CGPointMake(btnGoToList.frame.origin.x + 35.0f, btnGoToList.frame.origin.y + 25.0f);
    imaVGoToList.image = [UIImage imageNamed:@"LibraryIcon.png"];
    // --
    btnImport = [UIButton buttonWithType:UIButtonTypeCustom];
    btnImport.frame = CGRectMake(10.0f, btnGoToList.frame.origin.y - 55.0f, self.view.frame.size.width - 20.0f, 50.0f);
    btnImport.clipsToBounds = YES;
    btnImport.layer.cornerRadius = 8.0f;
    [btnImport setBackgroundImage:[UIImage imageNamed:@"ImportButton.png"] forState:UIControlStateNormal];
    [btnImport addTarget:self action:@selector(importVideoForTagging) forControlEvents:UIControlEventTouchUpInside];
    btnImport.adjustsImageWhenHighlighted = NO;
    
    imaVImport = [[UIImageView alloc] init];
    imaVImport.frame = CGRectMake(0, 0, 60.0f, 60.0f);
    imaVImport.center = CGPointMake(btnImport.frame.origin.x + 35.0f, btnImport.frame.origin.y + 25.0f);
    imaVImport.image = [UIImage imageNamed:@"ImportIcon.png"];
    // --
    btnRecord = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRecord.frame = CGRectMake(10.0f, btnImport.frame.origin.y - 55.0f, self.view.frame.size.width - 20.0f, 50.0f);
    btnRecord.clipsToBounds = YES;
    btnRecord.layer.cornerRadius = 8.0f;
    [btnRecord setBackgroundImage:[UIImage imageNamed:@"RecordButton.png"] forState:UIControlStateNormal];
    [btnRecord addTarget:self action:@selector(recordVideoForTagging) forControlEvents:UIControlEventTouchUpInside];
    btnRecord.adjustsImageWhenHighlighted = NO;
    
    imaVRecord = [[UIImageView alloc] init];
    imaVRecord.frame = CGRectMake(0, 0, 60.0f, 60.0f);
    imaVRecord.center = CGPointMake(btnRecord.frame.origin.x + 35.0f, btnRecord.frame.origin.y + 25.0f);
    imaVRecord.image = [UIImage imageNamed:@"RecordIcon.png"];
    
    
    [self.view addSubview:imaBackground];
    [self.view addSubview:imaVTitle];
    [self.view addSubview:btnTutorial];
    [self.view addSubview:btnRecord];
    [self.view addSubview:btnImport];
    [self.view addSubview:btnGoToList];
    [self.view addSubview:imaVRecord];
    [self.view addSubview:imaVImport];
    [self.view addSubview:imaVGoToList];
    
}

-(void)recordVideoForTagging
{
    imaVRecord.image = [UIImage imageNamed:@"RecordIconPressed.png"];
    [self performSelector:@selector(recordScreen) withObject:nil afterDelay:0.6f];
    
}

-(void)importVideoForTagging
{
    imaVImport.image = [UIImage imageNamed:@"ImportIconPressed.png"];
    [self performSelector:@selector(importScreen) withObject:nil afterDelay:0.6f];
    
}

-(void)gotoListVideo
{
    imaVGoToList.image = [UIImage imageNamed:@"LibraryIconPressed.png"];
    [self performSelector:@selector(swingVideoScreen) withObject:nil afterDelay:0.6f];
    
}

-(void)recordScreen
{
    imaVRecord.image = [UIImage imageNamed:@"RecordIcon.png"];
    [_CoreGUI finishedScreen:self withCode:20];
}

-(void)importScreen
{
    imaVImport.image = [UIImage imageNamed:@"ImportIcon.png"];
    [_CoreGUI finishedScreen:self withCode:21];
}

-(void)swingVideoScreen
{
    imaVGoToList.image = [UIImage imageNamed:@"LibraryIcon.png"];
    [_CoreGUI._TabBar setSelectedIndex:0];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    //self.navigationController.navigationBarHidden = NO;
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
