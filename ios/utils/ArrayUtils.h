#import "MapUtils.h"

@interface ArrayUtils : NSObject

+ (NSArray *)toArray:(NSArray *)array mapper:(Mapper)mapper;

@end
