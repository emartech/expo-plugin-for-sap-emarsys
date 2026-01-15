#import <Foundation/Foundation.h>

@interface NSString (RNEmarsys)

- (NSData *)deviceTokenData;

@end

@interface NSData (RNEmarsys)

- (NSString *)deviceTokenString;

@end
