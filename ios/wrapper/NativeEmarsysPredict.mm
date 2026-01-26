#import <EmarsysSDK/Emarsys.h>
#import <NativeEmarsys/NativeEmarsys.h>
#import "ArrayUtils.h"
#import "CartItemMapper.h"
#import "FilterMapper.h"
#import "LogicMapper.h"
#import "ProductMapper.h"

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
    [Emarsys.predict trackCartWithCartItems:[items map:CartItemMapper.toModel]];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)trackPurchase:(NSString *)orderId items:(NSArray *)items
  resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.predict trackPurchaseWithOrderId:orderId items:[items map:CartItemMapper.toModel]];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)trackItemView:(NSString *)itemId resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.predict trackItemViewWithItemId:itemId];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)trackCategoryView:(NSString *)categoryPath resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.predict trackCategoryViewWithCategoryPath:categoryPath];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)trackSearchTerm:(NSString *)searchTerm resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.predict trackSearchWithSearchTerm:searchTerm];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)trackTag:(NSString *)tag attributes:(NSDictionary * _Nullable)attributes
  resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.predict trackTag:tag withAttributes:attributes];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)recommendProducts:(NSDictionary *)logic filters:(NSArray * _Nullable)filters
  limit:(NSNumber *)limit availabilityZone:(NSString * _Nullable)availabilityZone
  resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.predict recommendProductsWithLogic:[LogicMapper toModel:logic]
      filters:[filters map:FilterMapper.toModel]
      limit:limit availabilityZone:availabilityZone
      productsBlock:^(NSArray<id<EMSProductProtocol>> *products, NSError *error) {
      if (error == nil) {
        NSArray *_products = [products map:ProductMapper.toDictionary];
        resolve(_products);
      } else {
        reject(NAME, @"recommendProducts", error);
      }
    }];
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)trackRecommendationClick:(NSDictionary *)product
  resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.predict trackRecommendationClick:[ProductMapper toModel:product]];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

@end
