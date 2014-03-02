//
//  MP4MutableFile.m
//  CocoaMP4v2
//
//  Created by Brian Olsen on 23/02/14.
//
//

#import "MP4MutableFile.h"
#import <CocoaMP4v2/mp4v2.h>

@implementation MP4MutableFile

- (void)close
{
    MP4Close(fileHandler, 0);
}

- (void)closeWithFlags:(uint32_t)flags
{
    MP4Close(fileHandler, flags);
}

@end
