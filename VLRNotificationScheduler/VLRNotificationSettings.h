//
//  VLRNotificationSettings.h
//  VLRNotificationScheduler
//
//  Created by Lucas Ortis on 25/03/2014.
//  Copyright (c) 2014 Lucas Ortis. All rights reserved.
//

/* Imports */
#import                                                             <Foundation/Foundation.h>

/* Static properties */
static NSString *const vlrNotificationScheduleDaysUntilEncodeKey   = @"VLR_NOTIFICATION_SCHEDULE_DAYS_UNTIL_ENCODE_KEY";
static NSString *const vlrNotificationScheduleEventsUntilEncodeKey = @"VLR_NOTIFICATION_SCHEDULE_EVENT_UNTIL_ENCODE_KEY";

@interface VLRNotificationSettings : NSObject <NSCoding>
{
}

/* Properties */
@property (readonly, nonatomic) NSInteger daysUntil;
@property (readonly, nonatomic) NSInteger eventsUntil;

/* Methods */
- (id)initWithDaysUntil:(NSInteger)days eventsUntil:(NSInteger)events;

@end
