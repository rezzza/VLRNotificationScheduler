//
//  VLRNotificationSchedule.m
//  VLRNotificationScheduler
//
//  Created by Lucas Ortis on 25/03/2014.
//  Copyright (c) 2014 Lucas Ortis. All rights reserved.
//

#import "VLRNotificationSchedule.h"

#define NB_SECONDS_IN_A_DAY 86400
#define DAYS_SINCE_DATES(aDate, bDate) (NSUInteger)ABS(MAX((NSInteger)([bDate timeIntervalSinceDate:aDate] / NB_SECONDS_IN_A_DAY), 0))

@implementation VLRNotificationSchedule

- (id)initWithSettings:(VLRNotificationSettings *)settings {
    self = [super init];
    
    if (self) {
        if (settings) {
            _vlrNotificationSettings = settings;
        }
        else {
            [NSException raise:NSInvalidArgumentException format:@"settings can't be nil"];
        }
        _eventCount = 0;
        _lastUpdate = [self getCurrentDate];
    }
    
    return self;
}

- (void)updateSettings:(VLRNotificationSettings *)settings {
    if (settings) {
        _vlrNotificationSettings = settings;
    }
    else {
        [NSException raise:NSInvalidArgumentException format:@"settings argument is not valid %@", settings];
    }
}

- (NSDate *)getCurrentDate {
    return [NSDate date];
}

- (void)incrementEventCount {
    _eventCount += 1;
}

- (void)update {
    _lastUpdate = [self getCurrentDate];
}

- (NSString *)description {
    return [NSString stringWithFormat:
            @"lastUpdate: %@ \
              eventCount: %ld \
              Settings: %@",
            _lastUpdate, (unsigned long)_eventCount, _vlrNotificationSettings];
}

- (void)resetIfNeeded {
    if (DAYS_SINCE_DATES(_lastUpdate, [self getCurrentDate]) >= _vlrNotificationSettings.daysUntil) {
        _lastUpdate = [self getCurrentDate];
    }
    
    if (_eventCount >= _vlrNotificationSettings.eventsUntil) {
        _eventCount = 0;
    }
}

- (BOOL)shouldNotify {
    return [self shouldNotifyForDate:[self getCurrentDate]];
}

- (BOOL)shouldNotifyForDate:(NSDate *)date {
    if ((_vlrNotificationSettings.daysUntil >= 0) && (DAYS_SINCE_DATES(_lastUpdate, date) >= _vlrNotificationSettings.daysUntil)) {
        return YES;
    }
    else if ((_vlrNotificationSettings.eventsUntil >= 0) && (_eventCount >= _vlrNotificationSettings.eventsUntil)) {
        return YES;
    }
    
    return NO;
}

# pragma mark - NSCoding protocol

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _lastUpdate              = [decoder decodeObjectForKey:vlrNotificationScheduleLastUpdateDateEncodeKey];
    _eventCount              = [decoder decodeIntegerForKey:vlrNotificationScheduleEventCountEncodeKey];
    _vlrNotificationSettings = [decoder decodeObjectForKey:vlrNotificationScheduleSettingsEncodeKey];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_lastUpdate forKey:vlrNotificationScheduleLastUpdateDateEncodeKey];
    [aCoder encodeInteger:_eventCount forKey:vlrNotificationScheduleEventCountEncodeKey];
    [aCoder encodeObject:_vlrNotificationSettings forKey:vlrNotificationScheduleSettingsEncodeKey];
}

@end
