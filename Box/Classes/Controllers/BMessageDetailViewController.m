//
//  BMessageDetailViewController.m
//  Box
//
//  Created by 哈哈哈 on 16/1/19.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BMessageDetailViewController.h"

@interface BMessageDetailViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) IBOutlet UIWebView *webView;

@end

@implementation BMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavBar];
    [self addRedBackItem];
    self.barTitle = @"消息详情";
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{

    [[NSNotificationCenter defaultCenter] postNotificationName:KREADMESSAGENOTIFICATION object:nil];

}
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
