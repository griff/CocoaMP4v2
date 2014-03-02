//
//  MP4Tracks.m
//  CocoaMP4v2
//
//  Created by Brian Olsen on 06/12/12.
//  Copyright 2012 Maven-Group. All rights reserved.
//

#import "MP4Tracks.h"


@implementation MP4Tracks

- (id)initWithFile:(MP4File *)file
{
    self = [super init];
    if(self)
    {
        store = [[NSMutableArray alloc] init];
        owner = file;
    }
    return self;
}

- (void)dealloc
{
    [store release];
    [super dealloc];
}

- (NSUInteger)count;
{
    return [store count];
}

- (id)objectAtIndex:(NSUInteger)index;
{
    return [store objectAtIndex:index];
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
{
    
}

- (void)removeObjectAtIndex:(NSUInteger)index;
{
}

- (void)addObject:(id)anObject;
{
}
- (void)removeLastObject;
{
}
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
{
}

@end
