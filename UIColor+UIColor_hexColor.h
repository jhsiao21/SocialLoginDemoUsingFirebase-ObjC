//
//  UIColor+UIColor_hexColor.h UIColor+UIColor_hexColor.h
//  DemoWithFBAndGloginUsingFirebase
//
//  Created by Logan on 2017/5/21.
//  Copyright © 2017年 tw.logan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1.]
#define NAVBAR_COLOR                RGB(52,153,207)

@interface UIColor (UIColor_hexColor)

+ (UIColor *)hexFloatColor:(NSString *)hexStr;

@end
