//
//  ViewController.m
//  Box
//
//  Created by FengLing on 15/12/8.
//  Copyright © 2015年 lk. All rights reserved.
//

#import "ViewController.h"

#import "AppDelegate.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = (NSString *)NSStringFromClass([self class]);
    
   __block int a = 10;
    
    void(^printA)(void) = ^void(){
        a = 20;
    };
    a = 15;
    printA();
    NSLog(@"a %d",a);
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)mainBtn:(id)sender {
    
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [appdele OnSignInSuccessful:@"username" WithPassword:@"password"];
    
}
- (IBAction)welcomBtn:(id)sender {
    
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [appdele OnSignoutSuccessful];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
