//
//  ViewController.h
//  DemoWithFBAndGloginUsingFirebase
//
//  Created by Logan on 2017/5/20.
//  Copyright © 2017年 tw.logan. All rights reserved.
//

#import "BaseVC.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@import Firebase;
@import GoogleSignIn;

@interface ViewController : BaseVC<GIDSignInUIDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnFacebook;
@property (weak, nonatomic) IBOutlet UIButton *btnGoogle;

+ (instancetype) sharedInstance;
- (void) loadMainPage;

@end

