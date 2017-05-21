//
//  ViewController.m
//  DemoWithFBAndGloginUsingFirebase
//
//  Created by Logan on 2017/5/20.
//  Copyright © 2017年 tw.logan. All rights reserved.
//
#import "ViewController.h"
#import "mainPage.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
typedef void (^TestBlock)(void);

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.hidden = YES;
    UIButton *btnSignInForFacebook = [[UIButton alloc]initWithFrame:CGRectMake(mainWidth/2-140, mainHeight/2, 280, 31)];
    [btnSignInForFacebook setTitle:@"Sign in with Facebook" forState:UIControlStateNormal];
    [btnSignInForFacebook setBackgroundColor:RGB(0,128,255)];
    [btnSignInForFacebook setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSignInForFacebook addTarget:self action:@selector(signInWithFB:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSignInForFacebook];
    
    UIButton *btnSignInForGoogle = [[UIButton alloc]initWithFrame:CGRectMake(mainWidth/2-140, btnSignInForFacebook.frame.origin.y+31+10, 280, 31)];
    [btnSignInForGoogle setTitle:@"Sign in with Google" forState:UIControlStateNormal];
    [btnSignInForGoogle setBackgroundColor:[UIColor colorWithRed:255 green:0 blue:0 alpha:.8]];
    [btnSignInForGoogle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSignInForGoogle addTarget:self action:@selector(signInWithGoogle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSignInForGoogle];
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    //[self fetchUserInfo];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)signInWithFB:(UIButton *)sender {
    
    FBSDKLoginManager *fbLoginManager = [[FBSDKLoginManager alloc]init];
    [fbLoginManager logInWithReadPermissions:@[@"public_profile", @"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {

        if (error)
        {
            NSLog(@"Failed to login: %@", error.localizedDescription);
        }
        else if (result.isCancelled)
        {
            // Handle cancellations
        }
        else
        {
            if ([result.grantedPermissions containsObject:@"email"])
            {
                NSLog(@"result is:%@",result);
                [self fetchUserInfo];
            }
        }
        
    }];
    
}

-(void)fetchUserInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
        
        
        FIRAuthCredential *credential = [FIRFacebookAuthProvider credentialWithAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
        
        [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser *user, NSError *error){
            if (error) {
                NSLog(@"Login error: %@", error.localizedDescription);
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:alert animated:YES completion:nil];
                return ;
            }else {
                NSLog(@"Login Succsessfully.");
                [self loadMainPage];
            }
        }];
        
    }

}

- (IBAction)signInWithGoogle:(UIButton *)sender {
    [[GIDSignIn sharedInstance] signIn];
}

//Singleton
+ (instancetype) sharedInstance
{
    static ViewController *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ViewController alloc] init];
    });
    return instance;
}

- (void)loadMainPage {
    mainPage *mainpage = [[mainPage alloc]init];
    [self.navigationController pushViewController:mainpage animated:YES];
}


@end
