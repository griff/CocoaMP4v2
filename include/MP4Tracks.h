//
//  MP4Tracks.h
//  CocoaMP4v2
//
//  Created by Brian Olsen on 06/12/12.
//  Copyright 2012 Maven-Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MP4File.h"

@interface MP4Tracks : NSMutableArray {
    MP4File* owner;
    NSMutableArray* store;
}

- (NSUInteger)count;
- (id)objectAtIndex:(NSUInteger)index;


- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)addObject:(id)anObject;
- (void)removeLastObject;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

@end
