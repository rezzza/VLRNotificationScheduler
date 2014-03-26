//
//  VLRNotificationSettings.m
//  VLRNotificationScheduler
//
//  Created by Lucas Ortis on 25/03/2014.
//  Copyright (c) 2014 Lucas Ortis. All rights reserved.
//

#import                                                             "VLRNotificationSettings.h"

@implementation VLRNotificationSettings

- (id)initWithDaysUntil:(NSInteger)days eventsUntil:(NSInteger)events {
    self = [super init];
    
    if (self) {
        _daysUntil   = days;
        _eventsUntil = events;
    }
    
    return self;
}

# pragma mark - NSCoding protocol

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _daysUntil   = [decoder decodeIntegerForKey:vlrNotificationScheduleDaysUntilEncodeKey];
    _eventsUntil = [decoder decodeIntegerForKey:vlrNotificationScheduleEventsUntilEncodeKey];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:_daysUntil forKey:vlrNotificationScheduleDaysUntilEncodeKey];
    [aCoder encodeInteger:_eventsUntil forKey:vlrNotificationScheduleEventsUntilEncodeKey];
}

@end
