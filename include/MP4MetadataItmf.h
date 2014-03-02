//
//  MP4MetadataItmf.h
//  CocoaMP4v2
//
//  Created by Brian Olsen on 23/02/14.
//
//

#import <Foundation/Foundation.h>
#import <CocoaMP4v2/mp4v2.h>

/**
 An array that contains MP4MetadataItmfItem elements.
 
 */
@interface NSArray (MP4ItmfArray)

/**
 Returns lowest index whose corresponding array value has a given code.
 @param aCode A code
 @return The lowest index whose corresponding array value has a code equal to
    aCode. If none of the objects in the array has the code aCode, returns
    NSNotFound.
 */
- (NSUInteger)mp4_indexOfObjectWithCode:(NSString *)aCode;

/**
 */
- (id)mp4_objectWithCode:(NSString *)aCode;
- (NSIndexSet *)mp4_indexesOfObjectsWithCode:(NSString *)aCode;
- (NSArray *)mp4_objectsWithCode:(NSString *)aCode;

/**
 Returns lowest index whose corresponding array value has a given meaning and
 name. 
 @param aCode A code
 @return The lowest index whose corresponding array value has a meaning equal to
 aMeaning and a name equal to aName. If none of the objects in the array match
 the criteria, returns NSNotFound.
 */
- (NSUInteger)mp4_indexOfObjectWithMeaning:(NSString *)aMeaning name:(NSString *)aName;
- (id)mp4_objectWithMeaning:(NSString *)aMeaning name:(NSString *)aName;
- (NSIndexSet *)mp4_indexesOfObjectsWithMeaning:(NSString *)aMeaning name:(NSString *)aName;
- (NSArray *)mp4_objectsWithMeaning:(NSString *)aMeaning name:(NSString *)aName;

@end



@interface MP4MetadataItmfData : NSObject
@property(readonly,assign,nonatomic) MP4ItmfBasicType typeCode;

/**
 may be nil
 */
@property(readonly,copy,nonatomic) NSData* value;

- (NSString *)stringValue;
- (NSNumber *)numberValue;
- (NSURL *)URLValue;
- (NSImage *)imageValue;

@end


@interface MP4MetadataItmf : NSObject
@property(readonly,copy,nonatomic) NSString* code;
@property(readonly,copy,nonatomic) NSString* meaning;
@property(readonly,copy,nonatomic) NSString* name;
@property(readonly,copy,nonatomic) NSArray* dataItems;
@property(readonly,nonatomic,getter=isReverseDNS) BOOL reverseDNS;
@end
