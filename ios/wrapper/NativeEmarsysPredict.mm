#import <EmarsysSDK/Emarsys.h>
#import <NativeEmarsys/NativeEmarsys.h>
#import "ArrayUtils.h"
#import "MapUtils.h"

#define NAME @"NativeEmarsysPredict"

@interface NativeEmarsysPredict : NSObject <NativeEmarsysPredictSpec>

@end

@implementation NativeEmarsysPredict

RCT_EXPORT_MODULE()

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const facebook::react::ObjCTurboModule::InitParams &)params {
  return std::make_shared<facebook::react::NativeEmarsysPredictSpecJSI>(params);
}

- (void)trackCart:(NSArray *)items resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.predict trackCartWithCartItems:[ArrayUtils toArray:items mapper: [MapUtils toCartItemMapper]]];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)trackPurchase:(NSString *)orderId items:(NSArray *)items
  resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    // [Emarsys.predict ];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)trackItemView:(NSString *)itemId resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    // [Emarsys.predict ];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)trackCategoryView:(NSString *)categoryPath resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    // [Emarsys.predict ];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)trackSearchTerm:(NSString *)searchTerm resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    // [Emarsys.predict ];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)trackTag:(NSString *)tag attributes:(NSDictionary * _Nullable)attributes
  resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    // [Emarsys.predict ];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)recommendProducts:(JS::NativeEmarsysPredict::Logic &)logic filters:(NSArray * _Nullable)filters
  limit:(NSNumber *)limit availabilityZone:(NSString * _Nullable)availabilityZone
  resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    // [Emarsys.predict ];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)trackRecommendationClick:(JS::NativeEmarsysPredict::Product &)product
  resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    // [Emarsys.predict ];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

@end
