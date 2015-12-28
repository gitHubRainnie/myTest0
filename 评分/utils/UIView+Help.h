//
//  UIView+Help.h
//  shouying
//
//  Created by lemoon on 15/9/22.
//  Copyright (c) 2015年 BeiJingShouYingShiGuangTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(Help)
//-(UIImageView*) addImageWithUrl:(NSString*) imageurl placeholder:(NSString*)imagename frame:(CGRect)rect fillmode:(UIViewContentMode)mode;
-(UIImageView*) addImage:(NSString*) imagename frame:(CGRect)rect fillmode:(UIViewContentMode)mode;
-(UIImageView*) addImage:(NSString *)imagename center:(CGPoint)pos size:(CGSize)size fillmode:(UIViewContentMode)mode;
-(UILabel*) addLabel:(NSString*)text leftCenter:(CGPoint)pos fontsize:(int)fsize;
-(void) addLine:(CGRect)rect;

@end
