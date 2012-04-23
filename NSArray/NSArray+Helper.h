//
//  NSArrayHelper.h
//  phpwind
//
//  Created by Lee Henson on 12-4-23.
//  Copyright (c) 2012年 Alibaba Cloud Computing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Helper)

/*
 * Returns an array with A-Z and # to be used as section titles
 */
+ (NSArray*)arrayWithAlphaNumericTitles;

/*
 * Returns an array with the Search icon, A-Z and # to be used as section titles
 */
+ (NSArray*)arrayWithAlphaNumericTitlesWithSearch:(BOOL)search;

/*
 * Checks to see if the array is empty
 */
@property(nonatomic,readonly,getter=isEmpty) BOOL empty;

@end
