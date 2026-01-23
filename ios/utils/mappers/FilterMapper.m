#import "FilterMapper.h"

@implementation FilterMapper

static Mapper _toModel = ^EMSRecommendationFilter *(NSDictionary *dictionary) {
  if (dictionary == nil) {
    return nil;
  }

  NSString *type = [dictionary objectForKey:@"type"];
  NSString *field = [dictionary valueForKey:@"field"];
  NSString *comparison = [dictionary objectForKey:@"comparison"];
  NSArray *expectations = [dictionary objectForKey:@"expectations"];

  if ([type isEqualToString:@"INCLUDE"]) {
    if ([comparison isEqualToString:@"IS"]) {
      return [EMSRecommendationFilter includeFilterWithField:field isValue:expectations[0]];
    } else if ([comparison isEqualToString:@"IN"]) {
      return [EMSRecommendationFilter includeFilterWithField:field inValues:expectations];
    } else if ([comparison isEqualToString:@"HAS"]) {
      return [EMSRecommendationFilter includeFilterWithField:field hasValue:expectations[0]];
    } else if ([comparison isEqualToString:@"OVERLAPS"]) {
      return [EMSRecommendationFilter includeFilterWithField:field overlapsValues:expectations];
    }
  } else if ([type isEqualToString:@"EXCLUDE"]) {
    if ([comparison isEqualToString:@"IS"]) {
      return [EMSRecommendationFilter excludeFilterWithField:field isValue:expectations[0]];
    } else if ([comparison isEqualToString:@"IN"]) {
      return [EMSRecommendationFilter excludeFilterWithField:field inValues:expectations];
    } else if ([comparison isEqualToString:@"HAS"]) {
      return [EMSRecommendationFilter excludeFilterWithField:field hasValue:expectations[0]];
    } else if ([comparison isEqualToString:@"OVERLAPS"]) {
      return [EMSRecommendationFilter excludeFilterWithField:field overlapsValues:expectations];
    }
  }

  return nil;
};

+ (Mapper)toModel {
  return _toModel;
}

@end
