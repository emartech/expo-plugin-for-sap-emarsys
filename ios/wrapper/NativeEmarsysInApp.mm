#import <EmarsysSDK/Emarsys.h>
#import <NativeEmarsys/NativeEmarsys.h>
#import "StringUtils.h"

#define NAME @"NativeEmarsysInApp"

@interface NativeEmarsysInApp : NSObject <NativeEmarsysInAppSpec>

@end

@implementation NativeEmarsysInApp

RCT_EXPORT_MODULE()

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const facebook::react::ObjCTurboModule::InitParams &)params {
  return std::make_shared<facebook::react::NativeEmarsysInAppSpecJSI>(params);
}

- (void)pause:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.inApp pause];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)resume:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.inApp resume];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)isPaused:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    BOOL isPaused = [Emarsys.inApp isPaused];
    resolve(@(isPaused));
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

@end
