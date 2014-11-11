//
//  FmdbDao.m
//  DadamoreApp
//
//  Created by haranicle on 2014/11/07.
//  Copyright (c) 2014年 haranicle. All rights reserved.
//

#import "FmdbDao.h"

@implementation FmdbDao

static NSString* kDbFileName = @"dadamore_fmdb.db";
static NSString* kDbEncryptKey = @"BigSecret";

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createDb];
        [self createTables];
    }
    return self;
}

- (void)createDb {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(
        NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* dir = [paths objectAtIndex:0];

    // create db file
    self.dbPath = [dir stringByAppendingPathComponent:kDbFileName];
}

- (void)createTables {
    FMDatabase* db = [FMDatabase databaseWithPath:_dbPath];

    if (!db) {
        NSLog(@"db not found!! | %s", __func__);
        return;
    }

    NSString* sql = @"CREATE TABLE IF NOT EXISTS nums (id INTEGER PRIMARY KEY "
        @"AUTOINCREMENT, num REAL);";
    [db open];
    [db setKey:kDbEncryptKey];
    [db executeUpdate:sql];
    [db close];
}

- (void)insertRecordToNumsTable:(NSInteger)num {
    FMDatabase* db = [FMDatabase databaseWithPath:_dbPath];

    if (!db) {
        NSLog(@"db not found!! | %s", __func__);
        return;
    }

    NSString* sql = @"INSERT INTO nums (num) VALUES (?)";

    [db open];
    [db setKey:kDbEncryptKey];
    [db executeUpdate:sql, [NSString stringWithFormat:@"%ld", num]];
    [db close];
}

- (NSString*)selectFromNumsTable {
    FMDatabase* db = [FMDatabase databaseWithPath:_dbPath];

    NSString* sql = @"SELECT id, num FROM nums;";
    NSString* nums = @"";

    [db open];
    [db setKey:kDbEncryptKey];
    FMResultSet* results = [db executeQuery:sql];
    while ([results next]) {
        NSInteger recordId = [results intForColumn:@"id"];
        NSInteger num = [results intForColumn:@"num"];
        nums =
            [NSString stringWithFormat:@"%@(%ld) %ld\n", nums, recordId, num];
    }
    [db close];

    return nums;
}

@end
