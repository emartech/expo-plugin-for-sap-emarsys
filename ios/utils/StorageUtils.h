#import <EmarsysSDK/EMSConfig.h>
#import <EmarsysSDK/EMSLogLevel.h>

@interface StorageUtils : NSObject

+ (NSString *)stringForKey:(NSString *)key;
+ (NSString *)userDefaultsStringForKey:(NSString *)key;
+ (NSString *)infoPListStringForKey:(NSString *)key;
+ (EMSConfig *)getEMSConfig;
+ (void)setUserDefaultsString:(NSString *)value forKey:(NSString *)key;

@end
