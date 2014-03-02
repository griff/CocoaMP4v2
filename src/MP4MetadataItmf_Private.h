//
//  MP4MetadataItmf_Private.h
//  CocoaMP4v2
//
//  Created by Brian Olsen on 23/02/14.
//
//

#import "MP4MetadataItmf.h"

@interface MP4MetadataItmf ()

+ (id)itemWithItmfItem:(MP4ItmfItem *)item;
- (id)initWithItmfItem:(MP4ItmfItem *)item;

@end
