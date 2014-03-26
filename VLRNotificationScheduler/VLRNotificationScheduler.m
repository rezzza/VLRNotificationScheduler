//
//  VLRNotificationScheduler.m
//  VLRNotificationScheduler
//
//  Created by Lucas Ortis on 25/03/2014.
//  Copyright (c) 2014 Lucas Ortis. All rights reserved.
//

#import "VLRNotificationScheduler.h"

@implementation VLRNotificationScheduler

- (id)init {
    self = [super init];
    
    if (self) {
        [self loadSchedules];
    }
    
    return self;
}

- (NSArray *)allKeys {
    return [_vlrNotificationsSchedules allKeys];
}

- (void)initWithSettings:(VLRNotificationSettings *)settings forKey:(NSString *)key {
    if (!settings) {
        [NSException raise:NSInvalidArgumentException format:@"Invalid argument settings %@", settings];
    }
    else if (!key) {
        [NSException raise:NSInvalidArgumentException format:@"Invalid argument key %@", settings];
    }
    
    VLRNotificationSchedule *schedule = [_vlrNotificationsSchedules objectForKey:key];
    
    if (!schedule) {
        schedule = [[VLRNotificationSchedule alloc] initWithSettings:settings];
        [_vlrNotificationsSchedules setObject:schedule forKey:key];
        [self storeSchedules];
    }
}

- (void)updateSettings:(VLRNotificationSettings *)settings forKey:(NSString *)key andError:(NSError **)error {
    if (!settings) {
        [NSException raise:NSInvalidArgumentException format:@"Invalid argument settings %@", settings];
    }
    else if (!key) {
        [NSException raise:NSInvalidArgumentException format:@"Invalid argument key %@", settings];
    }
    
    VLRNotificationSchedule *schedule = [_vlrNotificationsSchedules objectForKey:key];
    
    if (schedule) {
        [schedule updateSettings:settings];
        [_vlrNotificationsSchedules setObject:schedule forKey:key];
        [self storeSchedules];
    }
    else {
        if (error) {
            NSString *domain = @"com.Rezzza.VLRNotificationScheduler.ErrorDomain";
            NSString *desc = NSLocalizedString(@"Unable to find the schedule for this key", @"");
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey : desc};
            
            *error = [NSError errorWithDomain:domain code:-101 userInfo:userInfo];
        }
    }
}

- (void)notifyIfNeededForKey:(NSString *)key {
    if (!key) {
        [NSException raise:NSInvalidArgumentException format:@"Invalid argument key %@", key];
    }
    
    VLRNotificationSchedule *schedule = [_vlrNotificationsSchedules objectForKey:key];
    
    if (!schedule) {
        [NSException raise:NSInvalidArgumentException format:@"Cannot find schedule for key : %@", key];
    }
    
    if ([schedule shouldNotify]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:key object:self];
        [schedule resetIfNeeded];
        [self storeSchedules];
    }
}

- (void)incrementEventCountForKey:(NSString *)key {
    VLRNotificationSchedule  *schedule = [_vlrNotificationsSchedules objectForKey:key];
    
    if (!key) {
        [NSException raise:NSInvalidArgumentException format:@"Key cannot be nil"];
    }
    
    if (schedule) {
        [schedule incrementEventCount];
        [self storeSchedules];
    }
    else {
        [NSException raise:NSInvalidArgumentException format:@"Cannot find schedule for key : %@", key];
    }
}

# pragma mark - private methods

- (void)loadSchedules {
    NSMutableDictionary *retrievedSchedules = [[NSUserDefaults standardUserDefaults] objectForKey:VLRNotificationScheduleKey];
    
    if (!retrievedSchedules) {
        retrievedSchedules = [NSMutableDictionary dictionary];
    }
    
    NSMutableDictionary *notificationSchedules = [NSMutableDictionary dictionary];
    for (NSString *key in retrievedSchedules) {
        VLRNotificationSchedule *schedule = [NSKeyedUnarchiver unarchiveObjectWithData:[retrievedSchedules objectForKey:key]];
        
        [notificationSchedules setObject:schedule forKey:key];
    }
    
    _vlrNotificationsSchedules = notificationSchedules;
}

- (void)storeSchedules {
    NSMutableDictionary *toStoreSchedules = [NSMutableDictionary dictionary];
    for (NSString *key in _vlrNotificationsSchedules) {
        VLRNotificationSchedule *schedule = [_vlrNotificationsSchedules objectForKey:key];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:schedule];
        
        [toStoreSchedules setObject:data forKey:key];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:toStoreSchedules forKey:VLRNotificationScheduleKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
