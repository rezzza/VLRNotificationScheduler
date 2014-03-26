//
//  VLRNotificationSettingsTests.m
//  VLRNotificationScheduler
//
//  Created by Lucas Ortis on 25/03/2014.
//  Copyright (c) 2014 Lucas Ortis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VLRNotificationSettings.h"

@interface VLRNotificationSettingsTests : XCTestCase

@end

@implementation VLRNotificationSettingsTests

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

- (void)testDaysUntilPositive {
    NSInteger  days = 3;
    
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:days eventsUntil:0];
    
    XCTAssertEqual(settings.daysUntil, days, @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testDaysUntilZero {
    NSInteger  days = 0;
    
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:days eventsUntil:0];
    
    XCTAssertEqual(settings.daysUntil, days, @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testEventsUntilPositive {
    NSInteger  events = 3;
    
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:events eventsUntil:0];
    
    XCTAssertEqual(settings.daysUntil, events, @"%s Failed", __PRETTY_FUNCTION__);
}

- (void)testEventsUntilZero {
    NSInteger  events = 0;
    
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:events eventsUntil:0];
    
    XCTAssertEqual(settings.daysUntil, events, @"%s Failed", __PRETTY_FUNCTION__);
}

@end
