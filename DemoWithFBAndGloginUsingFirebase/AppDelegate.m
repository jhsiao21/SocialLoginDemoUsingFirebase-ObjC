//
//  AppDelegate.m
//  DemoWithFBAndGloginUsingFirebase
//
//  Created by Logan on 2017/5/20.
//  Copyright © 2017年 tw.logan. All rights reserved.
//

#import "AppDelegate.h"
#import "mainPage.h"
#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
@import Firebase;
@import GoogleSignIn;

@interface AppDelegate (){
    ViewController *longinVC;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];

    longinVC = [ViewController sharedInstance];
    UINavigationController *mineVC = [[UINavigationController alloc]initWithRootViewController:longinVC];
    [self.window setRootViewController:mineVC];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // Use Firebase library to configure APIs
    [FIRApp configure];
    
    //FB
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    //Google
    [GIDSignIn sharedInstance].clientID = [FIRApp defaultApp].options.clientID;
    [GIDSignIn sharedInstance].delegate = self;
        
    return YES;
}



- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:app
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    
    [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    
    // Add any custom logic here.
    return handled;
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error {

}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    if (error == nil) {
        GIDAuthentication *authentication = user.authentication;
        FIRAuthCredential *credential =
        [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken
                                         accessToken:authentication.accessToken];
        NSLog(@"Successfully logged in with Goodle: %@",user);
        
        
        [[FIRAuth auth]signInWithCredential:credential completion:^(FIRUser *user, NSError *error){
            if (error) {
                NSLog(@"Failed to create a user with google sign in method: %@", error.localizedDescription);
                return;
            }
            
            if (user.uid) {
                NSLog(@"Successfully logged into Firebase with Google");
                //mainPage *mainpage = [[mainPage alloc]init];
                [longinVC loadMainPage];
            }
        }];
    } else {
        NSLog(@"Failed to log in with Google: %@", error.localizedDescription);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"DemoWithFBAndGloginUsingFirebase"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
