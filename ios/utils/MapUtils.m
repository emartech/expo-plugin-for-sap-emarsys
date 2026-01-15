#import "MapUtils.h"

@implementation MapUtils

static Mapper _toCartItemMapper = ^(NSDictionary *dictionary) {
  if (dictionary == nil) {
    return (EMSCartItem *)nil;
  }

  return [[EMSCartItem alloc]
    initWithItemId:[dictionary objectForKey:@"itemId"]
    price:[[dictionary objectForKey:@"price"] doubleValue]
    quantity:[[dictionary objectForKey:@"quantity"] doubleValue]
  ];
};

+ (Mapper)toCartItemMapper {
  return _toCartItemMapper;
}

@end
