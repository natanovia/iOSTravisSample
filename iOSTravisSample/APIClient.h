//
//  APIClient.h
//  iOSTravisSample
//
//  Created by natanovia on 2015/11/18.
//  Copyright © 2015年 suwa-hayato.info. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

extern NSString * const kAPIKey;
extern NSString * const kBaseURLString;
extern NSString * const TOP250;

@interface APIClient : AFHTTPSessionManager

+ (APIClient *) sharedClient;

- (void) getTop250:(void(^)(NSURLSessionDataTask *task, id responseObject)) success
           failure:(void(^)(NSURLSessionDataTask *task, NSError *error)) failure;

@end
