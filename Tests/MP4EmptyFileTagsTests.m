//
//  MP4EmptyFileTagsTests.m
//  CocoaMP4v2
//
//  Created by Brian Olsen on 23/02/14.
//
//

#import "MP4EmptyFileTagsTests.h"

@implementation MP4EmptyFileTagsTests

- (void)setUp
{
    [super setUp];
    NSString* resourcePath = [[NSBundle bundleForClass:[self class]] resourcePath];
    file = [[MP4File alloc] initWithFileName:[resourcePath stringByAppendingPathComponent:@"Empty.m4v"]];
    topic = [file metadata];
}

@end
