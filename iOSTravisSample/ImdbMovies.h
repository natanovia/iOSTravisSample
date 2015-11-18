//
//  ImdbMovies.h
//  iOSTravisSample
//
//  Created by natanovia on 2015/11/18.
//  Copyright © 2015年 suwa-hayato.info. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ImdbMovie.h"

@interface ImdbMovies : JSONModel

@property (strong, nonatomic) NSArray<ImdbMovie, ConvertOnDemand>* items;

@end
