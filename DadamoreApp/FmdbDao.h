//
//  FmdbDao.h
//  DadamoreApp
//
//  Created by haranicle on 2014/11/07.
//  Copyright (c) 2014年 haranicle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface FmdbDao : NSObject

@property FMDatabase *db;

- (void)insertRecordToNumsTable:(NSInteger)num;
- (NSString *)selectFromNumsTable;

@end
