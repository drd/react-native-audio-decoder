//
//  AudioDecoder.h
//  Hilights
//
//  Created by Eric O'Connell on 2/9/19.
//  Copyright © 2019 Hilights. All rights reserved.
//

#if __has_include(<React/RCTBridgeModule.h>)
#import <React/RCTBridgeModule.h>
#else
#import "RCTBridgeModule.h"
#endif


#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNAudioDecoder : NSObject <RCTBridgeModule>

@end

NS_ASSUME_NONNULL_END
