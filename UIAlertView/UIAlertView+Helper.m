//
//  UIAlertView+Helper.m
//  phpwind
//
//  Created by Lee Henson on 12-4-23.
//  Copyright (c) 2012年 Alibaba Cloud Computing. All rights reserved.
//

#if TARGET_OS_IPHONE
#import "UIAlertView+Helper.h"
#import "NSString+Helper.h"

void UIAlertViewQuick(NSString* title, NSString* message, NSString* dismissButtonTitle) {
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:LocalizedString(title) 
													message:LocalizedString(message) 
												   delegate:nil 
										  cancelButtonTitle:LocalizedString(dismissButtonTitle) 
										  otherButtonTitles:nil
						  ];
	[alert show];
	[alert autorelease];
}

@implementation UIAlertView (Helper)

@end
#endif