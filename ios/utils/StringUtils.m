#import "StringUtils.h"

@implementation NSString (RNEmarsys)

- (NSData *)deviceTokenData {
  NSString *string = [self stringByReplacingOccurrencesOfString:@" " withString:@""];

  char byte_chars[3] = {'\0','\0','\0'};
  unsigned char whole_byte;
  NSMutableData *data = [NSMutableData data];
  for (int i = 0; i < ([string length] / 2); i++) {
    byte_chars[0] = [string characterAtIndex:i*2];
    byte_chars[1] = [string characterAtIndex:i*2+1];
    whole_byte = strtol(byte_chars, NULL, 16);
    [data appendBytes:&whole_byte length:1];
  }

  return data;
}

@end

@implementation NSData (RNEmarsys)

- (NSString *)deviceTokenString {
  const char *data = [self bytes];

  NSMutableString *string = [NSMutableString string];
  for (int i = 0; i < [self length]; i++) {
    [string appendFormat:@"%02.2hhX", data[i]];
  }

  return string;
}

@end
