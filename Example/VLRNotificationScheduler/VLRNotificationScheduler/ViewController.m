//
//  ViewController.m
//  VLRNotificationScheduler
//
//  Created by Lucas Ortis on 25/03/2014.
//  Copyright (c) 2014 Lucas Ortis. All rights reserved.
//

#import                                                             "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(interceptNotification:) name:@"MY_KEY_NOTIFICATION" object:nil];
    
    [self initScheduler];
}

- (void)initScheduler {
    VLRNotificationSettings  *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:5 eventsUntil:2];
    VLRNotificationScheduler *scheduler = [[VLRNotificationScheduler alloc] init];
    
    NSString *myKey = @"MY_KEY_NOTIFICATION";
    
    [scheduler setSettings:settings forKey:myKey];
    
    [scheduler incrementEventCountForKey:myKey];
    [scheduler notifyIfNeededForKey:myKey];
    
    
//    [scheduler incrementEventCountForKey:myKey];
//    [scheduler notifyIfNeededForKey:myKey];
}

- (void)interceptNotification:(NSNotification *)notification {
    NSLog(@"NOTIFICATION !");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
