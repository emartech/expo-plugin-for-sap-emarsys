#import <EmarsysSDK/Emarsys.h>
#import <NativeEmarsys/NativeEmarsys.h>
#import "ArrayUtils.h"
#import "GeofenceMapper.h"
#import "WrapperUtils.h"

#define NAME @"NativeEmarsysGeofence"

@interface NativeEmarsysGeofence : NSObject <NativeEmarsysGeofenceSpec>

@end

@implementation NativeEmarsysGeofence

RCT_EXPORT_MODULE()

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const facebook::react::ObjCTurboModule::InitParams &)params {
  return std::make_shared<facebook::react::NativeEmarsysGeofenceSpecJSI>(params);
}

- (void)requestAlwaysAuthorization:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.geofence requestAlwaysAuthorization];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(NAME, @"requestAlwaysAuthorization", [NSError errorWithException:exception]);
  }
}

- (void)enable:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.geofence enableWithCompletionBlock:^(NSError *error) {
      if (error == nil) {
        resolve(nil);
      } else {
        reject(NAME, @"enable", error);
      }
    }];
  } @catch (NSException *exception) {
    reject(NAME, @"enable", [NSError errorWithException:exception]);
  }
}

- (void)disable:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.geofence disable];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(NAME, @"disable", [NSError errorWithException:exception]);
  }
}

- (void)isEnabled:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    BOOL isEnabled = [Emarsys.geofence isEnabled];
    resolve(@(isEnabled));
  } @catch (NSException *exception) {
    reject(NAME, @"isEnabled", [NSError errorWithException:exception]);
  }
}

- (void)setInitialEnterTriggerEnabled:(BOOL)enabled resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    Emarsys.geofence.initialEnterTriggerEnabled = enabled;
    resolve(nil);
  } @catch (NSException *exception) {
    reject(NAME, @"setInitialEnterTriggerEnabled", [NSError errorWithException:exception]);
  }
}

- (void)getRegisteredGeofences:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    NSArray *registeredGeofences = [Emarsys.geofence.registeredGeofences map:GeofenceMapper.toDictionary];
    resolve(registeredGeofences);
  } @catch (NSException *exception) {
    reject(NAME, @"getRegisteredGeofences", [NSError errorWithException:exception]);
  }
}

@end
