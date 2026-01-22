#import <Foundation/Foundation.h>
#import <NativeEmarsys/NativeEmarsys.h>

#import <EmarsysSDK/Emarsys.h>
#import <EmarsysSDK/EMSMessage.h>
#import "InboxMessageUtils.h"

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
          NSArray *messages = inboxResult.messages;
          NSMutableArray *convertedMessages = [NSMutableArray array];
          for (EMSMessage *message in messages) {
            NSMutableDictionary *convertedMessage = [InboxMessageUtils messageToMap:message];
            [convertedMessages addObject:convertedMessage];
          }
          resolve(convertedMessages);
        } else {
          reject(NAME, @"fetchMessages: ", error);
        }
      }];
    } @catch (NSException *exception) {
      reject(exception.name, exception.reason, nil);
    }
}

- (void)addTag:(NSString *)tag messageId:(NSString *)messageId resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.messageInbox addTag:tag forMessage:messageId completionBlock:^(NSError *error) {
      if (error == nil) {
        resolve(nil);
      } else {
        reject(NAME, @"addTag: ", error);
      }
    }];
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}


- (void)removeTag:(NSString *)tag messageId:(NSString *)messageId resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  @try {
    [Emarsys.messageInbox removeTag:tag fromMessage:messageId completionBlock:^(NSError *error) {
      if (error == nil) {
        resolve(nil);
      } else {
        reject(NAME, @"removeTag: ", error);
      }
    }];
  } @catch (NSException *exception) {
    reject(exception.name, exception.reason, nil);
  }
}

@end
