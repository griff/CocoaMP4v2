//
//  MP4Internal.h
//  CocoaMP4v2
//
//  Created by Brian Olsen on 17/02/14.
//
//

#import <Foundation/Foundation.h>

NSDictionary* FetchITMFTags(void* file);
void StoreITMFTags(NSDictionary* tags, void* file);
