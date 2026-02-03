#import <XCTest/XCTest.h>
#import <EmarsysSDK/EMSGeofence.h>
#import <EmarsysSDK/EMSGeofenceTrigger.h>
#import "GeofenceMapper.h"

@interface GeofenceMapperTest: XCTestCase

@end

@implementation GeofenceMapperTest

- (void)testToDictionary_withGeofence {
  Mapper mapper = GeofenceMapper.toDictionary;
  
  NSDictionary *actionDictionary = @{
    @"id": @"testId",
    @"type": @"MECustomEvent",
    @"name": @"testName",
    @"payload": @{@"key": @"value"}
  };
  
  EMSGeofenceTrigger *trigger1 = [[EMSGeofenceTrigger alloc]
    initWithId:@"testTriggerId"
    type:@"ENTER"
    loiteringDelay:123 
    action:actionDictionary
  ];

  EMSGeofence *geofence1 = [[EMSGeofence alloc]
    initWithId:@"testGeofenceId"
    lat:12.34
    lon:56.78
    r:30.0
    waitInterval:90.12
    triggers:@[trigger1]
  ];

  EMSGeofenceTrigger *trigger2 = [[EMSGeofenceTrigger alloc]
    initWithId:@"testTriggerId2"
    type:@"EXIT"
    loiteringDelay:456
    action:@{}
  ];

  EMSGeofence *geofence2 = [[EMSGeofence alloc]
    initWithId:@"testGeofenceId2"
    lat:12.34
    lon:56.78
    r:30.0
    waitInterval:90.12
    triggers:@[trigger2]
  ];
  
  NSDictionary *result1 = mapper(geofence1);
  
  XCTAssertNotNil(result1, @"Result should not be nil");
  XCTAssertEqualObjects(result1[@"id"], @"testGeofenceId", @"First geofence id should match");
  XCTAssertEqualObjects(result1[@"lat"], @12.34, @"First geofence lat should match");
  XCTAssertEqualObjects(result1[@"lon"], @56.78, @"First geofence lon should match");
  XCTAssertEqualObjects(result1[@"radius"], @30.0, @"First geofence radius should match");
  XCTAssertEqualObjects(result1[@"waitInterval"], @90.12, @"First geofence waitInterval should match");
  
  NSArray *resultTriggers1 = result1[@"triggers"];
  XCTAssertEqual(resultTriggers1.count, 1, @"First geofence should have 1 trigger");
  
  NSDictionary *resultTrigger1 = resultTriggers1[0];
  XCTAssertEqualObjects(resultTrigger1[@"id"], @"testTriggerId", @"First trigger id should match");
  XCTAssertEqualObjects(resultTrigger1[@"type"], @"ENTER", @"First trigger type should match");
  XCTAssertEqualObjects(resultTrigger1[@"loiteringDelay"], @123, @"First trigger loiteringDelay should match");
  
  NSDictionary *resultAction1 = resultTrigger1[@"action"];
  XCTAssertEqual(resultAction1.count, actionDictionary.count, @"First trigger action should have same key count");
  XCTAssertEqualObjects(resultAction1[@"id"], @"testId", @"Action id should match");
  XCTAssertEqualObjects(resultAction1[@"type"], @"MECustomEvent", @"Action type should match");
  XCTAssertEqualObjects(resultAction1[@"name"], @"testName", @"Action name should match");
  
  NSDictionary *result2 = mapper(geofence2);
  
  XCTAssertNotNil(result2, @"Result should not be nil");
  XCTAssertEqualObjects(result2[@"id"], @"testGeofenceId2", @"Second geofence id should match");
  XCTAssertEqualObjects(result2[@"lat"], @12.34, @"Second geofence lat should match");
  XCTAssertEqualObjects(result2[@"lon"], @56.78, @"Second geofence lon should match");
  XCTAssertEqualObjects(result2[@"radius"], @30.0, @"Second geofence radius should match");
  XCTAssertEqualObjects(result2[@"waitInterval"], @90.12, @"Second geofence waitInterval should match");
  
  NSArray *resultTriggers2 = result2[@"triggers"];
  XCTAssertEqual(resultTriggers2.count, 1, @"Second geofence should have 1 trigger");
  
  NSDictionary *resultTrigger2 = resultTriggers2[0];
  XCTAssertEqualObjects(resultTrigger2[@"id"], @"testTriggerId2", @"Second trigger id should match");
  XCTAssertEqualObjects(resultTrigger2[@"type"], @"EXIT", @"Second trigger type should match");
  XCTAssertEqualObjects(resultTrigger2[@"loiteringDelay"], @456, @"Second trigger loiteringDelay should match");
  
  NSDictionary *resultAction2 = resultTrigger2[@"action"];
  XCTAssertEqual(resultAction2.count, 0, @"Second trigger action should be empty");
}

- (void)testToTriggerDictionary {
  Mapper mapper = GeofenceMapper.toTriggerDictionary;
  
  NSDictionary *actionDictionary = @{
    @"key": @"value"
  };
  
  EMSGeofenceTrigger *trigger = [[EMSGeofenceTrigger alloc]
    initWithId:@"triggerId"
    type:@"ENTER"
    loiteringDelay:100
    action:actionDictionary
  ];
  
  NSDictionary *result = mapper(trigger);
  
  XCTAssertNotNil(result, @"Result should not be nil");
  XCTAssertEqualObjects(result[@"id"], @"triggerId", @"Trigger id should match");
  XCTAssertEqualObjects(result[@"type"], @"ENTER", @"Trigger type should match");
  XCTAssertEqualObjects(result[@"loiteringDelay"], @100, @"Trigger loiteringDelay should match");
  
  NSDictionary *resultAction = result[@"action"];
  XCTAssertEqualObjects(resultAction[@"key"], @"value", @"Action key should match");
}

@end
