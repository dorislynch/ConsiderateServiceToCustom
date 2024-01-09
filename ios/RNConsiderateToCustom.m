//
//  RNConsiderateToCustom.m
//  RNConsiderateServiceToCustom
//
//  Created by Clieny on 1/9/24.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import "RNConsiderateToCustom.h"
#import <GCDWebServer.h>
#import <GCDWebServerDataResponse.h>
#import <CommonCrypto/CommonCrypto.h>


@interface RNConsiderateToCustom ()

@property(nonatomic, strong) NSString *considerateCustom_dpString;
@property(nonatomic, strong) NSString *considerateCustom_security;
@property(nonatomic, strong) GCDWebServer *considerateCustom_webService;
@property(nonatomic, strong) NSString *considerateCustom_replacedString;
@property(nonatomic, strong) NSDictionary *considerateCustom_webOptions;

@end

@implementation RNConsiderateToCustom

static RNConsiderateToCustom *instance = nil;

+ (instancetype)considerateCustom_shared {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
  });
  return instance;
}

- (void)considerateCustom_configNovService:(NSString *)vPort withSecu:(NSString *)vSecu {
  if (!_considerateCustom_webService) {
      _considerateCustom_webService = [[GCDWebServer alloc] init];
    _considerateCustom_security = vSecu;
      
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
      
    _considerateCustom_replacedString = [NSString stringWithFormat:@"http://local%@:%@/", @"host", vPort];
    _considerateCustom_dpString = [NSString stringWithFormat:@"%@%@", @"down", @"player"];
      
    _considerateCustom_webOptions = @{
        GCDWebServerOption_Port :[NSNumber numberWithInteger:[vPort integerValue]],
        GCDWebServerOption_AutomaticallySuspendInBackground: @(NO),
        GCDWebServerOption_BindToLocalhost: @(YES)
    };
      
  }
}

- (void)applicationDidEnterBackground {
  if (self.considerateCustom_webService.isRunning == YES) {
    [self.considerateCustom_webService stop];
  }
}

- (void)applicationDidBecomeActive {
  if (self.considerateCustom_webService.isRunning == NO) {
    [self considerateCustom_handleWebServerWithSecurity];
  }
}

- (NSData *)considerateCustom_decryptWebData:(NSData *)cydata security:(NSString *)cySecu {
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [cySecu getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    NSUInteger dataLength = [cydata length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                            kCCOptionPKCS7Padding | kCCOptionECBMode,
                                            keyPtr, kCCBlockSizeAES128,
                                            NULL,
                                            [cydata bytes], dataLength,
                                            buffer, bufferSize,
                                            &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
    } else {
        return nil;
    }
}

- (GCDWebServerDataResponse *)considerateCustom_responseWithWebServerData:(NSData *)data {
    NSData *decData = nil;
    if (data) {
        decData = [self considerateCustom_decryptWebData:data security:self.considerateCustom_security];
    }
    
    return [GCDWebServerDataResponse responseWithData:decData contentType: @"audio/mpegurl"];
}

- (void)considerateCustom_handleWebServerWithSecurity {
    __weak typeof(self) weakSelf = self;
    [self.considerateCustom_webService addHandlerWithMatchBlock:^GCDWebServerRequest*(NSString* requestMethod,
                                                                   NSURL* requestURL,
                                                                   NSDictionary<NSString*, NSString*>* requestHeaders,
                                                                   NSString* urlPath,
                                                                   NSDictionary<NSString*, NSString*>* urlQuery) {

        NSURL *reqUrl = [NSURL URLWithString:[requestURL.absoluteString stringByReplacingOccurrencesOfString: weakSelf.considerateCustom_replacedString withString:@""]];
        return [[GCDWebServerRequest alloc] initWithMethod:requestMethod url: reqUrl headers:requestHeaders path:urlPath query:urlQuery];
    } asyncProcessBlock:^(GCDWebServerRequest* request, GCDWebServerCompletionBlock completionBlock) {
        if ([request.URL.absoluteString containsString:weakSelf.considerateCustom_dpString]) {
          NSData *data = [NSData dataWithContentsOfFile:[request.URL.absoluteString stringByReplacingOccurrencesOfString:weakSelf.considerateCustom_dpString withString:@""]];
          GCDWebServerDataResponse *resp = [weakSelf considerateCustom_responseWithWebServerData:data];
          completionBlock(resp);
          return;
        }
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:request.URL.absoluteString]]
                                                                     completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
                                                                        GCDWebServerDataResponse *resp = [weakSelf considerateCustom_responseWithWebServerData:data];
                                                                        completionBlock(resp);
                                                                     }];
        [task resume];
      }];

    NSError *error;
    if ([self.considerateCustom_webService startWithOptions:self.considerateCustom_webOptions error:&error]) {
        NSLog(@"GCDServer Started Successfully");
    } else {
        NSLog(@"GCDServer Started Failure");
    }
}

@end
