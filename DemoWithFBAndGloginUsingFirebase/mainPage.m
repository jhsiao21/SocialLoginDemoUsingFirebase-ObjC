//
//  mainPage.m
//  DemoWithFBAndGloginUsingFirebase
//
//  Created by Logan on 2017/5/21.
//  Copyright © 2017年 tw.logan. All rights reserved.
//

#import "mainPage.h"

@implementation mainPage


-(void)viewDidLoad {
    [super viewDidLoad];
    self.showBackBtn = YES;
    self.itemTitle = @"Main Page";
    self.navigationController.navigationBar.hidden = NO;
    UILabel *lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(mainWidth/2-240, mainHeight/2-64, 240, 20)];
    lblTitle.text = @"Welcome.";
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblTitle];
}

- (void)viewWillAppear:(BOOL)animated {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
