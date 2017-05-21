//
//  BaseVC.h
//  DemoWithFBAndGloginUsingFirebase
//
//  Created by Logan on 2017/5/21.
//  Copyright © 2017年 tw.logan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define mainHeight     [[UIScreen mainScreen] bounds].size.height
#define mainWidth      [[UIScreen mainScreen] bounds].size.width
#define navBarHeight   self.navigationController.navigationBar.frame.size.height
#define statusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define RGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1.]
@interface BaseVC : UIViewController

#pragma mark UI related properties & functions
@property (nonatomic, assign) BOOL showBackBtn;
@property (nonatomic,   copy) NSString *itemTitle;
@property (nonatomic,   copy) NSString *requestURL;
@property (nonatomic, strong) UIButton *navLeftBtn;
@property (nonatomic, strong) UIButton *navRightBtn;


- (void)actionCustomLeftBtnWithNrlImage:(NSString *)nrlImage htlImage:(NSString *)hltImage
                                  title:(NSString *)title
                                 action:(void(^)())btnClickBlock;
- (void)actionCustomRightBtnWithNrlImage:(NSString *)nrlImage htlImage:(NSString *)hltImage
                                   title:(NSString *)title
                                  action:(void(^)())btnClickBlock;

- (void)actionCustomSegementControlWithItmes:(NSArray *)items action:(void(^)(NSInteger index))segementBlock;

@end

