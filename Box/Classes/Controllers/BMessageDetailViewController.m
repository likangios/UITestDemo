//
//  BMessageDetailViewController.m
//  Box
//
//  Created by 哈哈哈 on 16/1/19.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BMessageDetailViewController.h"

@interface BMessageDetailViewController ()<UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) IBOutlet UIWebView *webView;

@end

@implementation BMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavBar];
    [self addRedBackItem];
    self.barTitle = @"消息详情";
    self.webView.scrollView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(scrollView.contentOffset.y>0){
        _img_shadowView.hidden = NO;
    }else{
        _img_shadowView.hidden = YES;
        
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{

    [[NSNotificationCenter defaultCenter] postNotificationName:KREADMESSAGENOTIFICATION object:nil];

}
#pragma mark UIScrollView
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    _img_shadowView.hidden = NO;
//}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    _img_shadowView.hidden = YES;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
