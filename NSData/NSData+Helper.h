//
//  NSData+Helper.h
//  phpwind
//
//  Created by Lee Henson on 12-4-23.
//  Copyright (c) 2012年 Alibaba Cloud Computing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Helper)

@property(nonatomic, readonly, getter = isEmpty) BOOL empty;

+ (NSData *)dataFromBase64String:(NSString *)aString;

- (NSString *)base64EncodedString;

@end
