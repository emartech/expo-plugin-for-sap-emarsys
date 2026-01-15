#import "StringUtils.h"

@implementation StringUtils

+ (NSData *)dataWithDeviceToken:(NSString *)deviceToken {
  deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
  NSMutableData *data = [[NSMutableData alloc] init];
  unsigned char whole_byte;
  char byte_chars[3] = {'\0','\0','\0'};
  for (int i = 0; i < ([deviceToken length] / 2); i++) {
    byte_chars[0] = [deviceToken characterAtIndex:i*2];
    byte_chars[1] = [deviceToken characterAtIndex:i*2+1];
    whole_byte = strtol(byte_chars, NULL, 16);
    [data appendBytes:&whole_byte length:1];
  }
  return data;
}

+ (NSString *)stringWithDeviceToken:(NSData *)deviceToken {
  const char *data = [deviceToken bytes];
  NSMutableString *token = [NSMutableString string];

  for (int i = 0; i < [deviceToken length]; i++) {
    [token appendFormat:@"%02.2hhX", data[i]];
  }

  return [token copy];
}

@end
