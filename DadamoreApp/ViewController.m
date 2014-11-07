//
//  ViewController.m
//  DadamoreApp
//
//  Created by MTER on 2014/11/07.
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [PTEDashboard.sharedDashboard show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UserDefaults

- (IBAction)saveUserDefaults:(id)sender {
    DDLogInfo(@"%s", __PRETTY_FUNCTION__);
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Hello Dadamore!!" forKey:@"keykey"];
}

- (IBAction)loadUserDefaults:(id)sender {
    DDLogInfo(@"%s", __PRETTY_FUNCTION__);
    
    NSString* text = [[NSUserDefaults standardUserDefaults] objectForKey:@"keykey"];
    DDLogInfo(text);
}


#pragma mark - FMDB

- (IBAction)saveFmdb:(id)sender {
    DDLogInfo(@"%s", __PRETTY_FUNCTION__);
}

- (IBAction)loadFmdb:(id)sender {
    DDLogInfo(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark - CoreData

- (IBAction)saveCoreData:(id)sender {
    DDLogInfo(@"%s", __PRETTY_FUNCTION__);
}

- (IBAction)loadCoreData:(id)sender {
    DDLogInfo(@"%s", __PRETTY_FUNCTION__);
}


@end
