//
//  BaseVC.m
//  DemoWithFBAndGloginUsingFirebase
//
//  Created by Logan on 2017/5/21.
//  Copyright © 2017年 tw.logan. All rights reserved.
//

#import "BaseVC.h"
#import <objc/runtime.h>
#import "UIColor+UIColor_hexColor.h"

static char *btnClickAction;
static char *segementClickAction;

@interface BaseVC ()

@end

@implementation BaseVC
@synthesize showBackBtn;

- (id)init {
    if (self = [super init]) {
        if ([self respondsToSelector:@selector(setExtendedLayoutIncludesOpaqueBars:)])
        {
            self.extendedLayoutIncludesOpaqueBars = NO;
        }
        if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        if([self respondsToSelector:@selector(setModalPresentationCapturesStatusBarAppearance:)])
        {
            self.modalPresentationCapturesStatusBarAppearance = YES;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[NAVBAR_COLOR CGColor]);
    CGContextFillRect(context, rect);
    UIImage * imge = [[UIImage alloc] init];
    imge = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBackgroundImage:imge forBarMetrics:UIBarMetricsDefault];
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionCustomSegementControlWithItmes:(NSArray *)items action:(void(^)(NSInteger index))segementBlock
{
    UISegmentedControl *segementedControl = [[UISegmentedControl alloc]initWithItems:items];
    
    //按下按钮时的颜色
    //    segementedControl.tintColor = [UIColor colorWithRed:49.0/256.0 green:148.0/256.0 blue:208.0/256.0 alpha:1];
    segementedControl.tintColor = [UIColor whiteColor];
    segementedControl.selectedSegmentIndex = 0; //默认选中的按钮索引
    
    //下面的代码实同正常状态的属性控制，比如字体的大小和颜色等
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    [segementedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [segementedControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    objc_setAssociatedObject(segementedControl, &segementClickAction, segementBlock, OBJC_ASSOCIATION_COPY);
    
    [segementedControl addTarget:self action:@selector(actionInSegment:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = segementedControl;
    //    [self.navigationItem setTitleView:segementedControl];
}

#pragma mark -actionCustomLeftBtnWithNrlImage
- (void)actionCustomLeftBtnWithNrlImage:(NSString *)nrlImage htlImage:(NSString *)hltImage
                                  title:(NSString *)title
                                 action:(void(^)())btnClickBlock {
    self.navLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.navLeftBtn setBackgroundColor:[UIColor clearColor]];
    objc_setAssociatedObject(self.navLeftBtn, &btnClickAction, btnClickBlock, OBJC_ASSOCIATION_COPY);
    [self actionCustomNavBtn:self.navLeftBtn nrlImage:nrlImage htlImage:hltImage title:title];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];
}

#pragma mark -actionCustomRightBtnWithNrlImage
- (void)actionCustomRightBtnWithNrlImage:(NSString *)nrlImage htlImage:(NSString *)hltImage
                                   title:(NSString *)title
                                  action:(void(^)())btnClickBlock {
    self.navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    objc_setAssociatedObject(self.navRightBtn, &btnClickAction, btnClickBlock, OBJC_ASSOCIATION_COPY);
    [self actionCustomNavBtn:self.navRightBtn nrlImage:nrlImage htlImage:hltImage title:title];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn];
}

#pragma mark -actionCustomNavBtn
- (void)actionCustomNavBtn:(UIButton *)btn nrlImage:(NSString *)nrlImage
                  htlImage:(NSString *)hltImage
                     title:(NSString *)title {
    [btn setImage:[UIImage imageNamed:nrlImage] forState:UIControlStateNormal];
    if (hltImage) {
        [btn setImage:[UIImage imageNamed:hltImage] forState:UIControlStateHighlighted];
    } else {
        [btn setImage:[UIImage imageNamed:nrlImage] forState:UIControlStateNormal];
    }
    if (title) {
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:16.];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    }
    [btn sizeToFit];
    [btn addTarget:self action:@selector(actionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -actionInSegment
- (void)actionInSegment:(UISegmentedControl *)seg
{
    NSInteger index = seg.selectedSegmentIndex;
    void (^btnClickBlock) (NSInteger index) = objc_getAssociatedObject(seg, &segementClickAction);
    btnClickBlock(index);
}

#pragma mark -actionBtnClick
- (void)actionBtnClick:(UIButton *)btn {
    void (^btnClickBlock) (void) = objc_getAssociatedObject(btn, &btnClickAction);
    btnClickBlock();
}

#pragma mark -getter or setter
- (void)setItemTitle:(NSString *)title {
    _itemTitle = title;
    [self.navigationItem setTitle:_itemTitle];
}

- (void)setShowBackBtn:(BOOL)showBack {
    __weak typeof(self) wSelf = self;
    // TODO TODO TODO - how to deal with the image resources?
    [self actionCustomLeftBtnWithNrlImage:@"btnBack" htlImage:nil title:nil action:^{
        [wSelf.navigationController popViewControllerAnimated:YES];
    }];
}



@end
