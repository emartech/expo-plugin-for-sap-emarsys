#import <Foundation/Foundation.h>

@interface StringUtils : NSObject

+ (NSData *)dataWithDeviceToken:(NSString *)deviceToken;
+ (NSString *)stringWithDeviceToken:(NSData *)deviceToken;

@end
