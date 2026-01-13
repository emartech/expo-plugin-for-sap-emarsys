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

@end
