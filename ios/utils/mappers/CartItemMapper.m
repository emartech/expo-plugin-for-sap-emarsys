#import "CartItemMapper.h"

@implementation CartItemMapper

static Mapper _toModel = ^EMSCartItem *(NSDictionary *dictionary) {
  if (dictionary == nil) {
    return nil;
  }

  return [EMSCartItem
    itemWithItemId:[dictionary objectForKey:@"itemId"]
    price:[[dictionary objectForKey:@"price"] doubleValue]
    quantity:[[dictionary objectForKey:@"quantity"] doubleValue]
  ];
};

+ (Mapper)toModel {
  return _toModel;
}

@end
