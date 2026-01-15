#import "LogicMapper.h"

@implementation LogicMapper

+ (EMSLogic *)toModel:(NSDictionary *)dictionary {
  if (dictionary == nil) {
    return nil;
  }

  NSString *name = [dictionary objectForKey:@"name"];
  NSString *query = [dictionary valueForKey:@"query"];
  NSArray *cartItems = [dictionary objectForKey:@"cartItems"];
  NSArray *variants = [dictionary objectForKey:@"variants"];

  if ([name isEqualToString:@"SEARCH"]) {
    return [EMSLogic searchWithSearchTerm:query];
  } else if ([name isEqualToString:@"CART"]) {
    return [EMSLogic cartWithCartItems:[cartItems map:CartItemMapper.toModel]];
  } else if ([name isEqualToString:@"RELATED"]) {
    return [EMSLogic relatedWithViewItemId:query];
  } else if ([name isEqualToString:@"CATEGORY"]) {
    return [EMSLogic categoryWithCategoryPath:query];
  } else if ([name isEqualToString:@"ALSO_BOUGHT"]) {
    return [EMSLogic alsoBoughtWithViewItemId:query];
  } else if ([name isEqualToString:@"POPULAR"]) {
    return [EMSLogic popularWithCategoryPath:query];
  } else if ([name isEqualToString:@"PERSONAL"]) {
    return [EMSLogic personalWithVariants:variants];
  } else if ([name isEqualToString:@"HOME"]) {
    return [EMSLogic homeWithVariants:variants];
  }

  return nil;
}

@end
