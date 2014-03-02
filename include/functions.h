//
//  general.h
//  CocoaMP4v2
//
//  Created by Brian Olsen on 02/03/14.
//
//

#import <Foundation/Foundation.h>


typedef enum : uint8_t
{
    MP4HomeMovieMediaType = 0,
    MP4MusicMediaType = 1,
    MP4AudiobookMediaType = 2,
    MP4MusicVideoMediaType = 6,
    MP4MovieMediaType = 9,
    MP4TVShowMediaType = 10,
    MP4BookletMediaType = 11,
    MP4RingtoneMediaType = 14,
    MP4PodcastMediaType = 21,
    MP4iTunesUMediaType = 23
} MP4MediaType;

NSString* MP4MediaTypeToString(MP4MediaType mediaType);

#define kMP4ItmfHandledCodes @"©st3", @"©des", \
    @"©ard", @"©arg", @"©aut", @"©cak", \
    @"©con", @"©lnt", @"©mak", @"©ope", \
    @"©phg", @"©prd", @"©prf", @"©pub", @"©sne", \
    @"©sol", @"©src", @"©thx", @"©url", @"©xpd", \
    @"sdes", \
    nil

#define kMP4ItmfHandledNames @"iTunesSubTitle", @"songDescription", \
    @"artDirector", @"arranger", @"lyricist", @"acknowledgement", \
    @"conductor", @"linearNotes", @"recordCompany", @"originalArtist", \
    @"phonogram", @"producer", @"performer", @"publisher", @"soundEngineer", \
    @"soloist", @"credits", @"thanks", @"onlineExtras", @"executive", \
    @"seasonDescription", \
    nil


#define kMP4KnownItmfCodes @"©nam", @"©ART", @"aART", @"©alb", \
    @"©grp", @"©wrt", @"©cmt", @"gnre", @"©gen", \
    @"©day", @"trkn", @"disk", @"tmpo", @"cpil", \
    @"tvsh", @"tvnn", @"tven", @"tvsn", @"tves", \
    @"desc", @"ldes", @"©lyr", \
    @"sonm", @"soar", @"soaa", @"soal", \
    @"soco", @"sosn", \
    @"covr", \
    @"cprt", @"©too", @"©enc", @"purd", \
    @"pcst", @"keyw", @"catg", \
    @"hdvd", @"stik", @"rtng", @"pgap", \
    @"apID", @"akID", @"sfID", @"cnID", \
    @"atID", @"plID", @"geID", @"cmID", @"xid ", nil

#define kMP4KnownItmfCodeNames @"name", @"artist", @"albumArtist", @"album", \
    @"grouping", @"composer", @"comments", @"genre", @"genreType", \
    @"releaseDate", @"track", @"disc", @"tempo", @"compilation", \
    @"tvShow", @"tvNetwork", @"tvEpisodeID", @"tvSeason", @"tvEpisode", \
    @"description", @"longDescription", @"lyrics", \
    @"sortName", @"sortArtist", @"sortAlbumArtist", @"sortAlbum", \
    @"sortComposer", @"sortTVShow", \
    @"artwork", \
    @"copyright", @"encodingTool", @"encodedBy", @"purchaseDate", \
    @"podcast", @"keywords", @"category", \
    @"hdVideo", @"mediaType", @"contentRating", @"gapless", \
    @"iTunesAccount", @"iTunesAccountType", @"iTunesCountry", @"contentID", \
    @"artistID", @"playlistID", @"genreID", @"composerID", @"xid ", \
    @"iTunesSubTitle", @"songDescription", @"artDirector", @"arranger", \
    @"lyricist", @"acknowledgement", @"conductor", @"linearNotes", \
    @"recordCompany", @"originalArtist", @"phonogram", @"producer", \
    @"performer", @"publisher", @"soundEngineer", @"soloist", @"credits", \
    @"thanks", @"onlineExtras", @"executive", @"seasonDescription", nil


