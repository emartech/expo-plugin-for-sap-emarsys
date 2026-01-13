#import <Foundation/Foundation.h>

@interface PushTokenUtils : NSObject

+ (NSData *)dataWithDeviceToken:(NSString *)deviceToken;
+ (NSString *)stringWithDeviceToken:(NSData *)deviceToken;

@end
