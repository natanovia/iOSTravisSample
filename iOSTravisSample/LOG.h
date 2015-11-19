//
//  LOG.h
//  iOSTravisSample
//
//  Created by natanovia on 2015/11/19.
//  Copyright © 2015年 suwa-hayato.info. All rights reserved.
//

#import <CocoaLumberjack/CocoaLumberjack.h>

// We want to use the following log levels:
//
// Error
// Warn
// Debug
// Info
// Verbose
//
// All we have to do is undefine the default values,
// and then simply define our own however we want.

// undefine the default stuff we don't want to use.
#undef DDLogError
#undef DDLogWarn
#undef DDLogInfo
#undef DDLogDebug
#undef DDLogVerbose

// define everything how we want it
#define LOG_FLAG_ERROR   (1 << 0)  // 0...000001
#define LOG_FLAG_WARN    (1 << 1)  // 0...000010
#define LOG_FLAG_DEBUG   (1 << 2)  // 0...000100
#define LOG_FLAG_INFO    (1 << 3)  // 0...001000
#define LOG_FLAG_VERBOSE (1 << 4)  // 0...010000

#define LOG_LEVEL_ERROR   (LOG_FLAG_ERROR)                                                              // 0...000001
#define LOG_LEVEL_WARN    (LOG_FLAG_WARN|LOG_FLAG_ERROR)                                                // 0...000011
#define LOG_LEVEL_DEBUG   (LOG_FLAG_DEBUG|LOG_FLAG_WARN|LOG_LEVEL_ERROR)                                // 0...000111
#define LOG_LEVEL_INFO    (LOG_FLAG_INFO|LOG_FLAG_DEBUG|LOG_FLAG_WARN|LOG_LEVEL_ERROR)                  // 0...001111
#define LOG_LEVEL_VERBOSE (LOG_FLAG_VERBOSE|LOG_FLAG_INFO|LOG_FLAG_DEBUG|LOG_FLAG_WARN|LOG_LEVEL_ERROR) // 0...011111

#define LOGE(frmt, ...)   LOG_MAYBE(NO,  ddLogLevel, LOG_FLAG_ERROR,   0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define LOGW(frmt, ...)   LOG_MAYBE(YES, ddLogLevel, LOG_FLAG_WARN,    0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define LOGD(frmt, ...)   LOG_MAYBE(YES, ddLogLevel, LOG_FLAG_DEBUG,   0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define LOGI(frmt, ...)   LOG_MAYBE(YES, ddLogLevel, LOG_FLAG_INFO,    0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define LOGV(frmt, ...)   LOG_MAYBE(YES, ddLogLevel, LOG_FLAG_VERBOSE, 0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)

/* LOG_h */
