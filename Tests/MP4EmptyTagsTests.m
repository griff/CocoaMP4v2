//
//  MP4MetaDataTests.mm
//  CocoaMP4v2
//
//  Created by Brian Olsen on 04/03/13.
//  Copyright 2013 Maven-Group. All rights reserved.
//

#import "MP4EmptyTagsTests.h"

@implementation MP4EmptyTagsTests

- (void)setUp
{
    [super setUp];
    file = [MP4File new];
    topic = [file metadata];
}

- (void)tearDown
{
    [file release];
    [super tearDown];
}

- (void)testHasTags
{
    XCTAssertNotNil(topic);
}

// Require that MP4Tags has an empty name
- (void)testName
{
    XCTAssertNil(topic.name);
}

// Require that MP4Tags has an empty artist
- (void)testArtist {
    XCTAssertNil(topic.artist);
}

// Require that MP4Tags has an empty album artist
- (void)testAlbumArtist {
    XCTAssertNil(topic.albumArtist);
}

// Require that MP4Tags has an empty album
- (void)testAlbum {
    XCTAssertNil(topic.album);
}

// Require that MP4Tags has an empty grouping
- (void)testGrouping {
    XCTAssertNil(topic.grouping);
}

// Require that MP4Tags has an empty composer
- (void)testComposer {
    XCTAssertNil(topic.composer);
}

// Require that MP4Tags has an empty comments
- (void)testComments {
    XCTAssertNil(topic.comments);
}

// Require that MP4Tags has an empty genre
- (void)testGenre {
    XCTAssertNil(topic.genre);
}

// Require that MP4Tags has an empty genre type
- (void)testGenreType {
    XCTAssert(topic.genreType == NULL);
}

// Require that MP4Tags has an empty release date
- (void)testReleaseDate {
    XCTAssertNil(topic.releaseDate);
}


// Require that MP4Tags has an empty track index
- (void)testTrackIndex {
    XCTAssert(topic.trackIndex == NULL);
}

// Require that MP4Tags has an empty track total
- (void)testTrackTotal {
    XCTAssert(topic.trackTotal == NULL);
}

// Require that MP4Tags has an empty disc index
- (void)testDiscIndex {
    XCTAssert(topic.discIndex == NULL);
}

// Require that MP4Tags has an empty disc total
- (void)testDiscTotal {
    XCTAssert(topic.discTotal == NULL);
}

// Require that MP4Tags has an empty tempo
- (void)testTempo {
    XCTAssert(topic.tempo == NULL);
}

// Require that MP4Tags has an empty compilation
- (void)testCompilation {
    XCTAssert(topic.compilation == NULL);
}


// Require that MP4Tags has an empty tv show
- (void)testTvShow {
    XCTAssertNil(topic.tvShow);
}

// Require that MP4Tags has an empty tv network
- (void)testTvNetwork {
    XCTAssertNil(topic.tvNetwork);
}

// Require that MP4Tags has an empty tv episode ID
- (void)testTvEpisodeID {
    XCTAssertNil(topic.tvEpisodeID);
}

// Require that MP4Tags has an empty tv season
- (void)testTvSeason {
    XCTAssert(topic.tvSeason == NULL);
}

// Require that MP4Tags has an empty tv episode
- (void)testTvEpisode {
    XCTAssert(topic.tvEpisode == NULL);
}


// Require that MP4Tags has an empty description
- (void)testDescription {
    XCTAssertNil(topic.description);
}

// Require that MP4Tags has an empty long description
- (void)testLongDescription {
    XCTAssertNil(topic.longDescription);
}

// Require that MP4Tags has an empty lyrics
- (void)testLyrics {
    XCTAssertNil(topic.lyrics);
}


// Require that MP4Tags has an empty sort name
- (void)testSortName {
    XCTAssertNil(topic.sortName);
}

// Require that MP4Tags has an empty sort artist
- (void)testSortArtist {
    XCTAssertNil(topic.sortArtist);
}

// Require that MP4Tags has an empty sort album artist
- (void)testSortAlbumArtist {
    XCTAssertNil(topic.sortAlbumArtist);
}

// Require that MP4Tags has an empty sort album
- (void)testSortAlbum {
    XCTAssertNil(topic.sortAlbum);
}

// Require that MP4Tags has an empty sort composer
- (void)testSortComposer {
    XCTAssertNil(topic.sortComposer);
}

// Require that MP4Tags has an empty sort tv show
- (void)testSortTvShow {
    XCTAssertNil(topic.sortTVShow);
}


// Require that MP4Tags has an empty artwork
- (void)testArtwork {
    XCTAssertNotNil(topic.artwork);
    XCTAssertEqual(topic.artwork, [NSArray array], @"Array not empty");
}


// Require that MP4Tags has an empty copyright
- (void)testCopyright {
    XCTAssertNil(topic.copyright);
}

// Require that MP4Tags has an empty encoding tool
- (void)testEncodingTool {
    XCTAssertNil(topic.encodingTool);
}

// Require that MP4Tags has an empty encoded by
- (void)testEncodedBy {
    XCTAssertNil(topic.encodedBy);
}

// Require that MP4Tags has an empty purchase date
- (void)testPurchaseDate {
    XCTAssertNil(topic.purchaseDate);
}


// Require that MP4Tags has an empty podcast
- (void)testPodcast {
    XCTAssert(topic.podcast == NULL);
}

// Require that MP4Tags has an empty keywords
- (void)testKeywords {
    XCTAssertNil(topic.keywords);
}

// Require that MP4Tags has an empty category
- (void)testCategory {
    XCTAssertNil(topic.category);
}


// Require that MP4Tags has an empty hd video
- (void)testHdVideo {
    XCTAssert(topic.hdVideo == NULL);
}

// Require that MP4Tags has an empty media type
- (void)testMediaType {
    XCTAssert(topic.mediaType == NULL);
}

// Require that MP4Tags has an empty content rating
- (void)testContentRating {
    XCTAssert(topic.contentRating == NULL);
}

// Require that MP4Tags has an empty gapless
- (void)testGapless {
    XCTAssert(topic.gapless == NULL);
}


// Require that MP4Tags has an empty iTunes account
- (void)testiTunesAccount {
    XCTAssertNil(topic.iTunesAccount);
}

// Require that MP4Tags has an empty iTunes account type
- (void)testiTunesAccountType {
    XCTAssert(topic.iTunesAccountType == NULL);
}

// Require that MP4Tags has an empty iTunes country
- (void)testiTunesCountry {
    XCTAssert(topic.iTunesCountry == NULL);
}

// Require that MP4Tags has an empty content ID
- (void)testContentID {
    XCTAssert(topic.contentID == NULL);
}

// Require that MP4Tags has an empty artist ID
- (void)testArtistID {
    XCTAssert(topic.artistID == NULL);
}

// Require that MP4Tags has an empty playlist ID
- (void)testPlaylistID {
    XCTAssert(topic.playlistID == NULL);
}

// Require that MP4Tags has an empty genre ID
- (void)testGenreID {
    XCTAssert(topic.genreID == NULL);
}

// Require that MP4Tags has an empty composer ID
- (void)testComposerID {
    XCTAssert(topic.composerID == NULL);
}

// Require that MP4Tags has an empty xid
- (void)testXid {
    XCTAssertNil(topic.xid);
}

// Require that MP4Tags has an nil cast
- (void)testCast {
    XCTAssertNil(topic.cast);
}

// Require that MP4Tags has an nil directors
- (void)testDirectors {
    XCTAssertNil(topic.directors);
}

// Require that MP4Tags has an nil co-directors
- (void)testCodirectors {
    XCTAssertNil(topic.codirectors);
}

// Require that MP4Tags has an nil producers
- (void)testProducers {
    XCTAssertNil(topic.producers);
}

// Require that MP4Tags has an nil screenwriters
- (void)testScreenwriters {
    XCTAssertNil(topic.screenwriters);
}

// Require that MP4Tags has an nil studio
- (void)testStudio {
    XCTAssertNil(topic.studio);
}

// Require that MP4Tags has an nil piracy warning
- (void)testPiracyWarning {
    XCTAssertNil(topic.piracyWarning);
}


// Require that MP4Tags has an nil iTunes Sub-Title
- (void)testiTunesSubTitle {
    XCTAssertNil(topic.iTunesSubTitle);
}

// Require that MP4Tags has an nil song description
- (void)testSongDescription {
    XCTAssertNil(topic.songDescription);
}

// Require that MP4Tags has an nil art director
- (void)testArtDirectory {
    XCTAssertNil(topic.artDirector);
}

// Require that MP4Tags has an nil arranger
- (void)testArranger {
    XCTAssertNil(topic.arranger);
}

// Require that MP4Tags has an nil lyricist
- (void)testLyricist {
    XCTAssertNil(topic.lyricist);
}

// Require that MP4Tags has nil acknowledgement
- (void)testAcknowledgement {
    XCTAssertNil(topic.acknowledgement);
}

// Require that MP4Tags has an nil conductor
- (void)testConductor {
    XCTAssertNil(topic.conductor);
}

// Require that MP4Tags has an nil linear notes
- (void)testLinearNotes {
    XCTAssertNil(topic.linearNotes);
}

// Require that MP4Tags has an nil record company
- (void)testRecordCompany {
    XCTAssertNil(topic.recordCompany);
}

// Require that MP4Tags has an nil original artist
- (void)testOriginalArtist {
    XCTAssertNil(topic.originalArtist);
}

// Require that MP4Tags has an nil phonogram
- (void)testPhonogram {
    XCTAssertNil(topic.phonogram);
}

// Require that MP4Tags has an nil producer
- (void)testProducer {
    XCTAssertNil(topic.producer);
}

// Require that MP4Tags has an nil performer
- (void)testPerformer {
    XCTAssertNil(topic.performer);
}

// Require that MP4Tags has an nil publisher
- (void)testPublisher {
    XCTAssertNil(topic.publisher);
}

// Require that MP4Tags has an nil sound engineer
- (void)testSoundEngineer {
    XCTAssertNil(topic.soundEngineer);
}

// Require that MP4Tags has an nil soloist
- (void)testSoloist {
    XCTAssertNil(topic.soloist);
}

// Require that MP4Tags has an nil credits
- (void)testCredits {
    XCTAssertNil(topic.credits);
}

// Require that MP4Tags has an nil thanks
- (void)testThanks {
    XCTAssertNil(topic.thanks);
}

// Require that MP4Tags has an nil online extras
- (void)testOnlineExtras {
    XCTAssertNil(topic.onlineExtras);
}

// Require that MP4Tags has an nil executive
- (void)testExecutive {
    XCTAssertNil(topic.executive);
}

// Require that MP4Tags has an nil season description
- (void)testSeasonDescription {
    XCTAssertNil(topic.seasonDescription);
}


// Require that MP4Tags has an empty itmf list
- (void)testItmf {
    XCTAssertNotNil(topic.itmf);
    XCTAssertEqualObjects(topic.itmf, [NSArray array], @"Array not empty");
}

/*
// Require that name can be set on MP4Tags
 - (void)testSetName
    XCTAssertNotNil(topic);
    topic.name = @"iPhone";
    XCTAssertEqualObjects(@"iPhone", topic.name);
}
*/

/*
// Require that artist can be set on MP4Tags
- (void)testSetArtist {
    XCTAssertNotNil(topic);
    topic.artist = @"iPhone";
    XCTAssertEqualObjects(@"iPhone", topic.artist);
}
*/

@end