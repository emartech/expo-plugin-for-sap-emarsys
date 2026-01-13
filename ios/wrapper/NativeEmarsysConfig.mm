#import <Foundation/Foundation.h>
#import <NativeEmarsys/NativeEmarsys.h>
#import <EmarsysSDK/Emarsys.h>
#import "StorageUtils.h"

@interface NativeEmarsysConfig : NSObject <NativeEmarsysConfigSpec>

@end

@implementation NativeEmarsysConfig

RCT_EXPORT_MODULE()

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const facebook::react::ObjCTurboModule::InitParams &)params {
  return std::make_shared<facebook::react::NativeEmarsysConfigSpecJSI>(params);
}

- (void)changeApplicationCode:(NSString *)applicationCode resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.config changeApplicationCode:applicationCode completionBlock:^(NSError * _Nullable error) {
      if (NULL != error) {
        reject(@"Error NativeEmarsysConfig", @"changeApplicationCode: ", error);
      } else {
        [StorageUtils setUserDefaultsString:(applicationCode ?: @"") forKey: @"applicationCode"];
        resolve(nil);
      }
    }];
  }
  @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)changeMerchantId:(NSString *)merchantId resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.config changeMerchantId:merchantId completionBlock:^(NSError * _Nullable error) {
      if (NULL != error) {
        reject(@"Error NativeEmarsysConfig", @"changeMerchantId: ", error);
      } else {
        [StorageUtils setUserDefaultsString:(merchantId ?: @"") forKey: @"merchantId"];
        resolve(nil);
      }
    }];
  }
  @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)getApplicationCode:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    NSString *applicationCode = [Emarsys.config applicationCode];
    resolve(applicationCode);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)getMerchantId:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    NSString *merchantId = [Emarsys.config merchantId];
    resolve(merchantId);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)getContactFieldId:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    NSNumber *contactFieldId = [Emarsys.config contactFieldId];
    resolve(contactFieldId);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)getClientId:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    NSString *clientId = [Emarsys.config clientId];
    resolve(clientId);
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

- (void)getLanguageCode:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    NSString *languageCode = [Emarsys.config languageCode];
    resolve(languageCode);
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
