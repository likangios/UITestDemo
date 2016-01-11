//
//  BUntil.m
//  Box
//
//  Created by FengLing on 15/12/8.
//  Copyright © 2015年 lk. All rights reserved.
//

#import "BUntil.h"

@implementation BUntil

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

+(NSString *) randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

+(CGSize)CalSizeByString:(NSString *)str ForWidth:(CGFloat)width ForFont:(UIFont *)font
{
    if (!str.length) {
        return CGSizeZero;
    }
    CGSize constraint = CGSizeMake(width, 20000.0f);
    CGSize size;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        size = [str boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    }
    else
        size = [str sizeWithFont:font constrainedToSize:constraint];
    return size;
    
}

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    UIImage *img = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return img;
}
+(void)setRoundedView:(UIImageView *)roundedView
{
    CGFloat radius = roundedView.frame.size.width /2;
    roundedView.layer.cornerRadius = radius;
    roundedView.layer.masksToBounds = YES;
    roundedView.clipsToBounds = YES;
    roundedView.contentMode = UIViewContentModeScaleAspectFill;
    roundedView.layer.borderWidth = 0.5;
    roundedView.layer.borderColor = [UIColor whiteColor].CGColor;
}

//+ (NSString*)MD5:(NSString *) srcString
//{
//    // Create pointer to the string as UTF8
//    const char *ptr = [srcString UTF8String];
//    if( !ptr )
//        return nil;
//    
//    // Create byte array of unsigned chars
//    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
//    
//    // Create 16 byte MD5 hash value, store in buffer
//    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
//    
//    // Convert MD5 value in the buffer to NSString of hex values
//    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
//    {
//        [output appendFormat:@"%02x",md5Buffer[i]];
//    }
//    
//    return output;
//}
+(NSURL *) createTempImageUploadFile:(UIImage *) origin_upload_image
{
    NSURL *uploadFilePath = nil;
    
    NSString * random_string = [BUntil randomStringWithLength:32];
    NSString * strFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:
                              [NSString stringWithFormat: @"%@_%.0f.%@", random_string ,
                               [NSDate timeIntervalSinceReferenceDate] ,
                               @"jpg"]];
    
    if( [[NSFileManager defaultManager] fileExistsAtPath:strFilePath isDirectory:nil] )
    {
        [[NSFileManager defaultManager] removeItemAtPath:strFilePath error:nil];
    }
    
    NSData * binaryImageData = UIImageJPEGRepresentation(origin_upload_image , 0.7f);
    if( ![binaryImageData writeToFile:strFilePath atomically:YES] )
        return nil;
    uploadFilePath = [NSURL fileURLWithPath:strFilePath];
    return uploadFilePath;
}
+ (void)sortWithProperty:(NSString *)key ascending:(BOOL)asc with:(NSMutableArray *)array{
    // property 表示数据模型的 某个属性  YES  升序  NO 降序
    NSSortDescriptor *sordescriptor = [[NSSortDescriptor alloc]initWithKey:key ascending:asc];
    NSArray *resultArr = [[NSArray alloc]initWithObjects:&sordescriptor count:1 ];
    [array sortUsingDescriptors:resultArr];
}
+(UIView *) showErrorAlertViewWithMessage:(NSString *) msg Delegate:(id) delegate
{
    return  [BUntil showAlertViewTitle:@"Oops!" Message:msg Delegate:delegate];
}

+(UIView *) showAlertViewTitle:(NSString *) title Message:(NSString *) msg Delegate:(id) delegate
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title
                                                         message:msg
                                                        delegate:delegate
                                               cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                               otherButtonTitles:nil];
    [alertView show];
    return alertView;
}

+(UIView *) showHttprequestErrorAlertViewWithDelegate:(id) delegate
{
    return [BUntil showAlertViewTitle:@"Oops!"
                              Message:@"request error"
                             Delegate:delegate];
}

+(MBProgressHUD *) showHttprequestErrorHUDViewAtView:(UIView *) view
{
    return [self showErrorHUDViewAtView:view WithTitle:@"send request faild."];
}

+(MBProgressHUD *) showErrorHUDViewAtView:(UIView *) view WithTitle:(NSString *) title
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = title;
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:2];
    return hud;
}
+ (void)showHUDAddedTo:(UIView *)view{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}
+ (void)hideAllHUDsForView:(UIView *)view{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}
+ (BOOL)checkPhoneNumInput:(NSString *)phone{
    
    NSString * MOBILE = @"^[1][3,4,5,7,8][0-9]{9}$";
    
    NSPredicate *regexTestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    BOOL res = [regexTestmobile evaluateWithObject:phone];
    
    return res;
}
@end
