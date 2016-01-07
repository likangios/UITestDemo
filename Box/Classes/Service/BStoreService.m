//
//  BStoreService.m
//  Box
//
//  Created by FengLing on 16/1/7.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BStoreService.h"
#import <UICKeyChainStore.h>
@implementation BStoreService
+ (instancetype)sharedStoreService{
    static dispatch_once_t once_t;
    static BStoreService *storeService = nil;
    dispatch_once(&once_t, ^{
        storeService = [[BStoreService alloc]init];
    });
    return storeService;
}
- (BOOL)saveAccount:(NSString *)account  Password:(NSString *)password{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:KCFBundleName];
    if (![keychain setString:account forKey:(__bridge id)kSecAttrAccount]) {
        return NO;
    }
    if (![keychain setString:password forKey:(__bridge id)kSecValueData]) {
        return NO;
    }
    return YES;
}
- (NSString *)Account{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:KCFBundleName];
    return keychain[(__bridge id)kSecAttrAccount];
}
- (NSString *)Password{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:KCFBundleName];
    return keychain[(__bridge id)kSecValueData];
}
- (void)removeAccount{
        UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:KCFBundleName];
    keychain[(__bridge id)kSecAttrAccount] = nil;
}
- (void)removeAccountAndPassword{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:KCFBundleName];
    keychain[(__bridge id)kSecAttrAccount] = nil;
    keychain[(__bridge id)kSecValueData] = nil;
}
@end
