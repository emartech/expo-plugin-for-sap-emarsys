#import <XCTest/XCTest.h>
#import "LogicMapper.h"

@interface LogicMapperTest: XCTestCase

@end

@implementation LogicMapperTest

- (void)test_toModel_search {
  NSDictionary *dictionary = @{
    @"name": @"SEARCH"
  };
  
  EMSLogic *result = [LogicMapper toModel:dictionary];
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.logic, @"SEARCH", @"logic should match");
  XCTAssertEqualObjects(result.data, @{}, @"data should match");
  XCTAssertEqualObjects(result.variants, nil, @"variants should match");
}

- (void)test_toModel_searchWithData {
  NSDictionary *dictionary = @{
    @"name": @"SEARCH",
    @"query": @"testQuery",
    @"cartItems": @[@{
      @"itemId": @"testId",
      @"price": @12.34,
      @"quantity": @56.78
    }],
    @"variants": @[@"test1", @"test2"]
  };
  
  EMSLogic *result = [LogicMapper toModel:dictionary];
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.logic, @"SEARCH", @"logic should match");
  XCTAssertEqualObjects(result.data, @{@"q": @"testQuery"}, @"data should match");
  XCTAssertEqualObjects(result.variants, nil, @"variants should match");
}

- (void)test_toModel_cart {
  NSDictionary *dictionary = @{
    @"name": @"CART"
  };
  
  EMSLogic *result = [LogicMapper toModel:dictionary];
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.logic, @"CART", @"logic should match");
  XCTAssertEqualObjects(result.data, @{}, @"data should match");
  XCTAssertEqualObjects(result.variants, nil, @"variants should match");
}

- (void)test_toModel_cartWithData {
  NSDictionary *dictionary = @{
    @"name": @"CART",
    @"query": @"testQuery",
    @"cartItems": @[@{
      @"itemId": @"testId",
      @"price": @12.34,
      @"quantity": @56.78
    }],
    @"variants": @[@"test1", @"test2"]
  };
  
  EMSLogic *result = [LogicMapper toModel:dictionary];
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.logic, @"CART", @"logic should match");
  XCTAssertEqualObjects(result.data, (@{
    @"cv": @"1",
    @"ca": @"i:testId,p:12.34,q:56.78"
  }), @"data should match");
  XCTAssertEqualObjects(result.variants, nil, @"variants should match");
}

- (void)test_toModel_related {
  NSDictionary *dictionary = @{
    @"name": @"RELATED"
  };
  
  EMSLogic *result = [LogicMapper toModel:dictionary];
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.logic, @"RELATED", @"logic should match");
  XCTAssertEqualObjects(result.data, @{}, @"data should match");
  XCTAssertEqualObjects(result.variants, nil, @"variants should match");
}

- (void)test_toModel_relatedWithData {
  NSDictionary *dictionary = @{
    @"name": @"RELATED",
    @"query": @"testQuery",
    @"cartItems": @[@{
      @"itemId": @"testId",
      @"price": @12.34,
      @"quantity": @56.78
    }],
    @"variants": @[@"test1", @"test2"]
  };
  
  EMSLogic *result = [LogicMapper toModel:dictionary];
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.logic, @"RELATED", @"logic should match");
  XCTAssertEqualObjects(result.data, @{@"v": @"i:testQuery"}, @"data should match");
  XCTAssertEqualObjects(result.variants, nil, @"variants should match");
}

- (void)test_toModel_category {
  NSDictionary *dictionary = @{
    @"name": @"CATEGORY"
  };
  
  EMSLogic *result = [LogicMapper toModel:dictionary];
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.logic, @"CATEGORY", @"logic should match");
  XCTAssertEqualObjects(result.data, @{}, @"data should match");
  XCTAssertEqualObjects(result.variants, nil, @"variants should match");
}

- (void)test_toModel_categoryWithData {
  NSDictionary *dictionary = @{
    @"name": @"CATEGORY",
    @"query": @"testQuery",
    @"cartItems": @[@{
      @"itemId": @"testId",
      @"price": @12.34,
      @"quantity": @56.78
    }],
    @"variants": @[@"test1", @"test2"]
  };
  
  EMSLogic *result = [LogicMapper toModel:dictionary];
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.logic, @"CATEGORY", @"logic should match");
  XCTAssertEqualObjects(result.data, @{@"vc": @"testQuery"}, @"data should match");
  XCTAssertEqualObjects(result.variants, nil, @"variants should match");
}

- (void)test_toModel_alsoBought {
  NSDictionary *dictionary = @{
    @"name": @"ALSO_BOUGHT"
  };
  
  EMSLogic *result = [LogicMapper toModel:dictionary];
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.logic, @"ALSO_BOUGHT", @"logic should match");
  XCTAssertEqualObjects(result.data, @{}, @"data should match");
  XCTAssertEqualObjects(result.variants, nil, @"variants should match");
}

- (void)test_toModel_alsoBoughtWithData {
  NSDictionary *dictionary = @{
    @"name": @"ALSO_BOUGHT",
    @"query": @"testQuery",
    @"cartItems": @[@{
      @"itemId": @"testId",
      @"price": @12.34,
      @"quantity": @56.78
    }],
    @"variants": @[@"test1", @"test2"]
  };
  
  EMSLogic *result = [LogicMapper toModel:dictionary];
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.logic, @"ALSO_BOUGHT", @"logic should match");
  XCTAssertEqualObjects(result.data, @{@"v": @"i:testQuery"}, @"data should match");
  XCTAssertEqualObjects(result.variants, nil, @"variants should match");
}

- (void)test_toModel_popular {
  NSDictionary *dictionary = @{
    @"name": @"POPULAR"
  };
  
  EMSLogic *result = [LogicMapper toModel:dictionary];
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.logic, @"POPULAR", @"logic should match");
  XCTAssertEqualObjects(result.data, @{}, @"data should match");
  XCTAssertEqualObjects(result.variants, nil, @"variants should match");
}

- (void)test_toModel_popularWithData {
  NSDictionary *dictionary = @{
    @"name": @"POPULAR",
    @"query": @"testQuery",
    @"cartItems": @[@{
      @"itemId": @"testId",
      @"price": @12.34,
      @"quantity": @56.78
    }],
    @"variants": @[@"test1", @"test2"]
  };
  
  EMSLogic *result = [LogicMapper toModel:dictionary];
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.logic, @"POPULAR", @"logic should match");
  XCTAssertEqualObjects(result.data, @{@"vc": @"testQuery"}, @"data should match");
  XCTAssertEqualObjects(result.variants, nil, @"variants should match");
}

- (void)test_toModel_personal {
  NSDictionary *dictionary = @{
    @"name": @"PERSONAL"
  };
  
  EMSLogic *result = [LogicMapper toModel:dictionary];
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.logic, @"PERSONAL", @"logic should match");
  XCTAssertEqualObjects(result.data, @{}, @"data should match");
  XCTAssertEqualObjects(result.variants, nil, @"variants should match");
}

- (void)test_toModel_personalWithData {
  NSDictionary *dictionary = @{
    @"name": @"PERSONAL",
    @"query": @"testQuery",
    @"cartItems": @[@{
      @"itemId": @"testId",
      @"price": @12.34,
      @"quantity": @56.78
    }],
    @"variants": @[@"test1", @"test2"]
  };
  
  EMSLogic *result = [LogicMapper toModel:dictionary];
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.logic, @"PERSONAL", @"logic should match");
  XCTAssertEqualObjects(result.data, @{}, @"data should match");
  XCTAssertEqualObjects(result.variants, (@[@"test1", @"test2"]), @"variants should match");
}

- (void)test_toModel_home {
  NSDictionary *dictionary = @{
    @"name": @"HOME"
  };
  
  EMSLogic *result = [LogicMapper toModel:dictionary];
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.logic, @"HOME", @"logic should match");
  XCTAssertEqualObjects(result.data, @{}, @"data should match");
  XCTAssertEqualObjects(result.variants, nil, @"variants should match");
}

- (void)test_toModel_homeWithData {
  NSDictionary *dictionary = @{
    @"name": @"HOME",
    @"query": @"testQuery",
    @"cartItems": @[@{
      @"itemId": @"testId",
      @"price": @12.34,
      @"quantity": @56.78
    }],
    @"variants": @[@"test1", @"test2"]
  };
  
  EMSLogic *result = [LogicMapper toModel:dictionary];
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result.logic, @"HOME", @"logic should match");
  XCTAssertEqualObjects(result.data, @{}, @"data should match");
  XCTAssertEqualObjects(result.variants, (@[@"test1", @"test2"]), @"variants should match");
}

- (void)test_toModel_nil {
  EMSLogic *result = [LogicMapper toModel:nil];
  
  XCTAssertNil(result, @"Result should be nil");
}

@end
