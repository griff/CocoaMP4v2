//
//  MP4MetadataItmf.m
//  CocoaMP4v2
//
//  Created by Brian Olsen on 23/02/14.
//
//

#import "MP4MetadataItmf.h"

@implementation NSArray (MP4ItmfArray)

- (NSUInteger)mp4_indexOfObjectWithCode:(NSString *)aCode
{
    return [self indexOfObjectPassingTest:
        ^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            MP4MetadataItmf* item = obj;
            if([item.code isEqualToString:aCode])
                return YES;
            return NO;
        }];
}

- (id)mp4_objectWithCode:(NSString *)aCode;
{
    NSUInteger idx = [self mp4_indexOfObjectWithCode:aCode];
    if(idx == NSNotFound)
        return nil;
    return [self objectAtIndex:idx];
}

- (NSIndexSet *)mp4_indexesOfObjectsWithCode:(NSString *)aCode;
{
    return [self indexesOfObjectsPassingTest:
            ^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                MP4MetadataItmf* item = obj;
                if([item.code isEqualToString:aCode])
                    return YES;
                return NO;
            }];
}

- (NSArray *)mp4_objectsWithCode:(NSString *)code;
{
    NSIndexSet* set = [self mp4_indexesOfObjectsWithCode:code];
    return [self objectsAtIndexes:set];
}

- (NSUInteger)mp4_indexOfObjectWithMeaning:(NSString *)aMeaning name:(NSString *)aName;
{
    return [self indexOfObjectPassingTest:
            ^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                MP4MetadataItmf* item = obj;
                if(item.reverseDNS && [item.meaning isEqualToString:aMeaning] &&
                   [item.name isEqualToString:aName])
                    return YES;
                return NO;
            }];
}

- (id)mp4_objectWithMeaning:(NSString *)aMeaning name:(NSString *)aName;
{
    NSUInteger idx = [self mp4_indexOfObjectWithMeaning:aMeaning name:aName];
    if(idx == NSNotFound)
        return nil;
    return [self objectAtIndex:idx];
}

- (NSIndexSet *)mp4_indexesOfObjectsWithMeaning:(NSString *)aMeaning name:(NSString *)aName;
{
    return [self indexesOfObjectsPassingTest:
            ^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                MP4MetadataItmf* item = obj;
                if(item.reverseDNS && [item.meaning isEqualToString:aMeaning] &&
                   [item.name isEqualToString:aName])
                    return YES;
                return NO;
            }];
}

- (NSArray *)mp4_objectsWithMeaning:(NSString *)aMeaning name:(NSString *)aName;
{
    NSIndexSet* set = [self mp4_indexesOfObjectsWithMeaning:aMeaning name:aName];
    return [self objectsAtIndexes:set];
}

@end


@implementation MP4MetadataItmfData

+ (id)dataWithItmfData:(MP4ItmfData *)data;
{
    return [[[self alloc] initWithItmfData:data] autorelease];
}

- (id)initWithItmfData:(MP4ItmfData *)data;
{
    self = [super init];
    if(self) {
        _typeCode = data->typeCode;
        _value = [[NSData alloc] initWithBytes:data->value length:data->valueSize];
    }
    return self;
}

- (void)dealloc
{
    [_value release];
    [super dealloc];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<MP4MetadataItmfData: %d %lu %@>", self.typeCode, (unsigned long)self.value.length, (self.value.length > 100 ? @"DATA" : [self objectValue])];
}

- (id)objectValue
{
    switch (self.typeCode) {
        case MP4_ITMF_BT_UTF8:
        case MP4_ITMF_BT_UTF16:
        case MP4_ITMF_BT_ISRC:
        case MP4_ITMF_BT_MI3P:
        case MP4_ITMF_BT_UPC:
            return [self stringValue];
        
        case MP4_ITMF_BT_URL:
            return [self URLValue];

        case MP4_ITMF_BT_INTEGER:
            return [self numberValue];

        case MP4_ITMF_BT_GIF:
        case MP4_ITMF_BT_JPEG:
        case MP4_ITMF_BT_PNG:
            return [self imageValue];

        default:
            return self.value;
    }
}

- (NSString *)stringValue
{
    NSData *data = self.value;
	if (!data) {
		return nil;
	}
	
    if(self.typeCode == MP4_ITMF_BT_UTF16) {
        return [[[NSString alloc] initWithBytes:[data bytes]
                                         length:[data length]
                                       encoding:NSUTF16BigEndianStringEncoding] autorelease];
    }
    return [[[NSString alloc] initWithBytes:[data bytes]
                                     length:[data length]
                                   encoding:NSUTF8StringEncoding] autorelease];
}

- (NSNumber *)numberValue
{
    NSData *data = self.value;
	if (!data) {
		return nil;
	}
    
    NSUInteger len = [data length];
    const void* bytes = [data bytes];
    switch(len)
    {
        case 1:
            return [NSNumber numberWithChar:*(char*)bytes];
        case 2: {
            uint16_t ret = *(uint16_t*)bytes;
            ret = CFSwapInt16BigToHost(ret);
            return [NSNumber numberWithShort:(short)ret];
        }
        case 3:
        case 4: {
            uint32_t ret = *(uint32_t*)bytes;
            ret = CFSwapInt32BigToHost(ret);
            return [NSNumber numberWithInt:(int)ret];
        }
        case 8: {
            uint64_t ret = *(uint64_t*)bytes;
            ret = CFSwapInt64BigToHost(ret);
            return [NSNumber numberWithLongLong:(long long)ret];
        }
    }
    return nil;
}

- (NSURL *)URLValue;
{
    return [NSURL URLWithString:[self stringValue]];
}

- (NSImage *)imageValue;
{
    return [[[NSImage alloc] initWithData:self.value] autorelease];
}

@end


@implementation MP4MetadataItmf

+ (id)itemWithItmfItem:(MP4ItmfItem *)item;
{
    return [[[self alloc] initWithItmfItem:item] autorelease];
}

- (id)initWithItmfItem:(MP4ItmfItem *)item;
{
    self = [super init];
    if(self) {
        _code = [[NSString alloc] initWithCString:item->code encoding:NSASCIIStringEncoding];
        if(item->mean)
            _meaning = [[NSString alloc] initWithUTF8String:item->mean];
        if(item->name)
            _name = [[NSString alloc] initWithUTF8String:item->name];
        
        uint32_t len = item->dataList.size;
        NSMutableArray* items = [NSMutableArray arrayWithCapacity:len];
        for(uint32_t i=0; i<len; i++)
        {
            [items addObject:[MP4MetadataItmfData dataWithItmfData:&item->dataList.elements[i]]];
        }
        _dataItems = [[NSArray alloc] initWithArray:items];
    }
    return self;
}

- (void)dealloc
{
    [_code release];
    [_meaning release];
    [_name release];
    [_dataItems release];
    [super dealloc];
}

- (NSString *)description
{
    if(self.meaning && self.name)
        return [NSString stringWithFormat:@"<MP4MetadataItmfItem: %@ %@ %@ %@>", self.code, self.meaning, self.name, self.dataItems];
    return [NSString stringWithFormat:@"<MP4MetadataItmfItem: %@ %@>", self.code, self.dataItems];
}

- (BOOL)isReverseDNS
{
    return [@"----" isEqualToString:self.code];
}

@end
