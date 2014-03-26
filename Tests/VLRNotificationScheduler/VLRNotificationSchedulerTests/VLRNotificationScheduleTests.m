//
//  VLRNotificationScheduleTests.m
//  VLRNotificationScheduler
//
//  Created by Lucas Ortis on 26/03/2014.
//  Copyright (c) 2014 Lucas Ortis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VLRNotificationSchedule.h"
#import "VLRNotificationSettings.h"

@interface VLRNotificationScheduleTests : XCTestCase

@end

@implementation VLRNotificationScheduleTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - InitWithSettings

- (void)testInitWithSettings {
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:0 eventsUntil:0];
    VLRNotificationSchedule *schedule = [[VLRNotificationSchedule alloc] initWithSettings:settings];
    
    XCTAssertNoThrow([[VLRNotificationSchedule alloc] initWithSettings:settings], @"Fail");
    XCTAssertEqual(schedule.vlrNotificationSettings.daysUntil, settings.daysUntil, @"Fail %s", __PRETTY_FUNCTION__);
    XCTAssertEqual(schedule.vlrNotificationSettings.eventsUntil, settings.eventsUntil, @"Fail %s", __PRETTY_FUNCTION__);
}

- (void)testInitWithSettingsNil {
    XCTAssertThrows([[VLRNotificationSchedule alloc] initWithSettings:nil], @"Fail : Settings can't be nil");
}

#pragma mark - UpdateSeetings

- (void)testUpdateSettings {
    VLRNotificationSettings *firstSettings  = [[VLRNotificationSettings alloc] initWithDaysUntil:0 eventsUntil:0];
    VLRNotificationSettings *secondSettings = [[VLRNotificationSettings alloc] initWithDaysUntil:0 eventsUntil:0];
    VLRNotificationSchedule *schedule       = [[VLRNotificationSchedule alloc] initWithSettings:firstSettings];
    
    [schedule updateSettings:secondSettings];
    
    XCTAssertNotNil(schedule, @"failed");
}

- (void)testUpdateSettingsNil {
    VLRNotificationSettings *firstSettings  = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:0];
    VLRNotificationSettings *secondSettings = nil;
    VLRNotificationSchedule *schedule       = [[VLRNotificationSchedule alloc] initWithSettings:firstSettings];
    
    XCTAssertThrows([schedule updateSettings:secondSettings], @"settings can't be nil");
}

#pragma mark - ShouldNotify

- (void)testShouldNotifyValidCaseWithEvent01 {
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:0];
    VLRNotificationSchedule *schedule = [[VLRNotificationSchedule alloc] initWithSettings:settings];
    
    XCTAssertTrue([schedule shouldNotify], @"failed");
}

- (void)testShouldNotifyValidCaseWithEvent02 {
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:1];
    VLRNotificationSchedule *schedule = [[VLRNotificationSchedule alloc] initWithSettings:settings];
    
    [schedule incrementEventCount];
    
    XCTAssertTrue([schedule shouldNotify], @"failed");
}

- (void)testShouldNotifyValidCaseWithEvent03 {
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:1];
    VLRNotificationSchedule *schedule = [[VLRNotificationSchedule alloc] initWithSettings:settings];
    
    [schedule incrementEventCount];
    [schedule incrementEventCount];
    
    XCTAssertTrue([schedule shouldNotify], @"failed");
}

- (void)testShouldNotifyInvalidCaseWithEvent01 {
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:1];
    VLRNotificationSchedule *schedule = [[VLRNotificationSchedule alloc] initWithSettings:settings];
    
    XCTAssertFalse([schedule shouldNotify], @"failed");
}

- (void)testShouldNotifyInvalidCaseWithEvent02 {
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:2];
    VLRNotificationSchedule *schedule = [[VLRNotificationSchedule alloc] initWithSettings:settings];
    
    [schedule incrementEventCount];
    
    XCTAssertFalse([schedule shouldNotify], @"failed");
}

- (void)testShouldNotifyInvalidCaseWithEvent03 {
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:1];
    VLRNotificationSchedule *schedule = [[VLRNotificationSchedule alloc] initWithSettings:settings];
    
    [schedule incrementEventCount];
    [schedule incrementEventCount];
    
    [schedule resetIfNeeded];
    
    XCTAssertFalse([schedule shouldNotify], @"failed");
}

- (void)testShouldNotifyInvalidCaseWithEvent04 {
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:-1];
    VLRNotificationSchedule *schedule = [[VLRNotificationSchedule alloc] initWithSettings:settings];
    
    XCTAssertFalse([schedule shouldNotify], @"failed");
}

- (void)testShouldNotifyInvalidCaseWithEvent05 {
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:-1];
    VLRNotificationSchedule *schedule = [[VLRNotificationSchedule alloc] initWithSettings:settings];
    
    [schedule incrementEventCount];
    [schedule incrementEventCount];
    
    XCTAssertFalse([schedule shouldNotify], @"failed");
}

- (void)testShouldNotifyValidCaseWithDays01 {
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:0 eventsUntil:10];
    VLRNotificationSchedule *schedule = [[VLRNotificationSchedule alloc] initWithSettings:settings];
    
    XCTAssertTrue([schedule shouldNotify], @"failed");
}

- (void)testShouldNotifyValidCaseWithDays02 {
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:3 eventsUntil:10];
    VLRNotificationSchedule *schedule = [[VLRNotificationSchedule alloc] initWithSettings:settings];
    
    XCTAssertTrue([schedule shouldNotifyForDate:[NSDate dateWithTimeIntervalSinceNow:86400*3]], @"failed");
}

- (void)testShouldNotifyInvalidCaseWithDays01 {
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:10];
    VLRNotificationSchedule *schedule = [[VLRNotificationSchedule alloc] initWithSettings:settings];
    
    XCTAssertFalse([schedule shouldNotify], @"failed");
}

- (void)testShouldNotifyInvalidCaseWithDays02 {
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:-1 eventsUntil:10];
    VLRNotificationSchedule *schedule = [[VLRNotificationSchedule alloc] initWithSettings:settings];
    
    XCTAssertFalse([schedule shouldNotify], @"failed");
}

- (void)testShouldNotifyInvalidCaseWithDays03 {
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:5 eventsUntil:10];
    VLRNotificationSchedule *schedule = [[VLRNotificationSchedule alloc] initWithSettings:settings];
    
    XCTAssertFalse([schedule shouldNotifyForDate:[NSDate dateWithTimeIntervalSinceNow:86400*3]], @"failed");
}

@end
