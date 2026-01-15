#import "ProductMapper.h"
#import "EMSProduct+Emarsys.h"

@implementation ProductMapper

static Mapper _toDictionary = ^NSDictionary *(EMSProduct *product) {
  NSMutableDictionary<NSString *, NSObject *> *dictionary = [NSMutableDictionary dictionary];
  dictionary[@"productId"] = product.productId;
  dictionary[@"title"] = product.title;
  dictionary[@"linkUrl"] = product.linkUrl.absoluteString;
  dictionary[@"feature"] = product.feature;
  dictionary[@"cohort"] = product.cohort;
  dictionary[@"customFields"] = product.customFields;
  dictionary[@"imageUrl"] = product.imageUrl.absoluteString;
  dictionary[@"zoomImageUrl"] = product.zoomImageUrl.absoluteString;
  dictionary[@"categoryPath"] = product.categoryPath;
  dictionary[@"available"] = product.available;
  dictionary[@"productDescription"] = product.productDescription;
  dictionary[@"price"] = product.price;
  dictionary[@"msrp"] = product.msrp;
  dictionary[@"album"] = product.album;
  dictionary[@"actor"] = product.actor;
  dictionary[@"artist"] = product.artist;
  dictionary[@"author"] = product.author;
  dictionary[@"brand"] = product.brand;
  dictionary[@"year"] = product.year;

  return dictionary;
};

+ (Mapper)toDictionary {
  return _toDictionary;
}

+ (EMSProduct *)toModel:(NSDictionary *)dictionary {
  if (dictionary == nil) {
    return nil;
  }

  return [EMSProduct makeWithBuilder:^(EMSProductBuilder *builder) {
    [builder setRequiredFieldsWithProductId:dictionary[@"productId"]
      title:dictionary[@"title"]
      linkUrl:[NSURL URLWithString:dictionary[@"linkUrl"]]
      feature:dictionary[@"feature"]
      cohort:dictionary[@"cohort"]];
    [builder setCustomFields:dictionary[@"customFields"]];
    [builder setImageUrl:(dictionary[@"imageUrl"] != nil ? [NSURL URLWithString:dictionary[@"imageUrl"]] : nil)];
    [builder setZoomImageUrl:(dictionary[@"zoomImageUrl"] != nil ? [NSURL URLWithString:dictionary[@"zoomImageUrl"]] : nil)];
    [builder setCategoryPath:dictionary[@"categoryPath"]];
    [builder setAvailable:[NSNumber numberWithBool:dictionary[@"available"]]];
    [builder setProductDescription:dictionary[@"productDescription"]];
    [builder setPrice:dictionary[@"price"]];
    [builder setMsrp:dictionary[@"msrp"]];
    [builder setAlbum:dictionary[@"album"]];
    [builder setActor:dictionary[@"actor"]];
    [builder setArtist:dictionary[@"artist"]];
    [builder setAuthor:dictionary[@"author"]];
    [builder setBrand:dictionary[@"brand"]];
    [builder setYear:dictionary[@"year"]];
  }];
}

@end
