//
//  general.m
//  CocoaMP4v2
//
//  Created by Brian Olsen on 02/03/14.
//
//

#import "functions.h"


NSString* MP4MediaTypeToString(MP4MediaType mediaType)
{
    switch (mediaType) {
        case MP4HomeMovieMediaType:
            return @"Home Movie";
        case MP4MusicMediaType:
            return @"Music";
        case MP4AudiobookMediaType:
            return @"Audiobook";
        case MP4MusicVideoMediaType:
            return @"Music Video";
        case MP4MovieMediaType:
            return @"Movie";
        case MP4TVShowMediaType:
            return @"TV Show";
        case MP4BookletMediaType:
            return @"Booklet";
        case MP4RingtoneMediaType:
            return @"Ringtone";
        case MP4PodcastMediaType:
            return @"Podcast";
        case MP4iTunesUMediaType:
            return @"iTunesU";
    }
    return [NSString stringWithFormat:@"Media Type %ud", mediaType];
}