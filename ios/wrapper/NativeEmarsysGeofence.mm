#import <EmarsysSDK/Emarsys.h>
#import <NativeEmarsys/NativeEmarsys.h>
#import "ArrayUtils.h"
#import "GeofenceMapper.h"

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
    reject(exception.name, exception.reason, nil);
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
    reject(exception.name, exception.reason, nil);
  }
}

- (void)disable:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.geofence disable];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)isEnabled:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    BOOL isEnabled = [Emarsys.geofence isEnabled];
    resolve(@(isEnabled));
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)setInitialEnterTriggerEnabled:(BOOL)enabled resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject {
  @try {
    Emarsys.geofence.initialEnterTriggerEnabled = enabled;
    resolve(nil);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)getRegisteredGeofences:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    NSArray *registeredGeofences = [Emarsys.geofence.registeredGeofences map:GeofenceMapper.toDictionary];
    resolve(registeredGeofences);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

@end
