#import <XCTest/XCTest.h>
#import "CartItemMapper.h"

@interface CartItemMapperTest: XCTestCase

@end

@implementation CartItemMapperTest

- (void)test_toModel {
  NSDictionary *dictionary = @{
    @"itemId": @"testId",
    @"price": @12.34,
    @"quantity": @56.78
  };
  
  EMSCartItem *result = CartItemMapper.toModel(dictionary);
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.itemId, @"testId", @"itemId should match");
  XCTAssertEqual(result.price, 12.34, @"price should match");
  XCTAssertEqual(result.quantity, 56.78, @"quantity should match");
}

- (void)test_toModel_nil {
  EMSCartItem *result = CartItemMapper.toModel(nil);
  
  XCTAssertNil(result, @"Result should be nil");
}

@end
