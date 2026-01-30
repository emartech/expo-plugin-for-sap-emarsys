#import <EmarsysSDK/Emarsys.h>
#import <NativeEmarsys/NativeEmarsys.h>
#import "ArrayUtils.h"
#import "CartItemMapper.h"
#import "FilterMapper.h"
#import "LogicMapper.h"
#import "ProductMapper.h"
#import "WrapperUtils.h"

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
    reject(NAME, @"trackCart", [NSError errorWithException:exception]);
  }
}

- (void)trackPurchase:(NSString *)orderId items:(NSArray *)items
  resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.predict trackPurchaseWithOrderId:orderId items:[items map:CartItemMapper.toModel]];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(NAME, @"trackPurchase", [NSError errorWithException:exception]);
  }
}

- (void)trackItemView:(NSString *)itemId resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.predict trackItemViewWithItemId:itemId];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(NAME, @"trackItemView", [NSError errorWithException:exception]);
  }
}

- (void)trackCategoryView:(NSString *)categoryPath resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.predict trackCategoryViewWithCategoryPath:categoryPath];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(NAME, @"trackCategoryView", [NSError errorWithException:exception]);
  }
}

- (void)trackSearchTerm:(NSString *)searchTerm resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.predict trackSearchWithSearchTerm:searchTerm];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(NAME, @"trackSearchTerm", [NSError errorWithException:exception]);
  }
}

- (void)trackTag:(NSString *)tag attributes:(NSDictionary * _Nullable)attributes
  resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.predict trackTag:tag withAttributes:attributes];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(NAME, @"trackTag", [NSError errorWithException:exception]);
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
    reject(NAME, @"recommendProducts", [NSError errorWithException:exception]);
  }
}

- (void)trackRecommendationClick:(NSDictionary *)product
  resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.predict trackRecommendationClick:[ProductMapper toModel:product]];
    resolve(nil);
  } @catch (NSException *exception) {
    reject(NAME, @"trackRecommendationClick", [NSError errorWithException:exception]);
  }
}

@end
