//
//  MetaDataWrapper.h
//  Tisk Task 4
//
//  Created by Jordan Zucker on 12/20/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskInfo.h"

@interface MetaDataWrapper : NSObject
{
    NSMutableDictionary *plistDict;
}
@property (nonatomic, retain) NSMutableDictionary *plistDict;

- (NSMutableDictionary *) fetchPList;


@end
