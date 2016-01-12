//
//  BTestVC.m
//  Box
//
//  Created by FengLing on 16/1/12.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BTestVC.h"

@interface BTestVC ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrllowWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageviewWidth;
@property (nonatomic,strong) IBOutlet BCustomButton *testBtn;
@property (nonatomic,strong) IBOutlet UIPageControl *pageControl;


@end

@implementation BTestVC

- (void)viewDidLoad{
    [super viewDidLoad];
    _scrllowWidth.constant = ScreenWidth*3;
    _imageviewWidth.constant = ScreenWidth;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    _testBtn.enabled = YES;
    
}

- (IBAction)btnclick:(id)sender{
    
    _testBtn.enabled = NO;
    
    NSLog(@"------%@",sender);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrol.content %f",scrollView.contentOffset.x);
    _pageControl.currentPage = scrollView.contentOffset.x/ScreenWidth;
}
@end
