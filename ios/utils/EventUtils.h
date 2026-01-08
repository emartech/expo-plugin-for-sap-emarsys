#import <EmarsysSDK/Emarsys.h>

@interface EventUtils : NSObject

+ (void)setEventHandler:(EMSEventHandlerBlock)eventHandler;

@end
