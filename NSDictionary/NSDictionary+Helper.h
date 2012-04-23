//
//  NSDictionary+Helper.h
//  phpwind
//
//  Created by Lee Henson on 12-4-23.
//  Copyright (c) 2012年 Alibaba Cloud Computing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Helper)

/*
 * Checks to see if the dictionary contains the given key
 */
- (BOOL)containsObjectForKey:(id)key;

/*
 * Checks to see if the dictionary is empty
 */
@property(nonatomic, readonly, getter = isEmpty) BOOL empty;

@end
