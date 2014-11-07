//
//  FmdbDao.m
//  DadamoreApp
//
//  Created by haranicle on 2014/11/07.
//  Copyright (c) 2014年 haranicle. All rights reserved.
//

#import "FmdbDao.h"

@implementation FmdbDao

static NSString* kDbFileName = @"dadamore.db";

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createDb];
        [self createTables];
    }
    return self;
}

- (void)createDb
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* dir = [paths objectAtIndex:0];

    // create db file
    self.db = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:kDbFileName]];
}

- (void)createTables
{
    if (!_db) {
        NSLog(@"db not found!! | %s", __func__);
        return;
    }

    NSString* sql = @"CREATE TABLE IF NOT EXISTS nums (id INTEGER PRIMARY KEY AUTOINCREMENT, num REAL);";
    [_db open];
    [_db executeUpdate:sql];
    [_db close];
}

- (void)insertRecordToNumsTable:(NSInteger)num
{
    if (!_db) {
        NSLog(@"db not found!! | %s", __func__);
        return;
    }

    NSString* sql = @"INSERT INTO nums (num) VALUES (?)";

    [_db open];
    [_db executeUpdate:sql, [NSString stringWithFormat:@"%ld", num]];
    [_db close];
}

- (NSString*)selectFromNumsTable
{
    NSString* sql = @"SELECT id, num FROM nums;";
    NSString* nums = @"";

    [_db open];
    FMResultSet* results = [_db executeQuery:sql];
    while ([results next]) {
        NSInteger recordId = [results intForColumn:@"id"];
        NSInteger num = [results intForColumn:@"num"];
        nums = [NSString stringWithFormat:@"%@(%ld) %ld\n", nums, recordId, num];
    }
    [_db close];

    return nums;
}

@end
