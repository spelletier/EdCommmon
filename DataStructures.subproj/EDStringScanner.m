//---------------------------------------------------------------------------------------
//  EDStringScanner.m created by erik on Mon 24-Apr-2000
//  $Id: EDStringScanner.m,v 1.1.1.1 2000-05-29 00:09:39 erik Exp $
//
//  Copyright (c) 2000 by Erik Doernenburg. All rights reserved.
//
//  Permission to use, copy, modify and distribute this software and its documentation
//  is hereby granted, provided that both the copyright notice and this permission
//  notice appear in all copies of the software, derivative works or modified versions,
//  and any portions thereof, and that both notices appear in supporting documentation,
//  and that credit is given to Erik Doernenburg in all documents and publicity
//  pertaining to direct or indirect use of this code or its derivatives.
//
//  THIS IS EXPERIMENTAL SOFTWARE AND IT IS KNOWN TO HAVE BUGS, SOME OF WHICH MAY HAVE
//  SERIOUS CONSEQUENCES. THE COPYRIGHT HOLDER ALLOWS FREE USE OF THIS SOFTWARE IN ITS
//  "AS IS" CONDITION. THE COPYRIGHT HOLDER DISCLAIMS ANY LIABILITY OF ANY KIND FOR ANY
//  DAMAGES WHATSOEVER RESULTING DIRECTLY OR INDIRECTLY FROM THE USE OF THIS SOFTWARE
//  OR OF ANY DERIVATIVE WORK.
//---------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "EDStringScanner.h"

@interface EDStringScanner(PrivateAPI)
- (void)_getNextChunk;
@end


#define EDSBufferSize 1024

unichar EDStringScannerEndOfDataCharacter = '\0';


//---------------------------------------------------------------------------------------
    @implementation EDStringScanner
//---------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------
//	FACTORY
//---------------------------------------------------------------------------------------

+ (id)scannerWithString:(NSString *)aString
{
    return [[[EDStringScanner alloc] initWithString:aString] autorelease];
}


//---------------------------------------------------------------------------------------
//	INIT & DEALLOC
//---------------------------------------------------------------------------------------

- (id)initWithString:(NSString *)aString
{
    [super init];
    string = [aString retain];
    [self _getNextChunk];
    return self;
}


- (void)dealloc
{
    [string release];
    NSZoneFree([self zone], buffer);
    [super dealloc];
}


//---------------------------------------------------------------------------------------
//	GETTING CHARACTERS
//---------------------------------------------------------------------------------------

- (void)_getNextChunk
{
    unsigned int chunkSize;
    
    if(buffer == NULL)
        {
        buffer = NSZoneMalloc([self zone], sizeof(unichar) * EDSBufferSize);
        bufferOffset = 0;
        }
    else 
        {
        if(bufferOffset + EDSBufferSize > [string length])
            return;
        bufferOffset += EDSBufferSize;
        }
    chunkSize = MIN(([string length] - bufferOffset), EDSBufferSize);
    [string getCharacters:buffer range:NSMakeRange(bufferOffset, chunkSize)];
    charPointer = buffer;
    endOfBuffer = buffer + chunkSize;
}


- (unichar)getCharacter
{
    unichar	c;

    if((c = [self peekCharacter]) != EDStringScannerEndOfDataCharacter)
       charPointer += 1;
    return c;
}


- (unichar)peekCharacter
{
    if(charPointer == endOfBuffer)
        {
        [self _getNextChunk];
        if(charPointer == endOfBuffer)
            return EDStringScannerEndOfDataCharacter;
        }
    return *charPointer;
}


//---------------------------------------------------------------------------------------
//	SCAN LOCATION
//---------------------------------------------------------------------------------------

- (unsigned int)scanLocation
{
    return (bufferOffset + (unsigned int)(charPointer - buffer));
}



//---------------------------------------------------------------------------------------
    @end
//---------------------------------------------------------------------------------------