#import <EmarsysSDK/EMSCartItem.h>

typedef id (^Mapper)(NSDictionary *dictionary);

@interface MapUtils : NSObject

+ (Mapper)toCartItemMapper;

@end
