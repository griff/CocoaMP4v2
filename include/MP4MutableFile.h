//
//  MP4MutableFile.h
//  CocoaMP4v2
//
//  Created by Brian Olsen on 23/02/14.
//
//

#import <Foundation/Foundation.h>
#import <CocoaMP4v2/MP4File.h>
#import <CocoaMP4v2/MP4MutableMetadata.h>
#import <CocoaMP4v2/MP4Tracks.h>

@interface MP4MutableFile : MP4File {
    void* fileHandler;
}

@property(readonly) MP4MutableMetadata* metadata;
@property(readonly) MP4Tracks* tracks;

- (void)close;

@end
