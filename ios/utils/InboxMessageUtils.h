#import <Foundation/Foundation.h>
#import <EmarsysSDK/EMSMessage.h>
#import <EmarsysSDK/EMSActionModelProtocol.h>

@interface InboxMessageUtils : NSObject

+ (NSMutableDictionary *)messageToMap:(EMSMessage *)message;

@end
