#import <XCTest/XCTest.h>
#import "ProductMapper.h"

@interface ProductMapperTest: XCTestCase

@end

@interface TestProduct : NSObject<EMSProductProtocol>

@property(nonatomic, strong) NSString *productId;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSURL *linkUrl;
@property(nonatomic, strong) NSString *feature;
@property(nonatomic, strong) NSString *cohort;
@property(nonatomic, strong) NSDictionary<NSString *, id> *customFields;
@property(nonatomic, strong, nullable) NSURL *imageUrl;
@property(nonatomic, strong, nullable) NSURL *zoomImageUrl;
@property(nonatomic, strong, nullable) NSString *categoryPath;
@property(nonatomic, strong, nullable) NSNumber *available;
@property(nonatomic, strong, nullable) NSString *productDescription;
@property(nonatomic, strong, nullable) NSNumber *price;
@property(nonatomic, strong, nullable) NSNumber *msrp;
@property(nonatomic, strong, nullable) NSString *album;
@property(nonatomic, strong, nullable) NSString *actor;
@property(nonatomic, strong, nullable) NSString *artist;
@property(nonatomic, strong, nullable) NSString *author;
@property(nonatomic, strong, nullable) NSString *brand;
@property(nonatomic, strong, nullable) NSNumber *year;

@end

@implementation TestProduct

- (instancetype)init {
  if (self = [super init]) {
    _productId = @"testProductId";
    _title = @"testTitle";
    _linkUrl = [NSURL URLWithString:@"https://www.testLinkUrl.com"];
    _feature = @"testFeature";
    _cohort = @"testCohort";
    _customFields = @{@"testK1": @"testV1", @"testK2": @"testV2"};
    _imageUrl = [NSURL URLWithString:@"https://www.testImageUrl.com"];
    _zoomImageUrl = [NSURL URLWithString:@"https://www.testZoomImageUrl.com"];
    _categoryPath = @"testCategoryPath";
    _available = [NSNumber numberWithBool:true];
    _productDescription = @"testProductDescription";
    _price = @12.34;
    _msrp = @56.78;
    _album = @"testAlbum";
    _actor = @"testActor";
    _artist = @"testArtist";
    _author = @"testAuthor";
    _brand = @"testBrand";
    _year = @999;
  }
  return self;
}

@end

@implementation ProductMapperTest

- (void)test_toDictionary {
  TestProduct *product = [[TestProduct alloc] init];
  
  NSDictionary *result = ProductMapper.toDictionary(product);
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result[@"productId"], @"testProductId", @"productId should match");
  XCTAssertEqualObjects(result[@"title"], @"testTitle", @"title should match");
  XCTAssertEqualObjects(result[@"linkUrl"], @"https://www.testLinkUrl.com", @"linkUrl should match");
  XCTAssertEqualObjects(result[@"feature"], @"testFeature", @"feature should match");
  XCTAssertEqualObjects(result[@"cohort"], @"testCohort", @"cohort should match");
  XCTAssertEqualObjects(result[@"customFields"], (@{@"testK1": @"testV1", @"testK2": @"testV2"}), @"customFields should match");
  XCTAssertEqualObjects(result[@"imageUrl"], @"https://www.testImageUrl.com", @"imageUrl should match");
  XCTAssertEqualObjects(result[@"zoomImageUrl"], @"https://www.testZoomImageUrl.com", @"zoomImageUrl should match");
  XCTAssertEqualObjects(result[@"categoryPath"], @"testCategoryPath", @"categoryPath should match");
  XCTAssertEqualObjects(result[@"available"], [NSNumber numberWithBool:true], @"available should match");
  XCTAssertEqualObjects(result[@"productDescription"], @"testProductDescription", @"productDescription should match");
  XCTAssertEqual([result[@"price"] doubleValue], 12.34, @"price should match");
  XCTAssertEqual([result[@"msrp"] doubleValue], 56.78, @"msrp should match");
  XCTAssertEqualObjects(result[@"album"], @"testAlbum", @"album should match");
  XCTAssertEqualObjects(result[@"actor"], @"testActor", @"actor should match");
  XCTAssertEqualObjects(result[@"artist"], @"testArtist", @"artist should match");
  XCTAssertEqualObjects(result[@"author"], @"testAuthor", @"author should match");
  XCTAssertEqualObjects(result[@"brand"], @"testBrand", @"brand should match");
  XCTAssertEqual([result[@"year"] intValue], 999, @"year should match");
}

- (void)test_toModel {
  NSDictionary *dictionary = @{
    @"productId": @"testProductId",
    @"title": @"testTitle",
    @"linkUrl": @"https://www.testLinkUrl.com",
    @"feature": @"testFeature",
    @"cohort": @"testCohort",
    @"customFields": @{@"testK1": @"testV1", @"testK2": @"testV2"},
    @"imageUrl": @"https://www.testImageUrl.com",
    @"zoomImageUrl": @"https://www.testZoomImageUrl.com",
    @"categoryPath": @"testCategoryPath",
    @"available": @YES,
    @"productDescription": @"testProductDescription",
    @"price": @12.34,
    @"msrp": @56.78,
    @"album": @"testAlbum",
    @"actor": @"testActor",
    @"artist": @"testArtist",
    @"author": @"testAuthor",
    @"brand": @"testBrand",
    @"year": @999
  };
  
  EMSProduct *result = [ProductMapper toModel:dictionary];
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.productId, @"testProductId", @"productId should match");
  XCTAssertEqualObjects(result.title, @"testTitle", @"title should match");
  XCTAssertEqualObjects(result.linkUrl.absoluteString, @"https://www.testLinkUrl.com", @"linkUrl should match");
  XCTAssertEqualObjects(result.feature, @"testFeature", @"feature should match");
  XCTAssertEqualObjects(result.cohort, @"testCohort", @"cohort should match");
  XCTAssertEqualObjects(result.customFields, (@{@"testK1": @"testV1", @"testK2": @"testV2"}), @"customFields should match");
  XCTAssertEqualObjects(result.imageUrl.absoluteString, @"https://www.testImageUrl.com", @"imageUrl should match");
  XCTAssertEqualObjects(result.zoomImageUrl.absoluteString, @"https://www.testZoomImageUrl.com", @"zoomImageUrl should match");
  XCTAssertEqualObjects(result.categoryPath, @"testCategoryPath", @"categoryPath should match");
  XCTAssertEqualObjects(result.available, [NSNumber numberWithBool:true], @"available should match");
  XCTAssertEqualObjects(result.productDescription, @"testProductDescription", @"productDescription should match");
  XCTAssertEqualObjects(result.price, @12.34, @"price should match");
  XCTAssertEqualObjects(result.msrp, @56.78, @"msrp should match");
  XCTAssertEqualObjects(result.album, @"testAlbum", @"album should match");
  XCTAssertEqualObjects(result.actor, @"testActor", @"actor should match");
  XCTAssertEqualObjects(result.artist, @"testArtist", @"artist should match");
  XCTAssertEqualObjects(result.author, @"testAuthor", @"author should match");
  XCTAssertEqualObjects(result.brand, @"testBrand", @"brand should match");
  XCTAssertEqualObjects(result.year, @999, @"year should match");
}

- (void)test_toModel_nil {
  EMSProduct *result = [ProductMapper toModel:nil];
  
  XCTAssertNil(result, @"Result should be nil");
}

@end
