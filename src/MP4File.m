//
//  MP4File.m
//  CocoaMP4v2
//
//  Created by Brian Olsen on 06/12/12.
//  Copyright 2012 Maven-Group. All rights reserved.
//

#import "MP4File.h"
#import "MP4Metadata_Private.h"
#import "mp4v2.h"

@implementation MP4File

- (id)init
{
    self = [super init];
    if(self)
    {
        _metadata = [MP4Metadata new];
        _tracks = [NSArray new];
    }
    return self;
}

- (id)initWithFileName:(NSString *)name
{
    self = [super init];
    if(self)
    {
        MP4FileHandle fileHandler = MP4Read([name UTF8String]);
        _metadata = [[MP4Metadata alloc] initWithFileHandler:fileHandler];
        _tracks = [NSArray new];
        MP4Close(fileHandler, 0);
    }
    return self;
}

- (void)dealloc
{
    [_metadata release];
    [_tracks release];
    [super dealloc];
}

@end
