//
//  BQRCodeViewController.m
//  Box
//
//  Created by FengLing on 16/1/4.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BQRCodeViewController.h"
#import "Preview.h" 

#import <AVFoundation/AVFoundation.h>

@interface BQRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    Preview *_preview;
}
@property (weak, nonatomic) IBOutlet UIView *viewPreview;

@property (strong, nonatomic) UIView *boxView;



@property (nonatomic) BOOL isReading;

-(BOOL)startReading;
-(void)stopReading;

//捕捉会话
@property (nonatomic, strong) AVCaptureSession *captureSession;
//展示layer
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@end

@implementation BQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRedBackItem];
    _captureSession = nil;
    _isReading = NO;
    [self performSelector:@selector(startReadCode) withObject:nil afterDelay:0.2];
}
- (void)awakeFromNib{
    [super awakeFromNib];
//    [self initAVCaptureSession];
}
- (void)startReadCode{
    [self startReading];
}
- (BOOL)startReading {
    NSError *error;
    
    //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //2.用captureDevice创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    //3.创建媒体数据输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    
    //4.实例化捕捉会话
    _captureSession = [[AVCaptureSession alloc] init];
    
    //4.1.将输入流添加到会话
    [_captureSession addInput:input];
    
    //4.2.将媒体输出流添加到会话中
    [_captureSession addOutput:captureMetadataOutput];
    
    //5.创建串行队列，并加媒体输出流添加到队列当中
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    //5.1.设置代理
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    //5.2.设置输出媒体数据类型为QRCode
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    //6.实例化预览图层
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    //7.设置预览图层填充方式
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //8.设置图层的frame
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    //9.将图层添加到预览view的图层上
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    //10.设置扫描范围
    captureMetadataOutput.rectOfInterest = CGRectMake(0.2f, 0.2f, 0.8f, 0.8f);
//    扫描框
    _preview = [Preview loadSelfWithNibOwner:self];
    _preview.frame = _viewPreview.bounds;
    [_viewPreview addSubview:_preview];
    //10.开始扫描
    [_captureSession startRunning];
    return YES;
}
- (void)startStopReading:(id)sender {
    if (!_isReading) {
        if ([self startReading]) {
        }
    }
    else{
        [self stopReading];
    }
    _isReading = !_isReading;
}
-(void)stopReading{
    [_captureSession stopRunning];
    _captureSession = nil;
    [_videoPreviewLayer removeFromSuperlayer];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    DDLogError(@"metadataObjects -- %@",metadataObjects);
    //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        //判断回传的数据类型
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            _isReading = NO;
            NSLog(@" metadataObj %@",[metadataObj stringValue]);
        }
    }
}
- (BOOL)shouldAutorotate
{
    return NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_preview removeFromSuperview];
}
@end
