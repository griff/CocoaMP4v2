//
//  MZRating.h
//  MetaZ
//
//  Created by Brian Olsen on 02/04/13.
//  Copyright 2013 Maven-Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaMP4v2/functions.h>

@class MP4Rating;

@interface MP4RatingStandard : NSObject <NSCopying, NSCoding>
{
    NSString* code;
    NSString* countryCode;
    MP4MediaType* mediaType;
    MP4MediaType mediaTypeValue;
    NSArray* ratings;
}
@property(readonly) NSString* code;
@property(readonly) NSString* countryCode;
@property(readonly) MP4MediaType* mediaType;
@property(readonly,copy) NSArray* ratings;

+ (NSArray *)standards;
+ (NSArray *)standardsWithCountryCode:(NSString *)countryCode;
+ (NSArray *)standardsWithMediaType:(MP4MediaType)mediaType;
+ (NSArray *)standardCountries;
+ (NSArray *)preferredCountriesForPreferences:(NSArray *)preferences;
+ (MP4RatingStandard *)standardWithCountryCode:(NSString *)countryCode mediaType:(MP4MediaType)mediaType;
+ (MP4RatingStandard *)standardWithCode:(NSString *)code;
+ (MP4RatingStandard *)USMovies;
+ (MP4RatingStandard *)USTV;
+ (MP4RatingStandard *)UKMovies;
+ (MP4RatingStandard *)DEMovies;

- (NSString *)localizedNameWithMediaType:(BOOL)includeMediaType;
- (MP4Rating *)findRating:(NSString *)rating;
- (MP4Rating *)requireRating:(NSString *)rating;

@end


@interface MP4Rating : NSObject <NSCopying, NSCoding>
{
    MP4RatingStandard* standard;
    NSString* rating;
    NSInteger score;
    NSString* reason;
}
@property(readonly) MP4RatingStandard* standard;
@property(readonly) NSString* rating;
@property(readonly) NSInteger score;
@property(readonly) NSString* reason;

+ (MP4Rating *)ratingWithCode:(NSString *)rating error:(NSError **)error;
+ (MP4Rating *)ratingWithCode:(NSString *)rating;
+ (MP4Rating *)ratingWithStandard:(MP4RatingStandard *)standard rating:(NSString *)rating score:(NSInteger )score reason:(NSString *)reason;

- (id)initWithCode:(NSString *)rating error:(NSError **)error;
- (id)initWithCode:(NSString *)rating;
- (id)initWithStandard:(MP4RatingStandard *)standard rating:(NSString *)rating score:(NSInteger )score reason:(NSString *)reason;

- (NSString *)code;
- (NSString *)stringValue;

@end
