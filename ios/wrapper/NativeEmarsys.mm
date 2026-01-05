#import <Foundation/Foundation.h>
#import <NativeEmarsys/NativeEmarsys.h>
#import <EmarsysSDK/Emarsys.h>

@interface NativeEmarsys : NSObject <NativeEmarsysSpec>

@end

@implementation NativeEmarsys

RCT_EXPORT_MODULE()

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const facebook::react::ObjCTurboModule::InitParams &)params {
  return std::make_shared<facebook::react::NativeEmarsysSpecJSI>(params);
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
