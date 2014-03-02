//
//  MP4Internal.m
//  CocoaMP4v2
//
//  Created by Brian Olsen on 17/02/14.
//
//

#import "MP4Internal.h"
#import "MP4MetadataItmf_Private.h"
#include <CocoaMP4v2/mp4v2.h>
#include <CocoaMP4v2/MP4Rating.h>

NSString* convertCharData(const char* data)
{
    NSString* ret;
    
    ret = [NSString stringWithUTF8String:data];
    if(!ret)
        ret = [NSString stringWithCString:data encoding:NSASCIIStringEncoding];
    if(!ret)
        ret = @"";
    return ret;
}

#define STORETAGIMPL(NAME) \
    if(tags->NAME != NULL) \
        [dict setObject:convertCharData(tags->NAME) forKey:@"" #NAME]

#define STORETAGIMPLINT(NAME, RETURNTYPE, GETTER) \
    if(tags->NAME != NULL) { \
        NSNumber* value = [NSNumber GETTER:*tags->NAME]; \
        [dict setObject:value forKey:@"" #NAME]; \
    }

#define STORETAGIMPLUI8(NAME) STORETAGIMPLINT(NAME, uint8_t, numberWithUnsignedChar)
#define STORETAGIMPLUI16(NAME) STORETAGIMPLINT(NAME, uint16_t, numberWithUnsignedShort)
#define STORETAGIMPLUI32(NAME) STORETAGIMPLINT(NAME, uint32_t, numberWithUnsignedInt)
#define STORETAGIMPLUI64(NAME) STORETAGIMPLINT(NAME, uint64_t, numberWithUnsignedLongLong)

NSArray* ExtractNames(NSArray* items)
{
    NSMutableArray* ret = [NSMutableArray arrayWithCapacity:[items count]];
    for(NSDictionary* item in items)
        [ret addObject:[item objectForKey:@"name"]];
    return [NSArray arrayWithArray:ret];
}

NSDictionary* FetchITMFTags(void* file)
{
    NSSet* ignored = [NSSet setWithObjects:kMP4KnownItmfCodes];
    
    NSDictionary* itmfHandles =
        [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:kMP4ItmfHandledNames]
                                    forKeys:[NSArray arrayWithObjects:kMP4ItmfHandledCodes]];
    
    NSMutableDictionary* dict = [NSMutableDictionary new];
    const MP4Tags* tags = MP4TagsAlloc();
    MP4FileHandle mp4 = (MP4FileHandle)file;
    MP4TagsFetch(tags, mp4);
    
    STORETAGIMPL(name);
    STORETAGIMPL(artist);
    STORETAGIMPL(albumArtist);
    STORETAGIMPL(album);
    STORETAGIMPL(grouping);
    STORETAGIMPL(composer);
    STORETAGIMPL(comments);
    STORETAGIMPL(genre);
    STORETAGIMPLUI16(genreType);
    STORETAGIMPL(releaseDate);
    if(tags->track != NULL) {
        [dict setObject:[NSNumber numberWithUnsignedShort:tags->track->index] forKey:@"trackIndex"];
        [dict setObject:[NSNumber numberWithUnsignedShort:tags->track->total] forKey:@"trackTotal"];
    }
    if(tags->disk != NULL) {
        [dict setObject:[NSNumber numberWithUnsignedShort:tags->disk->index] forKey:@"discIndex"];
        [dict setObject:[NSNumber numberWithUnsignedShort:tags->disk->total] forKey:@"discTotal"];
    }
    STORETAGIMPLUI16(tempo);
    STORETAGIMPLUI8(compilation);

    STORETAGIMPL(tvShow);
    STORETAGIMPL(tvNetwork);
    STORETAGIMPL(tvEpisodeID);
    STORETAGIMPLUI32(tvSeason);
    STORETAGIMPLUI32(tvEpisode);

    STORETAGIMPL(description);
    STORETAGIMPL(longDescription);
    STORETAGIMPL(lyrics);

    STORETAGIMPL(sortName);
    STORETAGIMPL(sortArtist);
    STORETAGIMPL(sortAlbumArtist);
    STORETAGIMPL(sortAlbum);
    STORETAGIMPL(sortComposer);
    STORETAGIMPL(sortTVShow);

    NSMutableArray* artwork = [NSMutableArray arrayWithCapacity:tags->artworkCount];
    for(NSUInteger i=0; i<tags->artworkCount; i++)
    {
        const MP4TagArtwork* current = tags->artwork + i;
        NSData* data = [NSData dataWithBytes:current->data length:current->size];
        NSImage* image = [[NSImage alloc] initWithData:data];
        [artwork addObject:image];
        [image release];
    }
    [dict setObject:[NSArray arrayWithArray:artwork] forKey:@"artwork"];

    STORETAGIMPL(copyright);
    STORETAGIMPL(encodingTool);
    STORETAGIMPL(encodedBy);
    STORETAGIMPL(purchaseDate);

    STORETAGIMPLUI8(podcast);
    STORETAGIMPL(keywords);
    STORETAGIMPL(category);

    STORETAGIMPLUI8(hdVideo);
    STORETAGIMPLUI8(mediaType);
    STORETAGIMPLUI8(contentRating);
    STORETAGIMPLUI8(gapless);

    STORETAGIMPL(iTunesAccount);
    STORETAGIMPLUI8(iTunesAccountType);
    STORETAGIMPLUI32(iTunesCountry);
    STORETAGIMPLUI32(contentID);
    STORETAGIMPLUI32(artistID);
    STORETAGIMPLUI64(playlistID);
    STORETAGIMPLUI32(genreID);
    STORETAGIMPLUI32(composerID);
    STORETAGIMPL(xid);
    
    MP4TagsFree(tags);
    
    MP4ItmfItemList* list = MP4ItmfGetItemsByMeaning(file, "com.apple.iTunes", "iTunMOVI");
    if(list) {
        for(uint32_t i=0; i < list->size; i++)
        {
            MP4ItmfItem* item = &list->elements[i];
            for(uint32_t y=0; y < item->dataList.size; y++)
            {
                MP4ItmfData* data = &item->dataList.elements[y];
                NSData* iTunMOVIData = [NSData dataWithBytes:data->value length:data->valueSize];
                NSDictionary* iTunMOVI =
                    [NSPropertyListSerialization propertyListWithData:iTunMOVIData
                                                              options:NSPropertyListImmutable
                                                               format:NULL
                                                                error:NULL];
                if([[iTunMOVI objectForKey:@"cast"] count])
                    [dict setObject:ExtractNames([iTunMOVI objectForKey:@"cast"]) forKey:@"cast"];
                if([[iTunMOVI objectForKey:@"directors"] count])
                    [dict setObject:ExtractNames([iTunMOVI objectForKey:@"directors"]) forKey:@"directors"];
                if([[iTunMOVI objectForKey:@"codirectors"] count])
                    [dict setObject:ExtractNames([iTunMOVI objectForKey:@"codirectors"]) forKey:@"codirectors"];
                if([[iTunMOVI objectForKey:@"producers"] count])
                    [dict setObject:ExtractNames([iTunMOVI objectForKey:@"producers"]) forKey:@"producers"];
                if([[iTunMOVI objectForKey:@"screenwriters"] count])
                    [dict setObject:ExtractNames([iTunMOVI objectForKey:@"screenwriters"]) forKey:@"screenwriters"];
                if([[iTunMOVI objectForKey:@"studio"] length])
                    [dict setObject:[iTunMOVI objectForKey:@"studio"] forKey:@"studio"];
                if([[iTunMOVI objectForKey:@"copy-warning"] length])
                    [dict setObject:[iTunMOVI objectForKey:@"copy-warning"] forKey:@"piracyWarning"];
            }
        }
        MP4ItmfItemListFree(list);
    }
    
    list = MP4ItmfGetItemsByMeaning(file, "com.apple.iTunes", "iTunEXTC");
    if(list) {
        for(uint32_t i=0; i < list->size; i++)
        {
            MP4ItmfItem* item = &list->elements[i];
            for(uint32_t y=0; y < item->dataList.size; y++)
            {
                MP4ItmfData* data = &item->dataList.elements[y];
                NSData* iTunMOVIData = [NSData dataWithBytes:data->value length:data->valueSize];
                NSDictionary* iTunMOVI =
                [NSPropertyListSerialization propertyListWithData:iTunMOVIData
                                                          options:NSPropertyListImmutable
                                                           format:NULL
                                                            error:NULL];
                if([[iTunMOVI objectForKey:@"cast"] count])
                    [dict setObject:ExtractNames([iTunMOVI objectForKey:@"cast"]) forKey:@"cast"];
                if([[iTunMOVI objectForKey:@"directors"] count])
                    [dict setObject:ExtractNames([iTunMOVI objectForKey:@"directors"]) forKey:@"directors"];
                if([[iTunMOVI objectForKey:@"codirectors"] count])
                    [dict setObject:ExtractNames([iTunMOVI objectForKey:@"codirectors"]) forKey:@"codirectors"];
                if([[iTunMOVI objectForKey:@"producers"] count])
                    [dict setObject:ExtractNames([iTunMOVI objectForKey:@"producers"]) forKey:@"producers"];
                if([[iTunMOVI objectForKey:@"screenwriters"] count])
                    [dict setObject:ExtractNames([iTunMOVI objectForKey:@"screenwriters"]) forKey:@"screenwriters"];
                if([[iTunMOVI objectForKey:@"studio"] length])
                    [dict setObject:[iTunMOVI objectForKey:@"studio"] forKey:@"studio"];
                if([[iTunMOVI objectForKey:@"copy-warning"] length])
                    [dict setObject:[iTunMOVI objectForKey:@"copy-warning"] forKey:@"piracyWarning"];
            }
        }
        MP4ItmfItemListFree(list);
    }
    
    list = MP4ItmfGetItems(file);
    if(list) {
        NSMutableArray* items = [NSMutableArray array];
        for(uint32_t i=0; i < list->size; i++)
        {
            MP4ItmfItem* item = &list->elements[i];
            MP4MetadataItmf* itemObj = [MP4MetadataItmf itemWithItmfItem:item];
            
            if(itemObj.reverseDNS &&
               [itemObj.meaning isEqualToString:@"com.apple.iTunes"] &&
               [itemObj.name isEqualToString:@"iTunEXTC"] &&
               [itemObj.dataItems count] == 1)
            {
                MP4MetadataItmfData* data = [itemObj.dataItems objectAtIndex:0];
                if(data.typeCode == MP4_ITMF_BT_UTF8 && data.value) {
                    NSString* ratingStr = [data stringValue];
                    MP4Rating* rating = [MP4Rating ratingWithCode:ratingStr];
                    if(rating)
                        [dict setObject:rating forKey:@"rating"];
                    continue;
                }
                continue;
            }
            NSString* name = [itmfHandles objectForKey:itemObj.code];
            if(name && [itemObj.dataItems count] == 1) {
                MP4MetadataItmfData* data = [itemObj.dataItems objectAtIndex:0];
                if(data.typeCode == MP4_ITMF_BT_UTF8 && data.value) {
                    [dict setObject:[data stringValue] forKey:name];
                    continue;
                }
            }
            if([ignored containsObject:itemObj.code])
                continue;
            if(itemObj.reverseDNS &&
               [ignored containsObject:[NSString stringWithFormat:@"%@;%@", itemObj.meaning, itemObj.name]])
                continue;
            [items addObject:itemObj];
        }
        [dict setObject:[NSArray arrayWithArray:items] forKey:@"itmf"];

        MP4ItmfItemListFree(list);
    }
    
    return dict;
}

void StoreITMFTags(NSDictionary* tags, void* file)
{
    
}
