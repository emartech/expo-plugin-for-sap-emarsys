#import <EmarsysSDK/EMSLogic.h>
#import "ArrayUtils.h"
#import "CartItemMapper.h"

@interface LogicMapper : NSObject

+ (EMSLogic *)toModel:(NSDictionary *)dictionary;

@end
