//
//  MP4AllTagsTests.m
//  CocoaMP4v2
//
//  Created by Brian Olsen on 23/02/14.
//
//

#import "MP4AllTagsTests.h"

@implementation MP4AllTagsTests

- (void)setUp
{
    [super setUp];
    NSString* resourcePath = [[NSBundle bundleForClass:[self class]] resourcePath];
    file = [[MP4File alloc] initWithFileName:[resourcePath stringByAppendingPathComponent:@"AllTags.m4v"]];
    topic = [file metadata];
}

- (void)tearDown
{
    [file release];
    [super tearDown];
}

// Require that MP4Tags has correct name
- (void)testName
{
    XCTAssertEqualObjects(@"ログ・ホライズン Original Name", topic.name);
}

// Require that MP4Tags has correct artist
- (void)testArtist {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Artist", topic.artist);
}

// Require that MP4Tags has correct album artist
- (void)testAlbumArtist {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Album Artist", topic.albumArtist);
}

// Require that MP4Tags has correct album
- (void)testAlbum {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Album", topic.album);
}

// Require that MP4Tags has correct grouping
- (void)testGrouping {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Grouping", topic.grouping);
}

// Require that MP4Tags has correct composer
- (void)testComposer {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Composer", topic.composer);
}

// Require that MP4Tags has correct comments
- (void)testComments {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Comments", topic.comments);
}

// Require that MP4Tags has correct genre
- (void)testGenre {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Genre", topic.genre);
}

// Require that MP4Tags has an empty genre type
- (void)testGenreType {
    /*
    XCTAssertTrue(topic.genreType);
    if(topic.genreType)
        XCTAssert(topic.genreType == NULL);
     */
}

// Require that MP4Tags has correct release date
- (void)testReleaseDate {
    XCTAssertEqualObjects(@"2014-02-22T11:00:00Z", topic.releaseDate);
}


// Require that MP4Tags has correct track index
- (void)testTrackIndex {
    XCTAssertTrue(topic.trackIndex);
    if(topic.trackIndex)
        XCTAssertEqual((uint16_t)1, *topic.trackIndex, @"Wrong track index");
}

// Require that MP4Tags has correct track total
- (void)testTrackTotal {
    XCTAssertTrue(topic.trackTotal);
    if(topic.trackTotal)
        XCTAssertEqual((uint16_t)12, *topic.trackTotal, @"Wrong track total");
}

// Require that MP4Tags has correct disc index
- (void)testDiscIndex {
    XCTAssertTrue(topic.discIndex);
    if(topic.discIndex)
        XCTAssertEqual((uint16_t)2, *topic.discIndex, @"Wrong disc index");
}

// Require that MP4Tags has correct disc total
- (void)testDiscTotal {
    XCTAssertTrue(topic.discTotal);
    if(topic.discTotal)
        XCTAssertEqual((uint16_t)24, *topic.discTotal, @"Wrong disc total");
}

// Require that MP4Tags has correct tempo
- (void)testTempo {
    XCTAssertTrue(topic.tempo);
    if(topic.tempo)
        XCTAssertEqual((uint16_t)32, *topic.tempo, @"Wrong tempo");
}

// Require that MP4Tags has correct compilation
- (void)testCompilation {
    /*
    XCTAssertTrue(topic.compilation);
    if(topic.compilation)
        XCTAssertEqual(11, *topic.compilation, @"Wrong compilation");
     */
}


// Require that MP4Tags has an empty tv show
- (void)testTvShow {
    XCTAssertEqualObjects(@"ログ・ホライズン Original TV Show", topic.tvShow);
}

// Require that MP4Tags has an empty tv network
- (void)testTvNetwork {
    XCTAssertEqualObjects(@"ログ・ホライズン Original TV Network", topic.tvNetwork);
}

// Require that MP4Tags has an empty tv episode ID
- (void)testTvEpisodeID {
    XCTAssertEqualObjects(@"ログ・ホライズン Original TV Episode ID", topic.tvEpisodeID);
}

// Require that MP4Tags has an empty tv season
- (void)testTvSeason {
    XCTAssertTrue(topic.tvSeason);
    if(topic.tvSeason)
        XCTAssertEqual((uint32_t)4, *topic.tvSeason);
}

// Require that MP4Tags has an empty tv episode
- (void)testTvEpisode {
    XCTAssertTrue(topic.tvEpisode);
    if(topic.tvEpisode)
        XCTAssertEqual((uint32_t)3, *topic.tvEpisode);
}


// Require that MP4Tags has an empty description
- (void)testDescription {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Description", topic.description);
}

// Require that MP4Tags has an empty long description
- (void)testLongDescription {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Long Description", topic.longDescription);
}

// Require that MP4Tags has an empty lyrics
- (void)testLyrics {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Lyrics", topic.lyrics);
}


// Require that MP4Tags has an empty sort name
- (void)testSortName {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Sort Name", topic.sortName);
}

// Require that MP4Tags has an empty sort artist
- (void)testSortArtist {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Sort Artist", topic.sortArtist);
}

// Require that MP4Tags has an empty sort album artist
- (void)testSortAlbumArtist {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Sort Album Artist", topic.sortAlbumArtist);
}

// Require that MP4Tags has an empty sort album
- (void)testSortAlbum {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Sort Album", topic.sortAlbum);
}

// Require that MP4Tags has an empty sort composer
- (void)testSortComposer {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Sort Composer", topic.sortComposer);
}

// Require that MP4Tags has an empty sort tv show
- (void)testSortTvShow {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Sort TV Show", topic.sortTVShow);
}


// Require that MP4Tags has an empty artwork
- (void)testArtwork {
    XCTAssertNotNil(topic.artwork);
    XCTAssertEqualObjects(topic.artwork, [NSArray array], @"Array not empty");
}


// Require that MP4Tags has an empty copyright
- (void)testCopyright {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Copyright", topic.copyright);
}

// Require that MP4Tags has an empty encoding tool
- (void)testEncodingTool {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Encoding Tool", topic.encodingTool);
}

// Require that MP4Tags has an empty encoded by
- (void)testEncodedBy {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Encoded By", topic.encodedBy);
}

// Require that MP4Tags has an empty purchase date
- (void)testPurchaseDate {
    //XCTAssertEqualObjects(@"ログ・ホライズン Original Purchase Date", topic.purchaseDate);
}


// Require that MP4Tags has an empty podcast
- (void)testPodcast {
    XCTAssertTrue(topic.podcast);
    if(topic.podcast)
        XCTAssertEqual((uint8_t)1, *topic.podcast, @"Wrong podcast");
}

// Require that MP4Tags has an empty keywords
- (void)testKeywords {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Keywords 1, ログ・ホライズン Original Keywords 2", topic.keywords);
}

// Require that MP4Tags has an empty category
- (void)testCategory {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Category", topic.category);
}


// Require that MP4Tags has an empty hd video
- (void)testHdVideo {
    XCTAssertTrue(topic.hdVideo);
    if(topic.hdVideo)
        XCTAssertEqual((uint8_t)1, *topic.hdVideo, @"Wrong HD Video flag");
}

// Require that MP4Tags has an empty media type
- (void)testMediaType {
    XCTAssertTrue(topic.mediaType);
    if(topic.mediaType)
        XCTAssertEqual(MP4iTunesUMediaType, *topic.mediaType);
}

// Require that MP4Tags has an empty content rating
- (void)testContentRating {
    XCTAssertTrue(topic.contentRating);
    if(topic.contentRating)
        XCTAssertEqual((uint8_t)2, *topic.contentRating);
}

// Require that MP4Tags has an empty gapless
- (void)testGapless {
    XCTAssertTrue(topic.gapless);
    if(topic.gapless)
        XCTAssertEqual((uint8_t)1, *topic.gapless);
}


// Require that MP4Tags has an empty iTunes account
- (void)testiTunesAccount {
    XCTAssertEqualObjects(@"ログ・ホライズン Original iTunes Account", topic.iTunesAccount);
}

// Require that MP4Tags has an empty iTunes account type
- (void)testiTunesAccountType {
    /*
    XCTAssertTrue(topic.iTunesAccountType);
    if(topic.iTunesAccountType)
        XCTAssertEqual(NULL, *topic.iTunesAccountType);
    */
}

// Require that MP4Tags has an empty iTunes country
- (void)testiTunesCountry {
    XCTAssertTrue(topic.iTunesCountry);
    if(topic.iTunesCountry)
        XCTAssertEqual((uint32_t)10, *topic.iTunesCountry);
}

// Require that MP4Tags has an empty content ID
- (void)testContentID {
    XCTAssertTrue(topic.contentID);
    if(topic.contentID)
        XCTAssertEqual((uint32_t)5, *topic.contentID);
}

// Require that MP4Tags has an empty artist ID
- (void)testArtistID {
    XCTAssertTrue(topic.artistID);
    if(topic.artistID)
        XCTAssertEqual((uint32_t)6, *topic.artistID);
}

// Require that MP4Tags has an empty playlist ID
- (void)testPlaylistID {
    XCTAssertTrue(topic.playlistID);
    if(topic.playlistID)
        XCTAssertEqual((uint64_t)7, *topic.playlistID);
}

// Require that MP4Tags has an empty genre ID
- (void)testGenreID {
    XCTAssertTrue(topic.genreID);
    if(topic.genreID)
        XCTAssertEqual((uint32_t)8, *topic.genreID);
}

// Require that MP4Tags has an empty composer ID
- (void)testComposerID {
    XCTAssertTrue(topic.composerID);
    if(topic.composerID)
        XCTAssertEqual((uint32_t)9, *topic.composerID);
}

// Require that MP4Tags has an empty xid
- (void)testXid {
    XCTAssertEqualObjects(@"ログ・ホライズン Original XID", topic.xid);
}

// Require that MP4Tags has an nil cast
- (void)testCast {
    NSArray* value = [NSArray arrayWithObjects:@"ログ・ホライズン Original Cast 1",
                      @"ログ・ホライズン Original Cast 2", nil];
    XCTAssertEqualObjects(value, topic.cast);
}

// Require that MP4Tags has an nil directors
- (void)testDirectors {
    NSArray* value = [NSArray arrayWithObjects:@"ログ・ホライズン Original Director 1",
                      @"ログ・ホライズン Original Director 2", nil];
    XCTAssertEqualObjects(value, topic.directors);
}

// Require that MP4Tags has an nil co-directors
- (void)testCodirectors {
    NSArray* value = [NSArray arrayWithObjects:@"ログ・ホライズン Original Codirector 1",
                      @"ログ・ホライズン Original Codirector 2", nil];
    XCTAssertEqualObjects(value, topic.codirectors);
}

// Require that MP4Tags has an nil producers
- (void)testProducers {
    NSArray* value = [NSArray arrayWithObjects:@"ログ・ホライズン Original Producer 1",
                      @"ログ・ホライズン Original Producer 2", nil];
    XCTAssertEqualObjects(value, topic.producers);
}

// Require that MP4Tags has an nil screenwriters
- (void)testScreenwriters {
    NSArray* value = [NSArray arrayWithObjects:@"ログ・ホライズン Original Writer 1",
                      @"ログ・ホライズン Original Writer 2", nil];
    XCTAssertEqualObjects(value, topic.screenwriters);
}

// Require that MP4Tags has an nil studio
- (void)testStudio {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Studio", topic.studio);
}

// Require that MP4Tags has an nil piracy warning
- (void)testPiracyWarning {
    //XCTAssertEqualObjects(@"ログ・ホライズン Original Copy Warning", topic.piracyWarning);
}


// Require that MP4Tags has an nil iTunes Sub-Title
- (void)testiTunesSubTitle {
    XCTAssertEqualObjects(@"ログ・ホライズン Original iTunes Sub-Title", topic.iTunesSubTitle);
}

// Require that MP4Tags has an nil song description
- (void)testSongDescription {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Song Description", topic.songDescription);
}

// Require that MP4Tags has an nil art director
- (void)testArtDirectory {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Art Director 1, ログ・ホライズン Original Art Director 2", topic.artDirector);
}

// Require that MP4Tags has an nil arranger
- (void)testArranger {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Arranger", topic.arranger);
}

// Require that MP4Tags has an nil lyricist
- (void)testLyricist {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Lyricist", topic.lyricist);
}

// Require that MP4Tags has nil acknowledgement
- (void)testAcknowledgement {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Acknowledgement", topic.acknowledgement);
}

// Require that MP4Tags has an nil conductor
- (void)testConductor {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Conductor", topic.conductor);
}

// Require that MP4Tags has an nil linear notes
- (void)testLinearNotes {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Linear Notes", topic.linearNotes);
}

// Require that MP4Tags has an nil record company
- (void)testRecordCompany {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Record Company", topic.recordCompany);
}

// Require that MP4Tags has an nil original artist
- (void)testOriginalArtist {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Original Artist", topic.originalArtist);
}

// Require that MP4Tags has an nil phonogram
- (void)testPhonogram {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Phonogram", topic.phonogram);
}

// Require that MP4Tags has an nil producer
- (void)testProducer {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Producer", topic.producer);
}

// Require that MP4Tags has an nil performer
- (void)testPerformer {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Performer", topic.performer);
}

// Require that MP4Tags has an nil publisher
- (void)testPublisher {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Publisher", topic.publisher);
}

// Require that MP4Tags has an nil sound engineer
- (void)testSoundEngineer {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Sound Engineer", topic.soundEngineer);
}

// Require that MP4Tags has an nil soloist
- (void)testSoloist {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Soloist", topic.soloist);
}

// Require that MP4Tags has an nil credits
- (void)testCredits {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Credits", topic.credits);
}

// Require that MP4Tags has an nil thanks
- (void)testThanks {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Thanks", topic.thanks);
}

// Require that MP4Tags has an nil online extras
- (void)testOnlineExtras {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Online Extras", topic.onlineExtras);
}

// Require that MP4Tags has an nil executive
- (void)testExecutive {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Executive", topic.executive);
}

// Require that MP4Tags has an nil season description
- (void)testSeasonDescription {
    XCTAssertEqualObjects(@"ログ・ホライズン Original Series", topic.seasonDescription);
}


// Require that MP4Tags has an empty itmf list
- (void)testItmf {
    XCTAssertNotNil(topic.itmf);
    XCTAssertEqual((NSUInteger)2, [topic.itmf count]);
    MP4MetadataItmf* item = [topic.itmf mp4_objectWithCode:@"itnu"];
    XCTAssertNotNil(item);
    XCTAssertEqualObjects(@"itnu", item.code);
    XCTAssertFalse([item isReverseDNS]);
    XCTAssertNil(item.meaning);
    XCTAssertNil(item.name);

    item = [topic.itmf mp4_objectWithMeaning:@"com.apple.iTunes" name:@"iTunMOVI"];
    XCTAssertNotNil(item);
    XCTAssertTrue([item isReverseDNS]);
    XCTAssertEqualObjects(@"----", item.code);
    XCTAssertEqualObjects(@"com.apple.iTunes", item.meaning);
    XCTAssertEqualObjects(@"iTunMOVI", item.name);
}

@end
