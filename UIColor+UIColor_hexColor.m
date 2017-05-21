//
//  UIColor+UIColor_hexColor.h UIColor+UIColor_hexColor.m
//  DemoWithFBAndGloginUsingFirebase
//
//  Created by Logan on 2017/5/21.
//  Copyright © 2017年 tw.logan. All rights reserved.
//

#import "UIColor+UIColor_hexColor.h"

@implementation UIColor (UIColor_hexColor)

+ (UIColor *)hexFloatColor:(NSString *)hexStr {
    if (hexStr.length < 6)
        return nil;
    
    unsigned int red_, green_, blue_;
    NSRange exceptionRange;
    exceptionRange.length = 2;
    
    //red
    exceptionRange.location = 0;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]]scanHexInt:&red_];
    
    //green
    exceptionRange.location = 2;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]]scanHexInt:&green_];
    
    //blue
    exceptionRange.location = 4;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]]scanHexInt:&blue_];
    
    UIColor *resultColor = RGB(red_, green_, blue_);
    return resultColor;
}

@end

