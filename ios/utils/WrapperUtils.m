#import "WrapperUtils.h"

@implementation NSError (RNEmarsys)

+ (NSError *)errorWithException:(NSException *)exception {
  return [NSError errorWithDomain:@"com.emarsys.reactnative" code:0 userInfo:@{
    NSLocalizedDescriptionKey: exception.name,
    NSLocalizedFailureReasonErrorKey: exception.reason,
    @"exception": @{
      @"name": exception.name,
      @"reason": exception.reason,
      @"userInfo": exception.userInfo,
      @"callStackReturnAddresses": exception.callStackReturnAddresses,
      @"callStackSymbols": exception.callStackSymbols
    }
  }];
}

@end
