//
//  NSArrayHelper.m
//  phpwind
//
//  Created by Lee Henson on 12-4-23.
//  Copyright (c) 2012年 Alibaba Cloud Computing. All rights reserved.
//

#import "NSArray+Helper.h"

@implementation NSArray (Helper)

+ (NSArray*)arrayWithAlphaNumericTitles {
	return [self arrayWithAlphaNumericTitlesWithSearch:NO];
}

+ (NSArray*)arrayWithAlphaNumericTitlesWithSearch:(BOOL)search {
	if (search) {
		return [NSArray arrayWithObjects: @"{search}",
				@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", 
				@"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", 
				@"W", @"X", @"Y", @"Z", @"#", nil];
	}
	return [NSArray arrayWithObjects:
            @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", 
			@"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", 
			@"W", @"X", @"Y", @"Z", @"#", nil];
}

- (BOOL)isEmpty {
	return [self count] == 0 ? YES : NO;
}

@end
