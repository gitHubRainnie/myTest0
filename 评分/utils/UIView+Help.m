//
//  UIView+Help.m
//  shouying
//
//  Created by lemoon on 15/9/22.
//  Copyright (c) 2015年 BeiJingShouYingShiGuangTC. All rights reserved.
//

#import "UIView+Help.h"
//#import "UIImageView+AFNetworking.h"

@implementation UIView(Help)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//-(UIImageView*) addImageWithUrl:(NSString*) imageurl  placeholder:(NSString*)imagename frame:(CGRect)rect fillmode:(UIViewContentMode)mode
//{
//
//    UIImageView* imageview = [[UIImageView alloc] initWithFrame:rect];
//    [imageview setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:imagename]];
//    imageview.contentMode = mode;
////    [self addSubview:imageview];
//    return imageview;
//}
-(UIImageView*) addImage:(NSString*) imagename frame:(CGRect)rect fillmode:(UIViewContentMode)mode
{
    UIImage* image = [UIImage imageNamed:imagename];
    UIImageView* imageview = [[UIImageView alloc] initWithFrame:rect];
    imageview.image = image;
    imageview.contentMode = mode;
//    [self addSubview:imageview];
    return imageview;
}
-(UIImageView*) addImage:(NSString *)imagename center:(CGPoint)pos size:(CGSize)size fillmode:(UIViewContentMode)mode
{
    UIImage* image = [UIImage imageNamed:imagename];
    CGRect rect = CGRectMake(pos.x - size.width * 0.5, pos.y - size.height, size.width, size.height);
    UIImageView* imageview = [[UIImageView alloc] initWithFrame:rect];
    imageview.image = image;
    imageview.contentMode = mode;
//    [self addSubview:imageview];
    return imageview;
}
-(UILabel*) addLabel:(NSString*)text leftCenter:(CGPoint)pos fontsize:(int)fsize
{
    UILabel*label = [[UILabel alloc] initWithFrame:CGRectMake(pos.x, pos.y - fsize * 0.5, text.length * fsize, fsize)];
    label.text = text;
//    [self addSubview:label];
    return label;
}
-(void) addLine:(CGRect)rect
{
    UIView* view = [[UIView alloc] initWithFrame:rect];
    [self addSubview:view];
}

@end
