//
//  MP4MutableTags.h
//  CocoaMP4v2
//
//  Created by Brian Olsen on 04/03/13.
//  Copyright 2013 Maven-Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaMP4v2/MP4Metadata.h>

@interface MP4MutableMetadata : MP4Metadata {
    MP4Metadata* storedData;
}
@property(readonly,nonatomic,getter=isModified) BOOL modified;
@property(readonly,copy,nonatomic)   NSMutableArray* artwork;

- (NSMutableArray *)itmf;

@end
