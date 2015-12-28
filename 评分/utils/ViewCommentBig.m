//
//  ViewCommentBig.m
//  shouying
//
//  Created by lemoon on 15/10/9.
//  Copyright © 2015年 BeiJingShouYingShiGuangTC. All rights reserved.
//

#import "ViewCommentBig.h"
#import "AppDelegate.h"
//#import "MacroHeader.h"
#import "UIView+Help.h"
#import "UIImage+Helper.h"
static ViewCommentBig* viewComment;

enum TAG{
    TAG_IMAGE_BLACK = 200,TAG_IMAGE_WHITE = 300
};
@interface ViewCommentBig(){
    int scoreOld;
    BOOL canChanged;
}
@property(assign, nonatomic) SEL fun;
@property(weak, nonatomic) id target;
@property (weak, nonatomic) IBOutlet UIView *viewbg;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewbg;
@property (weak, nonatomic) IBOutlet UILabel *labelscore;
@property (weak, nonatomic) IBOutlet UIImageView *starb1;
@property (weak, nonatomic) IBOutlet UIImageView *starb2;
@property (weak, nonatomic) IBOutlet UIImageView *starb3;
@property (weak, nonatomic) IBOutlet UIImageView *starb4;
@property (weak, nonatomic) IBOutlet UIImageView *starb5;
@property (weak, nonatomic) IBOutlet UIImageView *starw1;
@property (weak, nonatomic) IBOutlet UIImageView *starw2;
@property (weak, nonatomic) IBOutlet UIImageView *starw3;
@property (weak, nonatomic) IBOutlet UIImageView *starw4;
@property (weak, nonatomic) IBOutlet UIImageView *starw5;

@end

@implementation ViewCommentBig

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(void)showInView:(UIView*)view target:(nullable id)target changed:(nullable SEL)scoreChanged
{
    if (viewComment == nil) {
        
        
        
        
        
        //ceshi发大发大
        view = [AppDelegate getCurrentVC].view;
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"ViewCommentBig" owner:nil options:nil];
        viewComment = (ViewCommentBig*) [nib lastObject];
        viewComment.target = target;
        viewComment.fun = scoreChanged;
        [view addSubview:viewComment];
        [view bringSubviewToFront:viewComment];
        [viewComment initView];
    }
}
//+(void)showModal:( nullable id)target changed:(nullable SEL)scoreChanged
//{
//    if (viewComment == nil) {
//        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"ViewCommentBig" owner:nil options:nil];
//        viewComment = (ViewCommentBig*) [nib lastObject];
//        viewComment.target = target;
//        viewComment.fun = scoreChanged;
//        [[AppDelegate getCurrentVC].view addSubview:viewComment];
//        [[AppDelegate getCurrentVC].view bringSubviewToFront:viewComment];
//        [viewComment initView];
//    }
//    
//}
-(void) initView
{
//    [self performSelectorInBackground:@selector(addBack) withObject:nil];
    scoreOld = 10;
    self.backgroundColor = [UIColor clearColor];
    self.viewbg.backgroundColor = [UIColor clearColor];
    canChanged = YES;
    float dis = 29;

    float disw = 42;
    float w = self.superview.frame.size.width;
    float h = self.superview.frame.size.height;
    self.frame = CGRectMake(0, 0, w, h);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    self.viewbg.frame = CGRectMake(dis, h * 0.5, w - dis * 2, 90);
    [self addTapGestureView:self];
    self.labelscore.frame = CGRectMake(0, 0, w - dis * 2, 30);
    self.labelscore.text = [NSString stringWithFormat:@"10分 哎哟不错哦"];

    self.imageviewbg.frame = CGRectMake(0, 0, w - dis * 2, 90);
    float starstartx = (w - dis * 2 - disw * 5) * 0.5;
    for (int i = 0; i <  5; i ++) {
        {
            UIImageView* view = (UIImageView* )[self.viewbg viewWithTag:i + TAG_IMAGE_BLACK];
            view.frame = CGRectMake(starstartx + disw * i, 31, disw, disw);
            [self addTapGestureView:view];
        }
        {
            UIImageView* view = (UIImageView* )[self.viewbg viewWithTag:i + TAG_IMAGE_WHITE];
            view.frame = CGRectMake(starstartx + disw * i, 31, disw, disw);
            [self addTapGestureView:view];
        }
    }
    [self addBack];
}
-(void) addBack
{

    float w = self.superview.frame.size.width;
    float h = self.superview.frame.size.height;
    float dis = 29;
    UIView* targetview = self.superview.superview;
    CGRect rect = self.frame;
    self.frame = CGRectMake(10000, 0, rect.size.width, rect.size.height);

    UIImage* image = [UIImage cutFromView:targetview in: CGRectMake(0, 0, targetview.frame.size.width, targetview.frame.size.height)];
    image = [UIImage gausblur:image];
    self.frame = rect;

    UIImageView* imageview = [[UIImageView alloc] initWithFrame:CGRectMake(-dis, - h * 0.5 , targetview.frame.size.width, targetview.frame.size.height)];
    imageview.image = image;
    
    
    UIView* bbb = [[UIView alloc] initWithFrame:CGRectMake(dis, h * 0.5, w - dis * 2, 90)];
//    self.viewbg.backgroundColor = [UIColor blueColor];
    [bbb addSubview:imageview];
    bbb.clipsToBounds = YES;
    
    [self addSubview:bbb];
    [self bringSubviewToFront:self.viewbg];
}
-(void) addTapGestureView:(UIView*)viewtap
{
    UITapGestureRecognizer* tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [viewtap addGestureRecognizer:tapgesture];
    viewtap.userInteractionEnabled = YES;
    viewtap.multipleTouchEnabled = YES;
}
- (void)handleTap:(UITapGestureRecognizer*)recognizer
{
    if (canChanged) {
        canChanged = NO;
        
        UIView* view = recognizer.view;
        if (self.target != nil && [self.target respondsToSelector:self.fun] && view.tag != 50 ) {
            NSString* str = [NSString stringWithFormat:@"%d", scoreOld];
            IMP imp = [_target methodForSelector:_fun];
            void (*func)(id, SEL, NSString*) = (void*)imp;
            func(_target, _fun, str);
        }
        if (view.tag >= TAG_IMAGE_WHITE) {
            [self updateScore:(int)view.tag - TAG_IMAGE_WHITE];
        }else if(view.tag >= TAG_IMAGE_BLACK){
            [self updateScore:(int)view.tag - TAG_IMAGE_BLACK];
        }
        [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
            self.layer.opacity = 0.5;
            self.transform = CGAffineTransformScale(self.transform, 2.5, 2.5);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            viewComment = nil;
        }];
    }
}
- (void) updateScore:(int)score
{
    scoreOld = (score + 1 )*2;
    self.labelscore.text = [NSString stringWithFormat:@"%d 哎哟不错", scoreOld];
    for (int i = 0; i < 5; i ++) {
        UIImageView* view = (UIImageView* )[self.viewbg viewWithTag:i + TAG_IMAGE_WHITE];
        view.hidden = i > score;
    }
    
}
@end
