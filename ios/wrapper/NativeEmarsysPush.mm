#import <EmarsysSDK/Emarsys.h>
#import <NativeEmarsys/NativeEmarsys.h>
#import "StringUtils.h"

#define NAME @"NativeEmarsysPush"

@interface NativeEmarsysPush : NSObject <NativeEmarsysPushSpec>

@end

@implementation NativeEmarsysPush

RCT_EXPORT_MODULE()

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const facebook::react::ObjCTurboModule::InitParams &)params {
  return std::make_shared<facebook::react::NativeEmarsysPushSpecJSI>(params);
}

- (void)setPushToken:(NSString *)pushToken resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    NSData *pushTokenData = [StringUtils dataWithDeviceToken:pushToken];
    [Emarsys.push setPushToken:pushTokenData completionBlock:^(NSError *error) {
      if (error == nil) {
        resolve(nil);
      } else {
        reject(NAME, @"setPushToken", error);
      }
    }];
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)clearPushToken:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.push clearPushTokenWithCompletionBlock:^(NSError *error) {
      if (error == nil) {
        resolve(nil);
      } else {
        reject(NAME, @"clearPushToken", error);
      }
    }];
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)getPushToken:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    NSData *pushTokenData = [Emarsys.push pushToken];
    NSString * pushToken = [StringUtils stringWithDeviceToken:pushTokenData];
    resolve(pushToken);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

@end
