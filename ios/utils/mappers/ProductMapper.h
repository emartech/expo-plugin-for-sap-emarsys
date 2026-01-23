#import <EmarsysSDK/EMSProduct.h>
#import "Mapper.h"

@interface ProductMapper : NSObject

+ (Mapper)toDictionary;
+ (EMSProduct *)toModel:(NSDictionary *)dictionary;

@end
