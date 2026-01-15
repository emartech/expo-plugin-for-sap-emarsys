#import "ArrayUtils.h"

@implementation NSArray (RNEmarsys)

- (NSArray *)map:(Mapper)mapper {
  if (self == nil) {
    return nil;
  }

  NSMutableArray *array = [NSMutableArray array];
  for (id object in self) {
    id value = mapper(object);

    if (value != nil) {
      [array addObject:value];
    }
  }

  return array;
}

@end
