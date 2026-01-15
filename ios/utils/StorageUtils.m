#import "StorageUtils.h"

#define STORE_NAME @"com.emarsys.reactnative"

@implementation StorageUtils

+ (NSString *)stringForKey:(NSString *)key {
  NSString *value = [self userDefaultsStringForKey:key] ?: [self infoPListStringForKey:key];
  return ![value isEqualToString:@""] ? value : nil;
}

+ (NSString *)userDefaultsStringForKey:(NSString *)key {
  return [[[NSUserDefaults alloc] initWithSuiteName:STORE_NAME] stringForKey:key];
}

+ (NSString *)infoPListStringForKey:(NSString *)key {
  return [[NSBundle mainBundle] objectForInfoDictionaryKey:[NSString stringWithFormat:@"%@.%@", STORE_NAME, key]];
}

+ (BOOL)infoPListBoolForKey:(NSString *)key {
  return [[[NSBundle mainBundle] objectForInfoDictionaryKey:[NSString stringWithFormat:@"%@.%@", STORE_NAME, key]] boolValue];
}

+ (EMSConfig *)getEMSConfig {
  return [EMSConfig makeWithBuilder:^(EMSConfigBuilder *builder) {
    [builder setMobileEngageApplicationCode:[self stringForKey:@"applicationCode"]];
    [builder setMerchantId:[self stringForKey:@"merchantId"]];
    if ([self infoPListBoolForKey:@"enableConsoleLogging"]) {
      [builder enableConsoleLogLevels:@[EMSLogLevel.trace, EMSLogLevel.debug, EMSLogLevel.info, EMSLogLevel.warn, EMSLogLevel.error, EMSLogLevel.basic]];
    }
    [builder setSharedKeychainAccessGroup:[self infoPListStringForKey:@"sharedKeychainAccessGroup"]];
  }];
}

+ (void)setUserDefaultsString:(NSString *)value forKey:(NSString *)key {
  [[[NSUserDefaults alloc] initWithSuiteName:STORE_NAME] setObject:value forKey:key];
}

@end
