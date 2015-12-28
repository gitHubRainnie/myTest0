//
//  UIImage+Helper.m
//  shouying
//
//  Created by lemoon on 15/10/9.
//  Copyright © 2015年 BeiJingShouYingShiGuangTC. All rights reserved.
//

#import "UIImage+Helper.h"
#import <CoreGraphics/CoreGraphics.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
@implementation UIImage(Helper)

+(UIImage*) originImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* imagescale = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imagescale;
}
+(UIImage*) originImage:(UIImage *)image maxSize:(CGSize)size
{
    CGSize sizeorig = image.size;
    if (sizeorig.width < size.width && sizeorig.height < size.height) {
        return image;
    }else{
        float scalew = sizeorig.width / size.width;
        float scaleh = sizeorig.height / size.height;
        float scale = MAX(scalew, scaleh);
        sizeorig = CGSizeMake(sizeorig.width / scale, sizeorig.height / scale);
        return [UIImage originImage:image scaleToSize:sizeorig];
    }
}
+(UIImage*)convertPNGToJPG:(UIImage*)pngimage
{
    NSData* datans = UIImagePNGRepresentation(pngimage);
    if (datans == nil) {
        return nil;
    }
    CFDataRef cfdata = (__bridge CFDataRef)datans;
    UIImage* imagejpg;
    CGImageSourceRef source = CGImageSourceCreateWithData(cfdata, nil);
    size_t count = CGImageSourceGetCount(source);
    for (size_t i = 0; i < count; i ++) {
        CGImageRef cgImage = CGImageSourceCreateImageAtIndex(source, i, NULL);
        if (!cgImage) {continue;}
        CFMutableDataRef data = CFDataCreateMutable(kCFAllocatorDefault, 0);
        
        CGImageDestinationRef dataDest = CGImageDestinationCreateWithData(data, kUTTypeJPEG, 1, NULL);
        
        CGImageDestinationAddImage(dataDest, cgImage, NULL);
        
        CGImageDestinationFinalize(dataDest);
        
        NSData* datansn = (__bridge NSData*)data;
        
        imagejpg = [UIImage imageWithData:datansn];
        CFRelease(data);
        CFRelease(dataDest);
        CFRelease(cgImage);
        break;
    }
    CFRelease(cfdata);
    return imagejpg;
}
+(NSData*)convertPNGToJPGData:(NSData*)datans
{
    if (datans == nil) {
        return nil;
    }
    NSData* datares = nil;
    CFDataRef cfdata = (__bridge CFDataRef)datans;
    CGImageSourceRef source = CGImageSourceCreateWithData(cfdata, nil);
    size_t count = CGImageSourceGetCount(source);
    for (size_t i = 0; i < count; i ++) {
        CGImageRef cgImage = CGImageSourceCreateImageAtIndex(source, i, NULL);
        if (!cgImage) {continue;}
        CFMutableDataRef data = CFDataCreateMutable(kCFAllocatorDefault, 0);
        
        CGImageDestinationRef dataDest = CGImageDestinationCreateWithData(data, kUTTypeJPEG, 1, NULL);
        
        CGImageDestinationAddImage(dataDest, cgImage, NULL);
        
        CGImageDestinationFinalize(dataDest);
        
        datares = (__bridge_transfer NSData*)data;
        
        CFRelease(dataDest);
        CFRelease(cgImage);
        break;
    }
    CFRelease(cfdata);
    return datares;
}
+(void) renderView:(UIView*)view incontext:(CGContextRef) context
{
    NSArray* subviews = view.subviews;
    if (subviews.count > 0) {
        for (UIView* subv in subviews) {
            [UIImage renderView:subv incontext:context];
            [subv.layer renderInContext:context];
        }
    }else{
        [view.layer renderInContext:context];
    }
}
+(UIImage*) cutFromView:(UIView*)view in:(CGRect)rect{
    
    UIGraphicsBeginImageContext(view.frame.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    UIRectClip(rect);
    
    [view.layer renderInContext:context];
//    [UIImage renderView:view incontext:context];
    
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
+(UIImage*) gausblur:(UIImage*)image
{
    UIImage* imageblur;
    CIContext* context = [CIContext contextWithOptions:nil];
    CIImage* inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:3.0] forKey:@"inputRadius"];
    CIImage* result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    imageblur = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return imageblur;
}
@end
