//
//  UIImage+Helper.m
//  phpwind
//
//  Created by Lee Henson on 12-4-23.
//  Copyright (c) 2012年 Alibaba Cloud Computing. All rights reserved.
//

#import "UIImage+Helper.h"

@implementation UIImage (Helper)

+ (UIImage *)imageWithFileName:(NSString *)fileName {
    NSString *imageFolderPath = [NSString stringWithFormat:@"%@/images/", [[NSBundle mainBundle] resourcePath]];
    NSString *imagePath = [imageFolderPath stringByAppendingString:fileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        return nil;
    }
    return [UIImage imageWithContentsOfFile:imagePath];
}

/*
 * 截屏
 * @see aspectScaleToSize:
 */
- (UIImage*)scaleToSize:(CGSize)size {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
	if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
		UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
	} else {
		UIGraphicsBeginImageContext(size);
	}
#else
	UIGraphicsBeginImageContext(size);
#endif
    
	[self drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
	UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	return scaledImage;
}

- (UIImage *)aspectScaleToMaxSize:(CGFloat)size 
                  withBorderSize:(CGFloat)borderSize 
                     borderColor:(UIColor*)aColor 
                    cornerRadius:(CGFloat)aRadius 
                    shadowOffset:(CGSize)aOffset 
                shadowBlurRadius:(CGFloat)aBlurRadius 
                     shadowColor:(UIColor*)aShadowColor {
    
	CGSize imageSize = CGSizeMake(self.size.width, self.size.height);
    
	CGFloat hScaleFactor = imageSize.width / size;
	CGFloat vScaleFactor = imageSize.height / size;
    
	CGFloat scaleFactor = MAX(hScaleFactor, vScaleFactor);
    
	CGFloat newWidth = imageSize.width   / scaleFactor;
	CGFloat newHeight = imageSize.height / scaleFactor;
    
	CGRect imageRect = CGRectMake(borderSize, borderSize, newWidth, newHeight);
	
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
	if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
		UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWidth + (borderSize*2), newHeight + (borderSize*2)), NO, [[UIScreen mainScreen] scale]);
	} else {
		UIGraphicsBeginImageContext(CGSizeMake(newWidth + (borderSize*2), newHeight + (borderSize*2)));
	}
#else
	UIGraphicsBeginImageContext(CGSizeMake(newWidth + (borderSize*2), newHeight + (borderSize*2)));
#endif
    
    
	CGContextRef imageContext = UIGraphicsGetCurrentContext();
	CGContextSaveGState(imageContext);
	CGPathRef path = NULL;
    
	if (aRadius > 0.0f) {
		CGFloat radius;	
		radius = MIN(aRadius, floorf(imageRect.size.width/2));
		float x0 = CGRectGetMinX(imageRect), y0 = CGRectGetMinY(imageRect), x1 = CGRectGetMaxX(imageRect), y1 = CGRectGetMaxY(imageRect);
        
		CGContextBeginPath(imageContext);
		CGContextMoveToPoint(imageContext, x0+radius, y0);
		CGContextAddArcToPoint(imageContext, x1, y0, x1, y1, radius);
		CGContextAddArcToPoint(imageContext, x1, y1, x0, y1, radius);
		CGContextAddArcToPoint(imageContext, x0, y1, x0, y0, radius);
		CGContextAddArcToPoint(imageContext, x0, y0, x1, y0, radius);
		CGContextClosePath(imageContext);
		path = CGContextCopyPath(imageContext);
		CGContextClip(imageContext);
	} 
    
	[self drawInRect:imageRect];	
	CGContextRestoreGState(imageContext);
    
	if (borderSize > 0.0f) {
		CGContextSetLineWidth(imageContext, borderSize);
		[aColor != nil ? aColor : [UIColor blackColor] setStroke];
        
		if(path == NULL){
			CGContextStrokeRect(imageContext, imageRect);
		} else {
			CGContextAddPath(imageContext, path);
			CGContextStrokePath(imageContext);
		}
	}
    
	if (path != NULL){
		CGPathRelease(path);
	}
    
	UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	if (aBlurRadius > 0.0f) {
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			UIGraphicsBeginImageContextWithOptions(CGSizeMake(scaledImage.size.width + (aBlurRadius*2), scaledImage.size.height + (aBlurRadius*2)), NO, [[UIScreen mainScreen] scale]);
		} else {
			UIGraphicsBeginImageContext(CGSizeMake(scaledImage.size.width + (aBlurRadius*2), scaledImage.size.height + (aBlurRadius*2)));
		}
#else
		UIGraphicsBeginImageContext(CGSizeMake(scaledImage.size.width + (aBlurRadius*2), scaledImage.size.height + (aBlurRadius*2)));
#endif
        
		CGContextRef imageShadowContext = UIGraphicsGetCurrentContext();
        
		if (aShadowColor!=nil) {
			CGContextSetShadowWithColor(imageShadowContext, aOffset, aBlurRadius, aShadowColor.CGColor);
		} else {
			CGContextSetShadow(imageShadowContext, aOffset, aBlurRadius);
		}
        
		[scaledImage drawInRect:CGRectMake(aBlurRadius, aBlurRadius, scaledImage.size.width, scaledImage.size.height)];
		scaledImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
        
	}
    
	return scaledImage;	
}

- (UIImage *)aspectScaleToMaxSize:(CGFloat)size 
                withShadowOffset:(CGSize)aOffset 
                      blurRadius:(CGFloat)aRadius 
                           color:(UIColor*)aColor {
	return [self aspectScaleToMaxSize:size	withBorderSize:0 borderColor:nil cornerRadius:0 shadowOffset:aOffset shadowBlurRadius:aRadius shadowColor:aColor];
}

- (UIImage *)aspectScaleToMaxSize:(CGFloat)size 
                withCornerRadius:(CGFloat)aRadius {
	return [self aspectScaleToMaxSize:size withBorderSize:0 borderColor:nil cornerRadius:aRadius shadowOffset:CGSizeZero shadowBlurRadius:0.0f shadowColor:nil];
}

- (UIImage *)aspectScaleToMaxSize:(CGFloat)size {
	return [self aspectScaleToMaxSize:size withBorderSize:0 borderColor:nil cornerRadius:0 shadowOffset:CGSizeZero shadowBlurRadius:0.0f shadowColor:nil];
}

- (UIImage*)aspectScaleToSize:(CGSize)size {
	CGSize imageSize = CGSizeMake(self.size.width, self.size.height);
    
	CGFloat hScaleFactor = imageSize.width / size.width;
	CGFloat vScaleFactor = imageSize.height / size.height;
    
	CGFloat scaleFactor = MAX(hScaleFactor, vScaleFactor);
    
	CGFloat newWidth = imageSize.width   / scaleFactor;
	CGFloat newHeight = imageSize.height / scaleFactor;
    
	// center vertically or horizontally in size passed
	CGFloat leftOffset = (size.width - newWidth) / 2;
	CGFloat topOffset = (size.height - newHeight) / 2;
	
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
	if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
		UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, [[UIScreen mainScreen] scale]);
	} else {
		UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
	}
#else
	UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
#endif
    
	[self drawInRect:CGRectMake(leftOffset, topOffset, newWidth, newHeight)];
	UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	return scaledImage;	
}

@end
