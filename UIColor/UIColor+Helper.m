//
//  UIColor+Helper.m
//  phpwind
//
//  Created by Lee Henson on 12-4-23.
//  Copyright (c) 2012年 Alibaba Cloud Computing. All rights reserved.
//

#if TARGET_OS_IPHONE
#import "UIColor+Helper.h"

UIColor* UIColorMakeRGB(CGFloat red, CGFloat green, CGFloat blue) {
	return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0f];
}

@implementation UIColor (Helper)

@end
#endif
