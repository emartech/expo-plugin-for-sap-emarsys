#import <EmarsysSDK/EMSActionModelProtocol.h>
#import <EmarsysSDK/EMSAppEventActionModel.h>
#import <EmarsysSDK/EMSMessage.h>
#import <EmarsysSDK/EMSOpenExternalUrlActionModel.h>
#import "ArrayUtils.h"
#import "Mapper.h"

@interface MessageMapper : NSObject

+ (Mapper)toDictionary;
+ (Mapper)toActionModelDictionary;

@end
