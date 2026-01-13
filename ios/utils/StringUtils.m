#import "StringUtils.h"

@implementation StringUtils

+ (NSData *)dataWithString:(NSString *)stringValue {
    stringValue = [stringValue stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableData *data = [[NSMutableData alloc] init];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    for (int i = 0; i < ([stringValue length] / 2); i++) {
        byte_chars[0] = [stringValue characterAtIndex:i*2];
        byte_chars[1] = [stringValue characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    return data;
}

+ (NSString *)stringWithData:(NSData *)data {
    const char *bytes = [data bytes];
    NSMutableString *stringValue = [NSMutableString string];

    for (int i = 0; i < [data length]; i++) {
        [stringValue appendFormat:@"%02.2hhX", bytes[i]];
    }

    return [stringValue copy];
}

@end
