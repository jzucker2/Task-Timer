//
//  CountdownFormatter.m
//  Tisk Task 2
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "CountdownFormatter.h"

@implementation CountdownFormatter
@synthesize dateFormatter;

- (id) init
{
    self = [super init];
    if (self) {
        // Custom initialization
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    
    return self;
}



- (NSString *) stringForCountdownInterval:(NSNumber *)timeinterval
{
    //return @"blah";
    double intervalDouble = [timeinterval doubleValue];
    
    if (intervalDouble == 0) {
        return @"00:00:00";
    }
    
    //NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:intervalDouble];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:intervalDouble];
    
    //dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    
    NSString *formattedString = [dateFormatter stringFromDate:date];
    
    //[dateFormatter release];
    
    return formattedString;
}

- (void) dealloc
{
    [dateFormatter release];
    [super dealloc];
}

@end
