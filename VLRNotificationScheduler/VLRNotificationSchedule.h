//
//  VLRNotificationSchedule.h
//  VLRNotificationScheduler
//
//  Created by Lucas Ortis on 25/03/2014.
//  Copyright (c) 2014 Lucas Ortis. All rights reserved.
//

/* Imports */
#import <Foundation/Foundation.h>
#import "VLRNotificationSettings.h"

/* Static properties */
static NSString *const vlrNotificationScheduleLastUpdateDateEncodeKey = @"VLR_NOTIFICATION_SCHEDULE_LAST_UPDATE_DATE_ENCODE_KEY";
static NSString *const vlrNotificationScheduleEventCountEncodeKey     = @"VLR_NOTIFICATION_SCHEDULE_EVENT_COUNT_ENCODE_KEY";
static NSString *const vlrNotificationScheduleSettingsEncodeKey       = @"VLR_NOTIFICATION_SCHEDULE_SETTINGS_ENCODE_KEY";

@interface VLRNotificationSchedule : NSObject <NSCoding>
{
}

@property (readonly, nonatomic) NSDate                  *lastUpdate;
@property (readonly, nonatomic) NSUInteger              eventCount;
@property (readonly, nonatomic) VLRNotificationSettings *vlrNotificationSettings;


/* Methods */
- (id)initWithSettings:(VLRNotificationSettings *)settings;
- (void)updateSettings:(VLRNotificationSettings *)settings;
- (void)incrementEventCount;
- (void)update;
- (BOOL)shouldNotify;
- (BOOL)shouldNotifyForDate:(NSDate *)date;
- (void)resetIfNeeded;

@end
