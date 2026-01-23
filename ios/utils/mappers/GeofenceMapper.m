#import "GeofenceMapper.h"

@implementation GeofenceMapper

static Mapper _toDictionary = ^NSDictionary *(EMSGeofence *geofence) {
  NSMutableDictionary<NSString *, NSObject *> *dictionary = [NSMutableDictionary dictionary];
  dictionary[@"id"] = geofence.id;
  dictionary[@"lat"] = @(geofence.lat);
  dictionary[@"lon"] = @(geofence.lon);
  dictionary[@"radius"] = @(geofence.r);
  dictionary[@"waitInterval"] = @(geofence.waitInterval);
  dictionary[@"triggers"] = [geofence.triggers map:GeofenceMapper.toTriggerDictionary];

  return dictionary;
};

+ (Mapper)toDictionary {
  return _toDictionary;
}

static Mapper _toTriggerDictionary = ^NSDictionary *(EMSGeofenceTrigger *trigger) {
  NSMutableDictionary<NSString *, NSObject *> *dictionary = [NSMutableDictionary dictionary];
  dictionary[@"id"] = trigger.id;
  dictionary[@"type"] = trigger.type;
  dictionary[@"loiteringDelay"] = @(trigger.loiteringDelay);
  dictionary[@"action"] = trigger.action;

  return dictionary;
};

+ (Mapper)toTriggerDictionary {
  return _toTriggerDictionary;
}


@end
