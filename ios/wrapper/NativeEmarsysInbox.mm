#import <EmarsysSDK/Emarsys.h>
#import <NativeEmarsys/NativeEmarsys.h>
#import "ArrayUtils.h"
#import "MessageMapper.h"
#import "WrapperUtils.h"

#define NAME @"NativeEmarsysInbox"

@interface NativeEmarsysInbox : NSObject <NativeEmarsysInboxSpec>

@end

@implementation NativeEmarsysInbox

RCT_EXPORT_MODULE()

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const facebook::react::ObjCTurboModule::InitParams &)params {
  return std::make_shared<facebook::react::NativeEmarsysInboxSpecJSI>(params);
}

- (void)fetchMessages:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.messageInbox fetchMessagesWithResultBlock:^(EMSInboxResult *inboxResult, NSError *error) {
      if (error == nil) {
        NSArray *messages = [inboxResult.messages map:MessageMapper.toDictionary];
        resolve(messages);
      } else {
        reject(NAME, @"fetchMessages", error);
      }
    }];
  } @catch (NSException *exception) {
    reject(NAME, @"fetchMessages", [NSError errorWithException:exception]);
  }
}

- (void)addTag:(NSString *)tag messageId:(NSString *)messageId
  resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.messageInbox addTag:tag forMessage:messageId completionBlock:^(NSError *error) {
      if (error == nil) {
        resolve(nil);
      } else {
        reject(NAME, @"addTag", error);
      }
    }];
  } @catch (NSException *exception) {
    reject(NAME, @"addTag", [NSError errorWithException:exception]);
  }
}

- (void)removeTag:(NSString *)tag messageId:(NSString *)messageId
  resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.messageInbox removeTag:tag fromMessage:messageId completionBlock:^(NSError *error) {
      if (error == nil) {
        resolve(nil);
      } else {
        reject(NAME, @"removeTag", error);
      }
    }];
  } @catch (NSException *exception) {
    reject(NAME, @"removeTag", [NSError errorWithException:exception]);
  }
}

@end
