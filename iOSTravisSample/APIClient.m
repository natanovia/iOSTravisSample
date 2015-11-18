//
//  APIClient.m
//  iOSTravisSample
//
//  Created by natanovia on 2015/11/18.
//  Copyright © 2015年 suwa-hayato.info. All rights reserved.
//

#import "APIClient.h"

// Set this to your API key
NSString * const kAPIKey = @"iphone1";
NSString * const kBaseURLString = @"http://app.imdb.com/";
NSString * const kTOP250 = @"chart/top";

@implementation APIClient

+ (APIClient *) sharedClient {
    
    static APIClient * _sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kBaseURLString]];
    });
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    return self;
}

- (void) getTop250:(void(^)(NSURLSessionDataTask *task, id responseObject)) success
           failure:(void(^)(NSURLSessionDataTask *task, NSError *error)) failure {
    
    NSString* path = [NSString stringWithFormat:@"%@?api=v1&appid=%@", kTOP250, kAPIKey];
    [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ( success ) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ( error ) {
            failure(task, error);
        }
    }];
}

@end
