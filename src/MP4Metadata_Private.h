//
//  MP4Metadata_Private.h
//  CocoaMP4v2
//
//  Created by Brian Olsen on 20/02/14.
//
//
#import "MP4Metadata.h"

@interface MP4Metadata()

- (id)initWithFileHandler:(void *)fileHandler;
- (id)storageValueForKey:(NSString *)key;

@end
