//
//  AppDelegate.h
//  DemoWithFBAndGloginUsingFirebase
//
//  Created by Logan on 2017/5/20.
//  Copyright © 2017年 tw.logan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
@import Firebase;
@import GoogleSignIn;

@interface AppDelegate : UIResponder <UIApplicationDelegate,GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

