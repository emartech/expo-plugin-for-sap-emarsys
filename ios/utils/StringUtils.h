#import <Foundation/Foundation.h>

@interface StringUtils : NSObject

+ (NSData *)dataWithString:(NSString *)deviceToken;
+ (NSString *)stringWithData:(NSData *)deviceToken;

@end
