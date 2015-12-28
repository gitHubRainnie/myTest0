//
//  UIImage+Helper.h
//  shouying
//
//  Created by lemoon on 15/10/9.
//  Copyright © 2015年 BeiJingShouYingShiGuangTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(Helper)
+(UIImage*) originImage:(UIImage *)image scaleToSize:(CGSize)size;
+(UIImage*) originImage:(UIImage *)image maxSize:(CGSize)size;
+(UIImage*) convertPNGToJPG:(UIImage*)pngimage;
+(NSData*)  convertPNGToJPGData:(NSData*)pngimage;
+(UIImage*) cutFromView:(UIView*)view in:(CGRect)rect;
+(UIImage*) gausblur:(UIImage*)image;
@end
