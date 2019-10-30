#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "KJPlayer.h"
#import "KJPlayerURLConnection.h"
#import "KJRequestTask.h"
#import "KJPlayerTool.h"

FOUNDATION_EXPORT double KJPlayerVersionNumber;
FOUNDATION_EXPORT const unsigned char KJPlayerVersionString[];

