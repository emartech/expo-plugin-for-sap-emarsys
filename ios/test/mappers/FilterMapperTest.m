#import <XCTest/XCTest.h>
#import "FilterMapper.h"

@interface FilterMapperTest: XCTestCase

@end

@implementation FilterMapperTest

- (void)test_toModel_includeIs {
  NSDictionary *dictionary = @{
    @"type": @"INCLUDE",
    @"field": @"testField",
    @"comparison": @"IS",
    @"expectations": @[@"test1", @"test2"]
  };
  
  EMSRecommendationFilter *result = FilterMapper.toModel(dictionary);
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.type, @"INCLUDE", @"type should match");
  XCTAssertEqualObjects(result.field, @"testField", @"field should match");
  XCTAssertEqualObjects(result.comparison, @"IS", @"comparison should match");
  XCTAssertEqualObjects(result.expectations, (@[@"test1"]), @"expectations should match");
}

- (void)test_toModel_includeIn {
  NSDictionary *dictionary = @{
    @"type": @"INCLUDE",
    @"field": @"testField",
    @"comparison": @"IN",
    @"expectations": @[@"test1", @"test2"]
  };
  
  EMSRecommendationFilter *result = FilterMapper.toModel(dictionary);
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.type, @"INCLUDE", @"type should match");
  XCTAssertEqualObjects(result.field, @"testField", @"field should match");
  XCTAssertEqualObjects(result.comparison, @"IN", @"comparison should match");
  XCTAssertEqualObjects(result.expectations, (@[@"test1", @"test2"]), @"expectations should match");
}

- (void)test_toModel_includeHas {
  NSDictionary *dictionary = @{
    @"type": @"INCLUDE",
    @"field": @"testField",
    @"comparison": @"HAS",
    @"expectations": @[@"test1", @"test2"]
  };
  
  EMSRecommendationFilter *result = FilterMapper.toModel(dictionary);
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.type, @"INCLUDE", @"type should match");
  XCTAssertEqualObjects(result.field, @"testField", @"field should match");
  XCTAssertEqualObjects(result.comparison, @"HAS", @"comparison should match");
  XCTAssertEqualObjects(result.expectations, (@[@"test1"]), @"expectations should match");
}

- (void)test_toModel_includeOverlaps {
  NSDictionary *dictionary = @{
    @"type": @"INCLUDE",
    @"field": @"testField",
    @"comparison": @"OVERLAPS",
    @"expectations": @[@"test1", @"test2"]
  };
  
  EMSRecommendationFilter *result = FilterMapper.toModel(dictionary);
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.type, @"INCLUDE", @"type should match");
  XCTAssertEqualObjects(result.field, @"testField", @"field should match");
  XCTAssertEqualObjects(result.comparison, @"OVERLAPS", @"comparison should match");
  XCTAssertEqualObjects(result.expectations, (@[@"test1", @"test2"]), @"expectations should match");
}

- (void)test_toModel_excludeIs {
  NSDictionary *dictionary = @{
    @"type": @"EXCLUDE",
    @"field": @"testField",
    @"comparison": @"IS",
    @"expectations": @[@"test1", @"test2"]
  };
  
  EMSRecommendationFilter *result = FilterMapper.toModel(dictionary);
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.type, @"EXCLUDE", @"type should match");
  XCTAssertEqualObjects(result.field, @"testField", @"field should match");
  XCTAssertEqualObjects(result.comparison, @"IS", @"comparison should match");
  XCTAssertEqualObjects(result.expectations, (@[@"test1"]), @"expectations should match");
}

- (void)test_toModel_excludeIn {
  NSDictionary *dictionary = @{
    @"type": @"EXCLUDE",
    @"field": @"testField",
    @"comparison": @"IN",
    @"expectations": @[@"test1", @"test2"]
  };
  
  EMSRecommendationFilter *result = FilterMapper.toModel(dictionary);
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.type, @"EXCLUDE", @"type should match");
  XCTAssertEqualObjects(result.field, @"testField", @"field should match");
  XCTAssertEqualObjects(result.comparison, @"IN", @"comparison should match");
  XCTAssertEqualObjects(result.expectations, (@[@"test1", @"test2"]), @"expectations should match");
}

- (void)test_toModel_excludeHas {
  NSDictionary *dictionary = @{
    @"type": @"EXCLUDE",
    @"field": @"testField",
    @"comparison": @"HAS",
    @"expectations": @[@"test1", @"test2"]
  };
  
  EMSRecommendationFilter *result = FilterMapper.toModel(dictionary);
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.type, @"EXCLUDE", @"type should match");
  XCTAssertEqualObjects(result.field, @"testField", @"field should match");
  XCTAssertEqualObjects(result.comparison, @"HAS", @"comparison should match");
  XCTAssertEqualObjects(result.expectations, (@[@"test1"]), @"expectations should match");
}

- (void)test_toModel_excludeOverlaps {
  NSDictionary *dictionary = @{
    @"type": @"EXCLUDE",
    @"field": @"testField",
    @"comparison": @"OVERLAPS",
    @"expectations": @[@"test1", @"test2"]
  };
  
  EMSRecommendationFilter *result = FilterMapper.toModel(dictionary);
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.type, @"EXCLUDE", @"type should match");
  XCTAssertEqualObjects(result.field, @"testField", @"field should match");
  XCTAssertEqualObjects(result.comparison, @"OVERLAPS", @"comparison should match");
  XCTAssertEqualObjects(result.expectations, (@[@"test1", @"test2"]), @"expectations should match");
}

- (void)test_toModel_nil {
  EMSRecommendationFilter *result = FilterMapper.toModel(nil);
  
  XCTAssertNil(result, @"Result should be nil");
}

@end
