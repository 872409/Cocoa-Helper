//
//  NSStringHelper.m
//  phpwind
//
//  Created by Lee Henson on 12-4-23.
//  Copyright (c) 2012年 Alibaba Cloud Computing. All rights reserved.
//

#import "NSString+Helper.h"
#import <CommonCrypto/CommonDigest.h>

int const GGCharacterIsNotADigit = 10;

@implementation NSString (Helper)

+ (NSString*)stringWithFormattedUnsignedInteger:(NSUInteger)integer {
    NSNumber* number = [NSNumber numberWithUnsignedInteger:integer];
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	NSString* formattedString = [formatter stringFromNumber:number];
	[formatter release];
	return formattedString;
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)containsString:(NSString*)string {
	return [self containsString:string options:NSCaseInsensitiveSearch];
}

- (BOOL)containsString:(NSString*)string options:(NSStringCompareOptions)options {
	return [self rangeOfString:string options:options].location == NSNotFound ? NO : YES;
}

#pragma mark -
#pragma mark Long conversions

- (long)longValue {
	return (long)[self longLongValue];
}

- (long long)longLongValue {
	NSScanner* scanner = [NSScanner scannerWithString:self];
	long long valueToGet;
	if ([scanner scanLongLong:&valueToGet] == YES) {
		return valueToGet;
	}
	
    return 0;
}

- (unsigned)digitValue:(unichar)c {    
	if ((c > 47) && (c < 58)) {
        return (c - 48);
	}
    
	return GGCharacterIsNotADigit;
}

- (unsigned long long)unsignedLongLongValue {
	unsigned n = [self length];
	unsigned long long v,a;
	unsigned small_a, j;
    
	v = 0;
	for (j=0; j<n; j++) {
		unichar c = [self characterAtIndex:j];
		small_a = [self digitValue:c];
		if (small_a == GGCharacterIsNotADigit) continue;
		a = (unsigned long long)small_a;
		v = (10 * v) + a;
	}
    
	return v;
}

- (NSString *)md5 {
	const char *str = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
	
	NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
	for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		[ret appendFormat:@"%02x", result[i]];
	}
	return ret;
}

- (NSString *)SHA1 {
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

#pragma mark -
#pragma mark Truncation

- (NSString*)stringByTruncatingToLength:(int)length {
	return [self stringByTruncatingToLength:length direction:NSTruncateStringPositionEnd];
}

- (NSString*)stringByTruncatingToLength:(int)length direction:(NSTruncateStringPosition)truncateFrom {
	return [self stringByTruncatingToLength:length direction:truncateFrom withEllipsisString:@"..."];
}

- (NSString*)stringByTruncatingToLength:(int)length 
                              direction:(NSTruncateStringPosition)truncateFrom 
                     withEllipsisString:(NSString*)ellipsis {
	NSMutableString *result = [[NSMutableString alloc] initWithString:self];
	NSString *immutableResult;
    
	if ([result length] <= length) {
		[result release];
		return self;
	}
    
	unsigned int charactersEachSide = length / 2;
    
	NSString* first;
	NSString* last;
    
	switch(truncateFrom) {
		case NSTruncateStringPositionStart:
			[result insertString:ellipsis atIndex:[result length] - length + [ellipsis length] ];
			immutableResult  = [[result substringFromIndex:[result length] - length] copy];
			[result release];
			return [immutableResult autorelease];
		case NSTruncateStringPositionMiddle:
			first = [result substringToIndex:charactersEachSide - [ellipsis length]+1];
			last = [result substringFromIndex:[result length] - charactersEachSide];
			immutableResult = [[[NSArray arrayWithObjects:first, last, NULL] componentsJoinedByString:ellipsis] copy];
			[result release];
			return [immutableResult autorelease];
		default:
		case NSTruncateStringPositionEnd:
			[result insertString:ellipsis atIndex:length - [ellipsis length]];
			immutableResult  = [[result substringToIndex:length] copy];
			[result release];
			return [immutableResult autorelease];
	}
}

@end

