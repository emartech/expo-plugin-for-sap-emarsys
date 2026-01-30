#import <EmarsysSDK/EMSGeofence.h>
#import <EmarsysSDK/EMSGeofenceTrigger.h>
#import "ArrayUtils.h"
#import "Mapper.h"

@interface GeofenceMapper : NSObject

+ (Mapper)toDictionary;
+ (Mapper)toTriggerDictionary;

@end
