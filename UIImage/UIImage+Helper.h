//
//  UIImage+Helper.h
//  phpwind
//
//  Created by Lee Henson on 12-4-23.
//  Copyright (c) 2012年 Alibaba Cloud Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper) 

+ (UIImage *)imageWithFileName:(NSString *)fileName;

- (UIImage *)scaleToSize:(CGSize)size;

/*
 * Aspect scale with border color, and corner radius, and shadow
 */
- (UIImage *)aspectScaleToMaxSize:(CGFloat)size 
                   withBorderSize:(CGFloat)borderSize 
                      borderColor:(UIColor*)aColor 
                     cornerRadius:(CGFloat)aRadius 
                     shadowOffset:(CGSize)aOffset 
                 shadowBlurRadius:(CGFloat)aBlurRadius 
                      shadowColor:(UIColor*)aShadowColor;

/*
 * Aspect scale with a shadow
 */
- (UIImage*)aspectScaleToMaxSize:(CGFloat)size 
                withShadowOffset:(CGSize)aOffset 
                      blurRadius:(CGFloat)aRadius 
                           color:(UIColor *)aColor;

/*
 * Aspect scale with corner radius
 */
- (UIImage*)aspectScaleToMaxSize:(CGFloat)size 
                withCornerRadius:(CGFloat)aRadius;

/*
 * Aspect scales the image to a max size
 */
- (UIImage*)aspectScaleToMaxSize:(CGFloat)size;

/*
 * Aspect scales the image to a rect size
 */
- (UIImage*)aspectScaleToSize:(CGSize)size;

@end
