//
//  CountdownFormatter.h
//  Tisk Task 4
//
//  Created by Jordan Zucker on 12/20/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountdownFormatter : NSObject
{
    NSDateFormatter *dateFormatter;
}

@property (nonatomic, retain) NSDateFormatter *dateFormatter;

- (NSString *) stringForCountdownInterval:(NSNumber *)timeinterval;


@end