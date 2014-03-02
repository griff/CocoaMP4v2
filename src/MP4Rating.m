//
//  MP4Rating.m
//  MetaZ
//
//  Created by Brian Olsen on 02/04/13.
//  Copyright 2013 Maven-Group. All rights reserved.
//

#import "MP4Rating.h"

@interface MP4RatingStandard()

+ (void)loadRatings;
+ (MP4RatingStandard *)standardWithDictionary:(NSDictionary *)dict;

- (id)initWithCode:(NSString *)theCode
       countryCode:(NSString *)theCountryCode
         mediaType:(MP4MediaType)theMediaType
           ratings:(NSArray *)theRatings;

- (id)initWithCode:(NSString *)theCode;

@property(readwrite,copy) NSArray* ratings;

@end


@interface MP4Rating ()

+ (MP4Rating *)ratingWithStandard:(MP4RatingStandard *)standard dictionary:(NSDictionary *)dict;

@end


@implementation MP4RatingStandard

+ (void)initialize
{
    if(self != [MP4RatingStandard class])
        return;
    
    [self loadRatings];
}

+ (void)loadRatings
{
    NSBundle* myBundle = [NSBundle bundleForClass:self];
    NSString* path = [myBundle pathForResource:@"Ratings" ofType:@"plist"];
    NSAssert(path != nil, @"Path exists");
    NSData* data = [NSData dataWithContentsOfFile:path];
    NSAssert(data != nil, @"Data is loaded");
    NSArray* standards = [NSPropertyListSerialization propertyListFromData:data
                                                          mutabilityOption:NSPropertyListImmutable
                                                                    format:NULL
                                                          errorDescription:NULL];
    NSAssert(standards != nil && [standards count] > 0, @"Standards are deserialized");
    for(NSDictionary* dict in standards)
    {
        [self standardWithDictionary:dict];
    }
}

static NSMutableArray *sharedStandards = nil;
+ (void)registerStandard:(MP4RatingStandard *)standard
{
    @synchronized(self)
    {
        if(!sharedStandards)
            sharedStandards = [[NSMutableArray alloc] init];
        
        if(standard.mediaType != NULL && standard.countryCode != nil)
        {
            for(MP4RatingStandard* other in sharedStandards)
            {
                if(other.mediaType != NULL &&
                   *standard.mediaType == *other.mediaType &&
                   [standard.countryCode isEqualToString:other.countryCode])
                {
                    return;
                }
            }
        }
        for(MP4RatingStandard* other in sharedStandards)
        {
            if([other.code isEqualToString:standard.code])
                return;
        }
        [sharedStandards addObject:standard];
    }
}

+ (NSArray *)standards;
{
    @synchronized(self)
    {
        if(!sharedStandards)
            return [NSArray array];
        return [[sharedStandards copy] autorelease];
    }
}

+ (NSArray *)standardsWithCountryCode:(NSString *)countryCode;
{
    NSAssert(countryCode != nil && [countryCode length] > 0, @"Country code is non-empty string");
    
    countryCode = [countryCode uppercaseString];
    @synchronized(self)
    {
        if(!sharedStandards)
            return [NSArray array];
        NSMutableArray* ret = [NSMutableArray array];
        for(MP4RatingStandard* standard in sharedStandards)
        {
            if(standard.countryCode != nil && [standard.countryCode isEqualToString:countryCode])
                [ret addObject:standard];
        }
        return ret;
    }
}

+ (NSArray *)standardsWithMediaType:(MP4MediaType)mediaType;
{
    @synchronized(self)
    {
        if(!sharedStandards)
            return [NSArray array];
        NSMutableArray* ret = [NSMutableArray array];
        for(MP4RatingStandard* standard in sharedStandards)
        {
            if(standard.mediaType != NULL && *standard.mediaType == mediaType)
                [ret addObject:standard];
        }
        return ret;
    }
}

+ (MP4RatingStandard *)standardWithCountryCode:(NSString *)countryCode mediaType:(MP4MediaType)mediaType;
{
    NSAssert(countryCode != nil && [countryCode length] > 0, @"Country code is non-empty string");
    
    countryCode = [countryCode uppercaseString];
    @synchronized(self)
    {
        if(!sharedStandards)
            return nil;
        for(MP4RatingStandard* standard in sharedStandards)
        {
            if(standard.mediaType != NULL &&
               *standard.mediaType == mediaType &&
               standard.countryCode != nil &&
               [standard.countryCode isEqualToString:countryCode])
            {
                return standard;
            }
        }
    }
    return nil;
}

+ (NSArray *)standardCountries;
{
    @synchronized(self)
    {
        if(!sharedStandards)
            return nil;
        NSMutableArray* ret = [NSMutableArray array];
        for(MP4RatingStandard* standard in sharedStandards)
        {
            NSString* country = [standard.countryCode uppercaseString];
            if(country && ![ret containsObject:country])
                [ret addObject:country];
        }
        return ret;
    }
    return nil;
}

+ (NSSet *)standardCountriesSet;
{
    @synchronized(self)
    {
        if(!sharedStandards)
            return nil;
        NSMutableSet* ret = [NSMutableSet set];
        for(MP4RatingStandard* standard in sharedStandards)
        {
            NSString* country = [standard.countryCode uppercaseString];
            if(country && ![ret containsObject:country])
                [ret addObject:country];
        }
        return ret;
    }
    return nil;
}


+ (NSArray *)preferredCountriesForPreferences:(NSArray *)preferences;
{
    if(!preferences || [preferences count] == 0)
    {
        NSLocale* currentLocale = [NSLocale currentLocale];
        NSString* country = [currentLocale objectForKey:NSLocaleCountryCode];
        if([[MP4RatingStandard standardsWithCountryCode:country] count] == 0)
            country = @"US";
        return [NSArray arrayWithObject:country];
    }
    NSSet* countries = [self standardCountriesSet];
    NSMutableArray* ret = [NSMutableArray array];
    for(NSString* country in preferences)
    {
        country = [country uppercaseString];
        if([countries containsObject:country])
            [ret addObject:country];
    }
    return ret;
    
}

+ (MP4RatingStandard *)internalStandardWithCode:(NSString *)code;
{
    @synchronized(self)
    {
        if(sharedStandards)
        {
            for(MP4RatingStandard* standard in sharedStandards)
            {
                if([standard.code isEqualToString:code])
                    return standard;
            }
        }
    }
    return nil;
}

+ (MP4RatingStandard *)standardWithCode:(NSString *)code;
{
    NSAssert(code != nil && [code length] > 0, @"Code is non-empty string");
    
    code = [code lowercaseString];
    
    MP4RatingStandard* ret = [self internalStandardWithCode:code];
    if(ret)
        return ret;
    
    return [[[self alloc] initWithCode:code] autorelease];
}

+ (MP4RatingStandard *)USMovies;
{
    MP4RatingStandard* ret = [self standardWithCode:@"mpaa"];
    NSAssert(ret.countryCode!=nil && [ret.countryCode isEqualToString:@"US"], @"US rating standard");
    NSAssert(ret.mediaType != NULL && *ret.mediaType == MP4MovieMediaType, @"movie standard");
    return ret;
}

+ (MP4RatingStandard *)USTV;
{
    MP4RatingStandard* ret = [self standardWithCode:@"us-tv"];
    NSAssert(ret.countryCode!=nil && [ret.countryCode isEqualToString:@"US"], @"US rating standard");
    NSAssert(ret.mediaType != NULL && *ret.mediaType == MP4TVShowMediaType, @"tv-show standard");
    return ret;
}

+ (MP4RatingStandard *)UKMovies;
{
    MP4RatingStandard* ret = [self standardWithCode:@"uk-movies"];
    NSAssert(ret.countryCode!=nil && [ret.countryCode isEqualToString:@"GB"], @"GB rating standard");
    NSAssert(ret.mediaType != NULL && *ret.mediaType == MP4MovieMediaType, @"movie standard");
    return ret;
}

+ (MP4RatingStandard *)DEMovies;
{
    MP4RatingStandard* ret = [self standardWithCode:@"de-movies"];
    NSAssert(ret.countryCode!=nil && [ret.countryCode isEqualToString:@"DE"], @"DE rating standard");
    NSAssert(ret.mediaType != NULL && *ret.mediaType == MP4MovieMediaType, @"movie standard");
    return ret;
}

+ (MP4RatingStandard *)standardWithDictionary:(NSDictionary *)dict
{
    NSAssert([dict objectForKey:@"code"] != nil, @"Has code");
    NSAssert([dict objectForKey:@"country"] != nil, @"Has country");
    NSAssert([dict objectForKey:@"mediaType"] != nil, @"Has media type");
    
    NSString* code = [[dict objectForKey:@"code"] lowercaseString];
    NSString* countryCode = [[dict objectForKey:@"country"] uppercaseString];
    MP4MediaType mediaType = [[dict objectForKey:@"mediaType"] unsignedCharValue];
    
    MP4RatingStandard * standard = [[[self alloc] initWithCode:code countryCode:countryCode mediaType:mediaType ratings:[NSArray array]] autorelease];
    
    NSArray* ratingsDicts = [dict objectForKey:@"ratings"];
    NSAssert(ratingsDicts != nil && [ratingsDicts count] > 0, @"Have ratings");
    
    NSMutableArray* ratings = [NSMutableArray array];
    for(NSDictionary* ratingDict in ratingsDicts)
    {
        MP4Rating* rating = [MP4Rating ratingWithStandard:standard dictionary:ratingDict];
        [ratings addObject:rating];
    }
    standard.ratings = ratings;
    return standard;
}

- (id)initWithCode:(NSString *)theCode
       countryCode:(NSString *)theCountryCode
         mediaType:(MP4MediaType)theMediaType
           ratings:(NSArray *)theRatings
{
    NSAssert(theCode != nil && [theCode length] > 0, @"Non-empty code");
    NSAssert(theCountryCode != nil && [theCountryCode length] > 0, @"Non-empty country code");
    NSAssert(theRatings != nil, @"Non-nil ratings");
    
    self = [super init];
    if(self)
    {
        code = [[theCode lowercaseString] retain];
        countryCode = [[theCountryCode uppercaseString] retain];
        mediaTypeValue = theMediaType;
        mediaType = &mediaTypeValue;
        ratings = [theRatings copy];
        [MP4RatingStandard registerStandard:self];
    }
    return self;
}

- (id)initWithCode:(NSString *)theCode
{
    NSAssert(theCode != nil && [theCode length] > 0, @"Non-empty code");
    
    self = [super init];
    if(self)
    {
        code = [theCode copy];
        mediaType = NULL;
        ratings = [[NSArray alloc] init];
        [MP4RatingStandard registerStandard:self];
    }
    return self;
}

- (void)dealloc
{
    [code release];
    [countryCode release];
    [ratings release];
    [super dealloc];
}

@synthesize code;
@synthesize countryCode;
@synthesize mediaType;
@synthesize ratings;

- (BOOL)isEqual:(id)object
{
    return [object isKindOfClass:[MP4RatingStandard class]] && [self.code isEqual:((MP4RatingStandard*)object).code];
}

- (NSString *)localizedNameWithMediaType:(BOOL)includeMediaType;
{
    NSBundle* bundle = [NSBundle bundleForClass:[self class]];
    if(self.countryCode)
    {
        NSArray* prefered = [bundle preferredLocalizations];
        NSLocale* current = [[[NSLocale alloc] initWithLocaleIdentifier:[prefered objectAtIndex:0]] autorelease];
        
        NSString* countryName = [current displayNameForKey:NSLocaleCountryCode value:self.countryCode];
        
        if(includeMediaType && self.mediaType != NULL)
        {
            NSString* mediaTypeName = MP4MediaTypeToString(*self.mediaType);
            NSString* mediaTypeKey = [NSString stringWithFormat:@"%@ Rating Standard Name Template", mediaTypeName];
            mediaTypeName = [bundle localizedStringForKey:mediaTypeKey
                                                    value:[NSString stringWithFormat:@"%%@ %@", mediaTypeName]
                                                    table:nil];
            countryName = [NSString stringWithFormat:mediaTypeName, countryName];
        }
        return countryName;
    }
    else {
        NSString* template = [bundle localizedStringForKey:@"Unknown Rating Standard Name Template"
                                                     value:@"Unknown rating standard %@"
                                                     table:nil];
        return [NSString stringWithFormat:template, self.code];
    }
}

- (MP4Rating *)findRating:(NSString *)theRating;
{
    if(theRating == nil || [theRating length] == 0)
        return nil;
    for(MP4Rating* rating in self.ratings)
    {
        if([rating.rating isEqualToString:theRating])
            return rating;
    }
    return nil;
}

- (MP4Rating *)requireRating:(NSString *)theRating;
{
    MP4Rating *ret = [self findRating:theRating];
    NSAssert1(ret != nil, @"Required rating %@ not found", theRating);
    return ret;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSString* theCode = [aDecoder decodeObjectForKey:@"code"];
    id ret = [[self class] internalStandardWithCode:theCode];
    if(ret)
    {
        [self release];
        return [ret retain];
    }
    
    self = [super init];
    if(self)
    {
        code = [theCode retain];
        countryCode = [[aDecoder decodeObjectForKey:@"countryCode"] retain];
        NSNumber* mv = [[aDecoder decodeObjectForKey:@"mediaType"] retain];
        if(mv)
        {
            mediaType = &mediaTypeValue;
            mediaTypeValue = [mv unsignedCharValue];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:code forKey:@"code"];
    [aCoder encodeObject:countryCode forKey:@"countryCode"];
    NSNumber* toEncode = nil;
    if(mediaType)
        toEncode = [NSNumber numberWithUnsignedChar:mediaTypeValue];
    [aCoder encodeObject:toEncode forKey:@"mediaType"];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone;
{
    if(self.countryCode)
        return [[[self class] allocWithZone:zone]
                initWithCode:self.code countryCode:self.countryCode mediaType:*self.mediaType ratings:self.ratings];
    else
        return [[[self class] allocWithZone:zone]
                initWithCode:self.code];
}

@end


@implementation MP4Rating

+ (MP4Rating *)ratingWithStandard:(MP4RatingStandard *)standard dictionary:(NSDictionary *)dict;
{
    NSAssert([dict objectForKey:@"rating"] != nil, @"Missing rating");
    NSAssert([dict objectForKey:@"score"] != nil, @"Missing score");
    
    NSString* rating = [dict objectForKey:@"rating"];
    NSInteger score = [[dict objectForKey:@"score"] integerValue];
    return [self ratingWithStandard:standard rating:rating score:score reason:@""];
}

+ (MP4Rating *)ratingWithCode:(NSString *)rating;
{
    return [self ratingWithCode:rating error:NULL];
}

+ (MP4Rating *)ratingWithCode:(NSString *)rating error:(NSError **)error
{
    return [[[self alloc] initWithCode:rating error:error] autorelease];
}

+ (MP4Rating *)ratingWithStandard:(MP4RatingStandard *)standard rating:(NSString *)rating score:(NSInteger )score reason:(NSString *)reason;
{
    return [[[self alloc] initWithStandard:standard rating:rating score:score reason:reason] autorelease];
}


- (id)initWithCode:(NSString *)theRating;
{
    return [self initWithCode:theRating error:NULL];
}

- (id)initWithCode:(NSString *)theRating error:(NSError **)error;
{
    NSAssert(theRating != nil && [theRating length] > 0, @"Non-empty code");
    
    self = [self init];
    if(self)
    {
        NSArray* components = [theRating componentsSeparatedByString:@"|"];
        if([components count] < 3)
        {
            if(error)
            {
                NSString* errorString = [NSString stringWithFormat:@"Invalid rating code: '%@'", theRating];
                NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:errorString, @"NSLocalizedDescriptionKey", nil];
                *error = [NSError errorWithDomain:@"MetaZKit" code:1 userInfo:dict];
            }
            [self release];
            return nil;
        }
        standard = [[MP4RatingStandard standardWithCode:[components objectAtIndex:0]] retain];
        rating = [[components objectAtIndex:1] retain];
        score = [[components objectAtIndex:2] integerValue];
        if([components count] > 3)
            reason = [[components objectAtIndex:3] retain];
        else
            reason = @"";
    }
    return self;
}

- (id)initWithStandard:(MP4RatingStandard *)theStandard
                rating:(NSString *)theRating
                 score:(NSInteger )theScore
                reason:(NSString *)theReason;
{
    NSAssert(theStandard != nil, @"Non-nil standard");
    NSAssert(theRating != nil && [theRating length] > 0, @"Non-empty rating");
    NSAssert(theScore >= 0, @"Positive integer");
    NSAssert(theReason != nil, @"Non-nil reason");
    
    self = [super init];
    if(self)
    {
        standard = [theStandard retain];
        rating = [theRating copy];
        score = theScore;
        reason = [theReason copy];
    }
    return self;
}

- (void)dealloc
{
    [standard release];
    [rating release];
    [reason release];
    [super dealloc];
}

@synthesize standard;
@synthesize rating;
@synthesize score;
@synthesize reason;

- (BOOL)isEqual:(id)object
{
    return [object isKindOfClass:[MP4Rating class]] &&
    [self.standard isEqual:[object standard]] &&
    [self.rating isEqual:[object rating]];
}

- (NSString *)code;
{
    return [NSString stringWithFormat:@"%@|%@|%ld|%@", self.standard.code, self.rating, (long)self.score, self.reason];
}

- (NSString *)stringValue;
{
    return [self code];
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        standard = [[aDecoder decodeObjectForKey:@"standard"] retain];
        rating = [[aDecoder decodeObjectForKey:@"rating"] retain];
        score = [aDecoder decodeIntegerForKey:@"score"];
        reason = [[aDecoder decodeObjectForKey:@"reason"] retain];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:standard forKey:@"standard"];
    [aCoder encodeObject:rating forKey:@"rating"];
    [aCoder encodeInteger:score forKey:@"score"];
    [aCoder encodeObject:reason forKey:@"reason"];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone;
{
    return [[[self class] allocWithZone:zone]
            initWithStandard:self.standard
            rating:self.rating
            score:self.score
            reason:self.reason];
}

@end
