// Autogenerated from Pigeon (v0.1.17), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import "pigeon.h"
#import <Flutter/Flutter.h>

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSDictionary* wrapResult(NSDictionary *result, FlutterError *error) {
  NSDictionary *errorDict = (NSDictionary *)[NSNull null];
  if (error) {
    errorDict = [NSDictionary dictionaryWithObjectsAndKeys:
        (error.code ? error.code : [NSNull null]), @"code",
        (error.message ? error.message : [NSNull null]), @"message",
        (error.details ? error.details : [NSNull null]), @"details",
        nil];
  }
  return [NSDictionary dictionaryWithObjectsAndKeys:
      (result ? result : [NSNull null]), @"result",
      errorDict, @"error",
      nil];
}

@interface MultiplyResult ()
+(MultiplyResult*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end
@interface MultiplyRequest ()
+(MultiplyRequest*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end

@implementation MultiplyResult
+(MultiplyResult*)fromMap:(NSDictionary*)dict {
  MultiplyResult* result = [[MultiplyResult alloc] init];
  result.result = dict[@"result"];
  if ((NSNull *)result.result == [NSNull null]) {
    result.result = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.result ? self.result : [NSNull null]), @"result", nil];
}
@end

@implementation MultiplyRequest
+(MultiplyRequest*)fromMap:(NSDictionary*)dict {
  MultiplyRequest* result = [[MultiplyRequest alloc] init];
  result.multiplicand = dict[@"multiplicand"];
  if ((NSNull *)result.multiplicand == [NSNull null]) {
    result.multiplicand = nil;
  }
  result.multiplier = dict[@"multiplier"];
  if ((NSNull *)result.multiplier == [NSNull null]) {
    result.multiplier = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.multiplicand ? self.multiplicand : [NSNull null]), @"multiplicand", (self.multiplier ? self.multiplier : [NSNull null]), @"multiplier", nil];
}
@end

void MultiplyApiSetup(id<FlutterBinaryMessenger> binaryMessenger, id<MultiplyApi> api) {
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.MultiplyApi.multiply"
        binaryMessenger:binaryMessenger];
    if (api) {
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        MultiplyRequest *input = [MultiplyRequest fromMap:message];
        MultiplyResult *output = [api multiply:input error:&error];
        callback(wrapResult([output toMap], error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}