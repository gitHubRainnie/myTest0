//
//  ViewController.m
//  评分
//
//  Created by 北京首映时光科技有限公司 on 15/10/20.
//  Copyright (c) 2015年 BeiJingShouYingShiGuangTC. All rights reserved.
//

#import "ViewController.h"
#import "ViewCommentBig.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click:(id)sender {
    [ViewCommentBig showInView:self.view target:self changed:@selector(onScoreChanged:)];

}

-(void) onScoreChanged:(NSString*)score
{
    
}

@end
