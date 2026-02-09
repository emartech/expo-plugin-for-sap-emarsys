#import <XCTest/XCTest.h>
#import "MessageMapper.h"

@interface MessageMapperTest: XCTestCase

@end

@implementation MessageMapperTest

- (void)testToDictionary_withMessage {
  Mapper mapper = MessageMapper.toDictionary;
  
  EMSAppEventActionModel *appEventAction = [[EMSAppEventActionModel alloc]
    initWithId:@"actionId1"
    title:@"actionTitle1"
    type:@"MEAppEvent"
    name:@"actionName1"
    payload:@{@"key11": @"value", @"key12": @123}
  ];
  
  id<EMSActionModelProtocol> customEventAction = [[EMSAppEventActionModel alloc]
    initWithId:@"actionId2"
    title:@"actionTitle2"
    type:@"MECustomEvent"
    name:@"actionName2"
    payload:@{@"key21": @"value", @"key22": @456}
  ];
  
  EMSOpenExternalUrlActionModel *urlAction = [[EMSOpenExternalUrlActionModel alloc]
    initWithId:@"actionId4"
    title:@"actionTitle4"
    type:@"OpenExternalUrl"
    url:[[NSURL alloc] initWithString:@"https://www.emarsys.com"]
  ];
  
  EMSMessage *message = [[EMSMessage alloc]
    initWithId:@"testId"
    campaignId:@"testCampaignId"
    collapseId:@"testCollapseId"
    title:@"testTitle"
    body:@"testBody"
    imageUrl:@"testImageUrl"
    imageAltText:@"testImageAltText"
    receivedAt:@1234
    updatedAt:@4321
    expiresAt:@5678
    tags:@[@"TAG1", @"TAG2", @"TAG3"]
    properties:@{@"k1": @"v1", @"k2": @"v2"}
    actions:@[appEventAction, customEventAction, urlAction]
  ];
  
  NSDictionary *result = mapper(message);
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result[@"id"], @"testId", @"Message id should match");
  XCTAssertEqualObjects(result[@"campaignId"], @"testCampaignId", @"Message campaignId should match");
  XCTAssertEqualObjects(result[@"collapseId"], @"testCollapseId", @"Message collapseId should match");
  XCTAssertEqualObjects(result[@"title"], @"testTitle", @"Message title should match");
  XCTAssertEqualObjects(result[@"body"], @"testBody", @"Message body should match");
  XCTAssertEqualObjects(result[@"imageUrl"], @"testImageUrl", @"Message imageUrl should match");
  XCTAssertEqualObjects(result[@"imageAltText"], @"testImageAltText", @"Message imageAltText should match");
  XCTAssertEqualObjects(result[@"receivedAt"], @1234, @"Message receivedAt should match");
  XCTAssertEqualObjects(result[@"updatedAt"], @4321, @"Message updatedAt should match");
  XCTAssertEqualObjects(result[@"expiresAt"], @5678, @"Message expiresAt should match");
  
  NSArray *tags = result[@"tags"];
  XCTAssertNotNil(tags, @"Tags array should not be nil");
  XCTAssertEqual(tags.count, 3, @"Tags array should have 3 items");
  XCTAssertEqualObjects(tags[0], @"TAG1", @"First tag should match");
  XCTAssertEqualObjects(tags[1], @"TAG2", @"Second tag should match");
  XCTAssertEqualObjects(tags[2], @"TAG3", @"Third tag should match");
  
  NSDictionary *properties = result[@"properties"];
  XCTAssertNotNil(properties, @"Properties dictionary should not be nil");
  XCTAssertEqual(properties.count, 2, @"Properties should have 2 items");
  XCTAssertEqualObjects(properties[@"k1"], @"v1", @"First property should match");
  XCTAssertEqualObjects(properties[@"k2"], @"v2", @"Second property should match");
  
  NSArray *actions = result[@"actions"];
  XCTAssertNotNil(actions, @"Actions array should not be nil");
  XCTAssertEqual(actions.count, 3, @"Actions array should have 3 items");
  
  NSDictionary *firstAction = actions[0];
  XCTAssertEqualObjects(firstAction[@"id"], @"actionId1", @"First action id should match");
  XCTAssertEqualObjects(firstAction[@"title"], @"actionTitle1", @"First action title should match");
  XCTAssertEqualObjects(firstAction[@"type"], @"MEAppEvent", @"First action type should match");
  XCTAssertEqualObjects(firstAction[@"name"], @"actionName1", @"First action name should match");
  NSDictionary *firstActionPayload = firstAction[@"payload"];
  XCTAssertNotNil(firstActionPayload, @"First action payload should not be nil");
  XCTAssertEqualObjects(firstActionPayload[@"key11"], @"value", @"First action payload key11 should match");
  XCTAssertEqualObjects(firstActionPayload[@"key12"], @123, @"First action payload key12 should match");
  
  NSDictionary *secondAction = actions[1];
  XCTAssertEqualObjects(secondAction[@"id"], @"actionId2", @"Second action id should match");
  XCTAssertEqualObjects(secondAction[@"title"], @"actionTitle2", @"Second action title should match");
  XCTAssertEqualObjects(secondAction[@"type"], @"MECustomEvent", @"Second action type should match");
  
  NSDictionary *thirdAction = actions[2];
  XCTAssertEqualObjects(thirdAction[@"id"], @"actionId4", @"Third action id should match");
  XCTAssertEqualObjects(thirdAction[@"title"], @"actionTitle4", @"Third action title should match");
  XCTAssertEqualObjects(thirdAction[@"type"], @"OpenExternalUrl", @"Third action type should match");
  XCTAssertEqualObjects(thirdAction[@"url"], @"https://www.emarsys.com", @"Third action url should match");
}

- (void)testToActionModelDictionary_withAppEventActionModel {
  Mapper mapper = MessageMapper.toActionModelDictionary;
  
  EMSAppEventActionModel *actionModel = [[EMSAppEventActionModel alloc]
    initWithId:@"testActionId"
    title:@"testActionTitle"
    type:@"MEAppEvent"
    name:@"testEventName"
    payload:@{@"key": @"value"}
  ];
  
  NSDictionary *result = mapper(actionModel);
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result[@"id"], @"testActionId", @"Action id should match");
  XCTAssertEqualObjects(result[@"title"], @"testActionTitle", @"Action title should match");
  XCTAssertEqualObjects(result[@"type"], @"MEAppEvent", @"Action type should match");
  XCTAssertEqualObjects(result[@"name"], @"testEventName", @"Action name should match");
  NSDictionary *payload = result[@"payload"];
  XCTAssertNotNil(payload, @"Payload should not be nil");
  XCTAssertEqualObjects(payload[@"key"], @"value", @"Payload should match");
}

- (void)testToActionModelDictionary_withOpenExternalUrlActionModel {
  Mapper mapper = MessageMapper.toActionModelDictionary;
  
  EMSOpenExternalUrlActionModel *actionModel = [[EMSOpenExternalUrlActionModel alloc]
    initWithId:@"testActionId"
    title:@"testActionTitle"
    type:@"OpenExternalUrl"
    url:[[NSURL alloc] initWithString:@"https://www.emarsys.com"]
  ];
  
  NSDictionary *result = mapper(actionModel);
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result[@"id"], @"testActionId", @"Action id should match");
  XCTAssertEqualObjects(result[@"title"], @"testActionTitle", @"Action title should match");
  XCTAssertEqualObjects(result[@"type"], @"OpenExternalUrl", @"Action type should match");
  XCTAssertEqualObjects(result[@"url"], @"https://www.emarsys.com", @"Action url should match");
}

@end
