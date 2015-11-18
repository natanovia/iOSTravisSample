//
//  ImdbMovies.m
//  iOSTravisSample
//
//  Created by natanovia on 2015/11/18.
//  Copyright © 2015年 suwa-hayato.info. All rights reserved.
//

#import "ImdbMovies.h"

@implementation ImdbMovies

+(JSONKeyMapper*)keyMapper {
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"data.list.list": @"items"
                                                       }];
}

@end
