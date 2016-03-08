//
//  BStoreService.h
//  Box
//
//  Created by FengLing on 16/1/7.
//  Copyright © 2016年 lk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BStoreService : NSObject

+ (instancetype)sharedStoreService;
- (BOOL)saveAccount:(NSString *)account  Password:(NSString *)password;
- (BOOL)updtePassword:(NSString *)pwd;
- (NSString *)Account;
- (NSString *)Password;
- (void)removeAccount;
- (void)removePassword;
- (void)removeAccountAndPassword;

@end
