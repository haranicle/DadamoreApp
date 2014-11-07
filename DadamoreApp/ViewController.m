//
//  ViewController.m
//  DadamoreApp
//
//  Created by haranicle on 2014/11/07.
//  Copyright (c) 2014年 haranicle. All rights reserved.
//

#import "ViewController.h"
#import "DDASLLogCapture.h"
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <LumberjackConsole/PTEDashboard.h>

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

    NSString* text = [[NSUserDefaults standardUserDefaults] objectForKey:@"keykey"];
    DDLogInfo(text);
}

#pragma mark - FMDB

- (IBAction)saveFmdb:(id)sender
{
    DDLogInfo(@"%s", __PRETTY_FUNCTION__);

    [_dao insertRecordToNumsTable:arc4random() % 10000];
}

- (IBAction)loadFmdb:(id)sender
{
    DDLogInfo(@"%s", __PRETTY_FUNCTION__);

    DDLogInfo([_dao selectFromNumsTable]);
}

#pragma mark - CoreData

- (IBAction)saveCoreData:(id)sender
{
    DDLogInfo(@"%s", __PRETTY_FUNCTION__);
}

- (IBAction)loadCoreData:(id)sender
{
    DDLogInfo(@"%s", __PRETTY_FUNCTION__);
}

@end
