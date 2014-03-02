//
//  MP4Tags.m
//  CocoaMP4v2
//
//  Created by Brian Olsen on 03/02/13.
//  Copyright 2013 Maven-Group. All rights reserved.
//

#import "MP4Metadata.h"
#import "MP4Internal.h"
#import "MP4MetadataItmf_Private.h"

#define PROPERTYIMPL(NAME) - (NSString *)NAME { \
    return [self storageValueForKey:@"" #NAME]; \
}

#define PROPERTYIMPLARRAY(NAME) - (NSArray *)NAME { \
return [self storageValueForKey:@"" #NAME]; \
}

#define PROPERTYIMPLINT(NAME, RETURNTYPE, GETTER) - (RETURNTYPE *)NAME { \
    NSNumber* n = [self storageValueForKey:@"" #NAME]; \
    if(!n) \
        return NULL; \
    ((MP4TagsCache*)cache)->NAME = [n GETTER]; \
    return &(((MP4TagsCache*)cache)->NAME); \
}
#define PROPERTYIMPLUI8(NAME) PROPERTYIMPLINT(NAME, uint8_t, unsignedCharValue)
#define PROPERTYIMPLUI16(NAME) PROPERTYIMPLINT(NAME, uint16_t, unsignedShortValue)
#define PROPERTYIMPLUI32(NAME) PROPERTYIMPLINT(NAME, uint32_t, unsignedIntValue)
#define PROPERTYIMPLUI64(NAME) PROPERTYIMPLINT(NAME, uint64_t, unsignedLongLongValue)

#define PROPERTYIMPLUI8ENUM(NAME, RETURNTYPE) PROPERTYIMPLINT(NAME, RETURNTYPE, unsignedCharValue)
#define PROPERTYIMPLUI16ENUM(NAME, RETURNTYPE) PROPERTYIMPLINT(NAME, RETURNTYPE, unsignedShortValue)
#define PROPERTYIMPLUI32ENUM(NAME, RETURNTYPE) PROPERTYIMPLINT(NAME, RETURNTYPE, unsignedIntValue)
#define PROPERTYIMPLUI64ENUM(NAME, RETURNTYPE) PROPERTYIMPLINT(NAME, RETURNTYPE, unsignedLongLongValue)

@interface MP4TagsCache : NSObject {
@public
    uint16_t genreType;

    uint16_t trackIndex;
    uint16_t trackTotal;
    uint16_t discIndex;
    uint16_t discTotal;
    uint16_t tempo;
    uint8_t compilation;

    uint32_t tvSeason;
    uint32_t tvEpisode;

    uint8_t podcast;

    uint8_t hdVideo;
    uint8_t mediaType;
    uint8_t contentRating;
    uint8_t gapless;

    uint8_t iTunesAccountType;
    uint32_t iTunesCountry;
    uint32_t contentID;
    uint32_t artistID;
    uint64_t playlistID;
    uint32_t genreID;
    uint32_t composerID;
}
@end

@implementation MP4TagsCache
@end

@implementation MP4Metadata

- (id)init
{
    self = [super init];
    if(self)
    {
        cache = [MP4TagsCache new];
        storage = [[NSDictionary alloc] initWithObjectsAndKeys:[NSArray array], @"itmf", nil];
    }
    return self;
}

- (id)initWithFileHandler:(void *)fileHandler
{
    self = [super init];
    if(self)
    {
        cache = [MP4TagsCache new];
        storage = FetchITMFTags(fileHandler);
    }
    return self;
}

- (void)dealloc
{
    [cache release];
    [storage release];
    [super dealloc];
}

- (NSArray *)tagNames {
    return [NSArray arrayWithObjects:@"name", @"artist", nil];
}

- (id)storageValueForKey:(NSString *)key
{
    return [storage objectForKey:key];
}

PROPERTYIMPL(name)
PROPERTYIMPL(artist)
PROPERTYIMPL(albumArtist)
PROPERTYIMPL(album)
PROPERTYIMPL(grouping)
PROPERTYIMPL(composer)
PROPERTYIMPL(comments)
PROPERTYIMPL(genre)
PROPERTYIMPLUI16(genreType)
PROPERTYIMPL(releaseDate)

PROPERTYIMPLUI16(trackIndex)
PROPERTYIMPLUI16(trackTotal)
PROPERTYIMPLUI16(discIndex)
PROPERTYIMPLUI16(discTotal)
PROPERTYIMPLUI16(tempo)
PROPERTYIMPLUI8(compilation)

PROPERTYIMPL(tvShow)
PROPERTYIMPL(tvNetwork)
PROPERTYIMPL(tvEpisodeID)
PROPERTYIMPLUI32(tvSeason)
PROPERTYIMPLUI32(tvEpisode)

PROPERTYIMPL(description)
PROPERTYIMPL(longDescription)
PROPERTYIMPL(lyrics)

PROPERTYIMPL(sortName)
PROPERTYIMPL(sortArtist)
PROPERTYIMPL(sortAlbumArtist)
PROPERTYIMPL(sortAlbum)
PROPERTYIMPL(sortComposer)
PROPERTYIMPL(sortTVShow)

- (NSArray *)artwork;
{
    return [NSArray array];
}

PROPERTYIMPL(copyright)
PROPERTYIMPL(encodingTool)
PROPERTYIMPL(encodedBy)
PROPERTYIMPL(purchaseDate)

PROPERTYIMPLUI8(podcast)
PROPERTYIMPL(keywords)
PROPERTYIMPL(category)

PROPERTYIMPLUI8(hdVideo)
PROPERTYIMPLUI8ENUM(mediaType, MP4MediaType)
PROPERTYIMPLUI8(contentRating)
PROPERTYIMPLUI8(gapless)

PROPERTYIMPL(iTunesAccount)
PROPERTYIMPLUI8(iTunesAccountType)
PROPERTYIMPLUI32(iTunesCountry)
PROPERTYIMPLUI32(contentID)
PROPERTYIMPLUI32(artistID)
PROPERTYIMPLUI64(playlistID)
PROPERTYIMPLUI32(genreID)
PROPERTYIMPLUI32(composerID)
PROPERTYIMPL(xid)


// Tags from the com.apple.iTunes;iTunMOVI atom
PROPERTYIMPLARRAY(cast)
PROPERTYIMPLARRAY(directors)
PROPERTYIMPLARRAY(codirectors)
PROPERTYIMPLARRAY(producers)
PROPERTYIMPLARRAY(screenwriters)
PROPERTYIMPL(studio)
PROPERTYIMPL(piracyWarning)

PROPERTYIMPL(iTunesSubTitle)
PROPERTYIMPL(songDescription)
PROPERTYIMPL(artDirector)
PROPERTYIMPL(arranger)
PROPERTYIMPL(lyricist)
PROPERTYIMPL(acknowledgement)
PROPERTYIMPL(conductor)
PROPERTYIMPL(linearNotes)
PROPERTYIMPL(recordCompany)
PROPERTYIMPL(originalArtist)
PROPERTYIMPL(phonogram)
PROPERTYIMPL(producer)
PROPERTYIMPL(performer)
PROPERTYIMPL(publisher)
PROPERTYIMPL(soundEngineer)
PROPERTYIMPL(soloist)
PROPERTYIMPL(credits)
PROPERTYIMPL(thanks)
PROPERTYIMPL(onlineExtras)
PROPERTYIMPL(executive)
PROPERTYIMPL(seasonDescription)

- (NSArray *)itmf
{
    return [storage objectForKey:@"itmf"];
}

@end


