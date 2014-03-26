//
//  VLRNotificationScheduler.h
//  VLRNotificationScheduler
//
//  Created by Lucas Ortis on 25/03/2014.
//  Copyright (c) 2014 Lucas Ortis. All rights reserved.
//

/* Import */
#import <Foundation/Foundation.h>
#import "VLRNotificationSchedule.h"

/* Statics properties */
static NSString *const VLRNotificationScheduleKey = @"VLR_NOTIFICATION_SCHEDULES_KEY";

@interface VLRNotificationScheduler : NSObject
{
    NSMutableDictionary *_vlrNotificationsSchedules;
}

/* Methods */
- (NSArray *)allKeys;
- (void)initWithSettings:(VLRNotificationSettings *)settings forKey:(NSString *)key;
- (void)updateSettings:(VLRNotificationSettings *)settings forKey:(NSString *)key andError:(NSError **)error;
- (void)notifyIfNeededForKey:(NSString *)key;
- (void)incrementEventCountForKey:(NSString *)key;

@end
