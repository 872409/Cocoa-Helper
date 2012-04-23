//
//  UIColor+Helper.h
//  phpwind
//
//  Created by Lee Henson on 12-4-23.
//  Copyright (c) 2012年 Alibaba Cloud Computing. All rights reserved.
//

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

/*
 * Convenience method to return a UIColor with RGB values based on 255
 */
UIColor* UIColorMakeRGB(CGFloat red, CGFloat green, CGFloat blue);

@interface UIColor (Helper)

@end
#endif
