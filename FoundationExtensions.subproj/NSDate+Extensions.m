//---------------------------------------------------------------------------------------
//  NSDate+Extensions.m created by erik on Sun 15-Aug-1999
//  @(#)$Id: NSDate+Extensions.m,v 1.2 2002-07-02 15:05:32 erik Exp $
//
//  Copyright (c) 1999 by Erik Doernenburg. All rights reserved.
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
#import "NSDate+Extensions.h"


//---------------------------------------------------------------------------------------
    @implementation NSDate(EDExtensions)
//---------------------------------------------------------------------------------------

/*" Various common extensions to #NSDate. "*/


/*" Returns #YES if the receiver signifies an earlier date than %{other}. "*/

- (BOOL)precedesDate:(NSDate *)other
{
    return [self compare:other] == NSOrderedAscending;
}


//---------------------------------------------------------------------------------------
    @end
//---------------------------------------------------------------------------------------
