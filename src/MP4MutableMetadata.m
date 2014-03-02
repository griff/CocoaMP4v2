//
//  MP4MutableMetadata.m
//  CocoaMP4v2
//
//  Created by Brian Olsen on 04/03/13.
//  Copyright 2013 Maven-Group. All rights reserved.
//

#import "MP4MutableMetadata.h"
#import "MP4Metadata_Private.h"

@implementation MP4MutableMetadata

- (NSMutableArray *)artwork
{
    return [NSMutableArray array];
}

- (id)storageValueForKey:(NSString *)key
{
    id value = [storage objectForKey:key];
    if(!value)
        value = [storedData storageValueForKey:key];
    return value;
}

@end
