//
//  ViewController.m
//  DadamoreApp
//
//  Created by haranicle on 2014/11/07.
//  Copyright (c) 2014年 haranicle. All rights reserved.
//

#import "ViewController.h"
#import "Nums.h"
#import "DDASLLogCapture.h"
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <LumberjackConsole/PTEDashboard.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>

@interface ViewController ()

@end

@implementation ViewController

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.dao = [FmdbDao new];

    [PTEDashboard.sharedDashboard show];

    // init coredata
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"dadamore_coredata.db"];
}

- (void)dealloc
{
    [MagicalRecord cleanUp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UserDefaults

- (IBAction)saveUserDefaults:(id)sender
{
    DDLogInfo(@"%s", __PRETTY_FUNCTION__);

    [[NSUserDefaults standardUserDefaults] setObject:@"Hello Dadamore!!" forKey:@"keykey"];
}

- (IBAction)loadUserDefaults:(id)sender
{
    DDLogInfo(@"%s", __PRETTY_FUNCTION__);

    NSString *text = [[NSUserDefaults standardUserDefaults] objectForKey:@"keykey"];
    DDLogInfo(text);
}

#pragma mark - FMDB

- (IBAction)saveSqlite:(id)sender
{
    DDLogInfo(@"%s", __PRETTY_FUNCTION__);

    [_dao insertRecordToNumsTable:arc4random() % 10000];
}

- (IBAction)loadSqlite:(id)sender
{
    DDLogInfo(@"%s", __PRETTY_FUNCTION__);

    DDLogInfo([_dao selectFromNumsTable]);
}

#pragma mark - CoreData

- (IBAction)saveCoreData:(id)sender
{
    DDLogInfo(@"%s", __PRETTY_FUNCTION__);
    
    Nums *aNum = [Nums MR_createEntity];
    aNum.recordId = @1;
    aNum.num = @(arc4random() % 10000);
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (IBAction)loadCoreData:(id)sender
{
    DDLogInfo(@"%s", __PRETTY_FUNCTION__);
    
    NSArray *nums = [Nums MR_findAll];
    NSString *log = @"";
    
    for (Nums* num in nums) {
        log = [log stringByAppendingString:num.description];
    }
    
    DDLogInfo(@"%@", log);
}

@end
