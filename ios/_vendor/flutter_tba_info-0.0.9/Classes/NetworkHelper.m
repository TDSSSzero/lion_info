#import "NetworkHelper.h"

@implementation NetworkHelper

+ (NSString *)netInfo {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *c = [info subscriberCellularProvider];
    NSString *mcc = [c mobileCountryCode];
    NSString *mcn = [c mobileNetworkCode];
    return mcn;
}

@end
