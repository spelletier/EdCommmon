//---------------------------------------------------------------------------------------
//  EDObjectReference.m created by erik on Thu 13-Aug-1998
//  @(#)$Id: EDObjectReference.m,v 1.4 2002-02-06 13:46:16 znek Exp $
//
//  Copyright (c) 1998-1999 by Erik Doernenburg. All rights reserved.
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
#import "EDObjectReference.h"


//---------------------------------------------------------------------------------------
    @implementation EDObjectReference
//---------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------
//	FACTORY
//---------------------------------------------------------------------------------------

+ (id)referenceToObject:(id)anObject
{
    EDObjectReference *new;

    new = [[[EDObjectReference alloc] init] autorelease];
    new->referencedObject = [anObject retain];

    return new;
}


//---------------------------------------------------------------------------------------
//	DEALLOC
//---------------------------------------------------------------------------------------

- (void)dealloc
{
    [referencedObject release];
    [super dealloc];
}


//---------------------------------------------------------------------------------------
//	NSCODING
//---------------------------------------------------------------------------------------

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeValueOfObjCType:@encode(int) at:&referencedObject];
}


- (id)initWithCoder:(NSCoder *)decoder
{
    [super init];
    [decoder decodeValueOfObjCType:@encode(int) at:&referencedObject];
    [referencedObject retain];
    return self;
}


//---------------------------------------------------------------------------------------
//	EQUALITY
//---------------------------------------------------------------------------------------

- (unsigned int)hash
{
    return [referencedObject hash];
}


- (BOOL)isEqual:(id)otherObject
{
    if(otherObject == nil)
        return NO;
else if((isa != ((EDObjectReference *)otherObject)->isa) && ([otherObject isKindOfClass:[EDObjectReference class]] == NO))
        return NO;
return (self->referencedObject == ((EDObjectReference *)otherObject)->referencedObject);
}


//---------------------------------------------------------------------------------------
//	NSCOPYING
//---------------------------------------------------------------------------------------

- (id)copyWithZone:(NSZone *)zone
{
    EDObjectReference *copy;

    copy = [[EDObjectReference allocWithZone:zone] init];
    copy->referencedObject = [referencedObject retain];

    return copy;
}


//---------------------------------------------------------------------------------------
//	ACCESSOR METHODS
//---------------------------------------------------------------------------------------

- (void)setReferencedObject:(id)anObject
{
    id old = referencedObject;
    referencedObject = [anObject retain];
    [old release];
}


- (id)referencedObject
{
    return referencedObject;
}


//---------------------------------------------------------------------------------------
    @end
//---------------------------------------------------------------------------------------
