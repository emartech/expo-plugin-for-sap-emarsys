#import <Foundation/Foundation.h>
#import <NativeEmarsys/NativeEmarsys.h>
#import <EmarsysSDK/Emarsys.h>
#import "StringUtils.h"

@interface NativeEmarsysPush : NSObject <NativeEmarsysPushSpec>

@end

@implementation NativeEmarsysPush
RCT_EXPORT_MODULE()

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const facebook::react::ObjCTurboModule::InitParams &)params {
  return std::make_shared<facebook::react::NativeEmarsysPushSpecJSI>(params);
}

- (void)setPushToken:(NSString *)pushToken resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    NSData *tokenData = [StringUtils dataWithString:pushToken];
    [Emarsys.push setPushToken:tokenData completionBlock:^(NSError * _Nullable error) {
      if (NULL != error) {
        reject(@"Error NativeEmarsysPush", @"setPushToken: ", error);
      } else {
        resolve(nil);
      }
    }];
  }
  @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)clearPushToken:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.push clearPushTokenWithCompletionBlock:^(NSError * _Nullable error) {
      if (NULL != error) {
        reject(@"Error NativeEmarsysPush", @"clearPushToken: ", error);
      } else {
        resolve(nil);
      }
    }];
  }
  @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)getPushToken:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    NSData *pushTokenData = [Emarsys.push pushToken];
    NSString * pushToken = [StringUtils stringWithData:pushTokenData];
    resolve(pushToken);
  }
  @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

@end
