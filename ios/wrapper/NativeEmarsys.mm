#import <EmarsysSDK/Emarsys.h>
#import <NativeEmarsys/NativeEmarsys.h>
#import "EventUtils.h"

@interface NativeEmarsys : NativeEmarsysSpecBase <NativeEmarsysSpec>

@end

@implementation NativeEmarsys

RCT_EXPORT_MODULE()

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const facebook::react::ObjCTurboModule::InitParams &)params {
  return std::make_shared<facebook::react::NativeEmarsysSpecJSI>(params);
}

- (void)setEventHandler:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  [EventUtils setEventHandler:^(NSString *eventName, NSDictionary<NSString *, id> *payload) {
    [self emitOnEvent:@{@"name": eventName, @"payload": payload}];
  }];
  resolve(nil);
}

- (void)getClientId:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    NSString *clientId = [Emarsys.config clientId];
    resolve(clientId);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)getSdkVersion:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    NSString *sdkVersion = [Emarsys.config sdkVersion];
    resolve(sdkVersion);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

@end
