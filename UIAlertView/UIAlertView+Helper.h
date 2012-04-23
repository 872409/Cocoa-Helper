//
//  UIAlertView+Helper.h
//  phpwind
//
//  Created by Lee Henson on 12-4-23.
//  Copyright (c) 2012年 Alibaba Cloud Computing. All rights reserved.
//

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

/*
 * Convenience method to throw a quick alert to the user
 * Runs LocalizedString() on all strings
 */
void UIAlertViewQuick(NSString* title, NSString* message, NSString* dismissButtonTitle);

@interface UIAlertView (Helper)

@end
#endif