//
//  MP4Tags.h
//  CocoaMP4v2
//
//  Created by Brian Olsen on 03/02/13.
//  Copyright 2013 Maven-Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaMP4v2/mp4v2.h>
#import <CocoaMP4v2/MP4Rating.h>

@interface MP4Metadata : NSObject {
    id cache;
    id storage;
}

@property(readonly,copy,nonatomic) NSString* name;
@property(readonly,copy,nonatomic) NSString* artist;
@property(readonly,copy,nonatomic) NSString* albumArtist; 
@property(readonly,copy,nonatomic) NSString* album;
@property(readonly,copy,nonatomic) NSString* grouping;
@property(readonly,copy,nonatomic) NSString* composer;
@property(readonly,copy,nonatomic) NSString* comments;
@property(readonly,copy,nonatomic) NSString* genre;
@property(readonly,assign,nonatomic) uint16_t* genreType; // uint16_t
@property(readonly,copy,nonatomic) NSString* releaseDate;

@property(readonly,assign,nonatomic) uint16_t* trackIndex; // uint16_t
@property(readonly,assign,nonatomic) uint16_t* trackTotal; // uint16_t
@property(readonly,assign,nonatomic) uint16_t* discIndex; // uint16_t
@property(readonly,assign,nonatomic) uint16_t* discTotal; // uint16_t
@property(readonly,assign,nonatomic) uint16_t* tempo; // uint16_t
@property(readonly,assign,nonatomic) uint8_t* compilation; // uint8_t

@property(readonly,copy,nonatomic) NSString* tvShow;
@property(readonly,copy,nonatomic) NSString* tvNetwork;
@property(readonly,copy,nonatomic) NSString* tvEpisodeID;
@property(readonly,assign,nonatomic) uint32_t* tvSeason; // uint32_t
@property(readonly,assign,nonatomic) uint32_t* tvEpisode; // uint32_t

@property(readonly,copy,nonatomic) NSString* description;
@property(readonly,copy,nonatomic) NSString* longDescription;
@property(readonly,copy,nonatomic) NSString* lyrics;

@property(readonly,copy,nonatomic) NSString* sortName;
@property(readonly,copy,nonatomic) NSString* sortArtist;
@property(readonly,copy,nonatomic) NSString* sortAlbumArtist;
@property(readonly,copy,nonatomic) NSString* sortAlbum;
@property(readonly,copy,nonatomic) NSString* sortComposer;
@property(readonly,copy,nonatomic) NSString* sortTVShow;

@property(readonly,copy,nonatomic) NSArray* artwork;

@property(readonly,copy,nonatomic) NSString* copyright;
@property(readonly,copy,nonatomic) NSString* encodingTool;
@property(readonly,copy,nonatomic) NSString* encodedBy;
@property(readonly,copy,nonatomic) NSString* purchaseDate;

@property(readonly,assign,nonatomic) uint8_t* podcast; // uint8_t
@property(readonly,copy,nonatomic) NSString* keywords;
@property(readonly,copy,nonatomic) NSString* category;    

@property(readonly,assign,nonatomic) uint8_t* hdVideo; // uint8_t
@property(readonly,assign,nonatomic) MP4MediaType* mediaType; // uint8_t
@property(readonly,assign,nonatomic) uint8_t* contentRating; // uint8_t
@property(readonly,assign,nonatomic) uint8_t* gapless; // uint8_t

@property(readonly,copy,nonatomic) NSString* iTunesAccount;
@property(readonly,assign,nonatomic) uint8_t* iTunesAccountType; // uint8_t
@property(readonly,assign,nonatomic) uint32_t* iTunesCountry; // uint32_t
@property(readonly,assign,nonatomic) uint32_t* contentID; // uint32_t
@property(readonly,assign,nonatomic) uint32_t* artistID; // uint32_t
@property(readonly,assign,nonatomic) uint64_t* playlistID; // uint64_t
@property(readonly,assign,nonatomic) uint32_t* genreID; // uint32_t
@property(readonly,assign,nonatomic) uint32_t* composerID; // uint32_t
@property(readonly,copy,nonatomic) NSString* xid;


// Tags from the com.apple.iTunes;iTunMOVI atom
@property(readonly,copy,nonatomic) NSArray* cast;
@property(readonly,copy,nonatomic) NSArray* directors;
@property(readonly,copy,nonatomic) NSArray* codirectors;
@property(readonly,copy,nonatomic) NSArray* producers;
@property(readonly,copy,nonatomic) NSArray* screenwriters;
@property(readonly,copy,nonatomic) NSString* studio;
@property(readonly,copy,nonatomic) NSString* piracyWarning;

@property(readonly,copy,nonatomic) MP4Rating* rating;

// Tags read directly using itmf API
@property(readonly,copy,nonatomic) NSString* iTunesSubTitle;
@property(readonly,copy,nonatomic) NSString* songDescription;
@property(readonly,copy,nonatomic) NSString* artDirector;
@property(readonly,copy,nonatomic) NSString* arranger;
@property(readonly,copy,nonatomic) NSString* lyricist;
@property(readonly,copy,nonatomic) NSString* acknowledgement;
@property(readonly,copy,nonatomic) NSString* conductor;
@property(readonly,copy,nonatomic) NSString* linearNotes;
@property(readonly,copy,nonatomic) NSString* recordCompany;
@property(readonly,copy,nonatomic) NSString* originalArtist;
@property(readonly,copy,nonatomic) NSString* phonogram;
@property(readonly,copy,nonatomic) NSString* producer;
@property(readonly,copy,nonatomic) NSString* performer;
@property(readonly,copy,nonatomic) NSString* publisher;
@property(readonly,copy,nonatomic) NSString* soundEngineer;
@property(readonly,copy,nonatomic) NSString* soloist;
@property(readonly,copy,nonatomic) NSString* credits;
@property(readonly,copy,nonatomic) NSString* thanks;
@property(readonly,copy,nonatomic) NSString* onlineExtras;
@property(readonly,copy,nonatomic) NSString* executive;
@property(readonly,copy,nonatomic) NSString* seasonDescription;


- (NSArray *)tagNames;
- (NSArray *)itmf;

@end
