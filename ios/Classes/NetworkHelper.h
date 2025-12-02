#import <Foundation/Foundation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkHelper : NSObject

+ (NSString *)netInfo;

@end

NS_ASSUME_NONNULL_END
