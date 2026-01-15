#import "ArrayUtils.h"

@implementation ArrayUtils

+ (NSArray *)toArray:(NSArray *)array mapper:(Mapper)mapper {
  if (array == nil) {
    return nil;
  }

  NSMutableArray *_array = [NSMutableArray array];
  for (NSDictionary *dictionary in array) {
    id value = mapper(dictionary);

    if (value != nil) {
      [_array addObject:value];
    }
  }

  return _array;
}

@end
