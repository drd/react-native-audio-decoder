#import "RNAudioDecoder.h"
#import <Accelerate/Accelerate.h>

@implementation RNAudioDecoder

RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
}

RCT_REMAP_METHOD(decodeFileAtPath,
                 decodeFileAtPath: (NSString *)path
                 withResolver: (RCTPromiseResolveBlock)resolve
                 rejecter:( RCTPromiseRejectBlock)reject)
{
    NSURL *mediaUrl = [NSURL fileURLWithPath:path];
    AVAsset *asset = [AVAsset assetWithURL:mediaUrl];
    
    NSError *error;
    AVAssetReader *assetReader = [AVAssetReader assetReaderWithAsset:asset
                                                               error:&error];
    if (error != nil) {
        reject(@"init_reader_fail", @"Couldn't initialize AVAssetReader", error);
    }
    
    NSDictionary *outputSettings = @{AVFormatIDKey: @(kAudioFormatLinearPCM),
                                     AVSampleRateKey: @44100,
                                     AVNumberOfChannelsKey: @1,
                                     AVLinearPCMBitDepthKey: @16,
                                     AVLinearPCMIsNonInterleaved: @YES,
                                     AVLinearPCMIsFloatKey: @NO,
                                     AVLinearPCMIsBigEndianKey: @NO};
    AVAssetReaderTrackOutput *trackOutput = [AVAssetReaderTrackOutput assetReaderTrackOutputWithTrack: asset.tracks[0]
                                                                                       outputSettings: outputSettings];
    [assetReader addOutput: trackOutput];
    if (![assetReader startReading]) {
        error = [NSError errorWithDomain:@"hilights"
                                    code:-1
                                userInfo:@{@"mediaPath": path}];
        reject(@"start_reading_fail", @"Couldn't initialize AVAssetReader", error);
    }
    
    NSMutableArray *processed = [NSMutableArray array];
    CMSampleBufferRef buffer;
    while ((buffer = [trackOutput copyNextSampleBuffer]) && buffer != nil) {
        if (CMSampleBufferGetNumSamples(buffer) == 0) {
            break;
        }
        
        CMBlockBufferRef blockRef = CMSampleBufferGetDataBuffer(buffer);
        if (blockRef == nil) {
            error = [NSError errorWithDomain:@"hilights"
                                        code:-2
                                    userInfo:@{@"mediaPath": path}];
            reject(@"bad_block", @"Unable to get block buffer", error);
        }
        
        size_t blockSize = CMBlockBufferGetDataLength(blockRef);
        int16_t *samples = malloc(blockSize * sizeof(int16_t));
        
        if (samples == nil) {
            error = [NSError errorWithDomain:@"hilights"
                                        code:-3
                                    userInfo:@{@"mediaPath": path}];
            reject(@"bad_block", @"Unable to allocate sample buffer", error);
        }
        OSStatus result;
        if ((result = CMBlockBufferCopyDataBytes(blockRef, 0, blockSize, samples)) != kCMBlockBufferNoErr) {
            error = [NSError errorWithDomain:@"hilights"
                                        code:result
                                    userInfo:@{@"mediaPath": path}];
            reject(@"bad_block", @"Unable to allocate sample buffer", error);
        }
        
        float *converted = malloc(blockSize * sizeof(float));
        if (samples == nil) {
            error = [NSError errorWithDomain:@"hilights"
                                        code:-4
                                    userInfo:@{@"mediaPath": path}];
            reject(@"bad_block", @"Unable to allocate float buffer", error);
        }
        
        vDSP_vflt16(samples, 1, converted, 1, blockSize);
        
        for (int i = 0; i < blockSize; i++) {
            [processed addObject: [NSNumber numberWithFloat: converted[i]]];
        }
        
        free(converted);
        free(samples);
    }
    
    resolve(processed);
}

@end
