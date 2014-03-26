//
//  VLRNotificationSchedulerTests.m
//  VLRNotificationScheduler
//
//  Created by Lucas Ortis on 26/03/2014.
//  Copyright (c) 2014 Lucas Ortis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VLRNotificationSettings.h"
#import "VLRNotificationScheduler.h"

@interface VLRNotificationSchedulerTests : XCTestCase

@end

@implementation VLRNotificationSchedulerTests

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

#pragma mark -- InitSettings

- (void)testInitSettingsValidCase01 {
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:10];
    NSString *key                     = @"MY_KEY";
    
    XCTAssertNoThrow([[VLRNotificationScheduler alloc] initWithSettings:settings forKey:key], @"Fail");
}

- (void)testInitSettingsValidCase02 {
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:10];
    NSString *key                     = @"";
    
    XCTAssertNoThrow([[VLRNotificationScheduler alloc] initWithSettings:settings forKey:key], @"Fail");
}

- (void)testInitSettingsInvalidCase01 {
    VLRNotificationSettings *settings = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:10];
    NSString *key;
    
    XCTAssertThrows([[VLRNotificationScheduler alloc] initWithSettings:settings forKey:key], @"Fail");
}

- (void)testInitSettingsInvalidCase02 {
    VLRNotificationSettings *settings;
    NSString *key                     = @"MY_KEY";
    
    XCTAssertThrows([[VLRNotificationScheduler alloc] initWithSettings:settings forKey:key], @"Fail");
}

- (void)testInitSettingsInvalidCase03 {
    VLRNotificationSettings *settings;
    NSString *key;
    
    XCTAssertThrows([[VLRNotificationScheduler alloc] initWithSettings:settings forKey:key], @"Fail");
}

#pragma mark - UpdateSettings

- (void)testUpdateSettingsValidCase01 {
    VLRNotificationSettings *settings   = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:10];
    VLRNotificationScheduler *scheduler = [[VLRNotificationScheduler alloc] init];
    NSString *key                       = @"MY_KEY";
    NSError *error;
    
    XCTAssertNoThrow([scheduler updateSettings:settings forKey:key andError:&error], @"Fail");
}

- (void)testUpdateSettingsValidCase02 {
    VLRNotificationSettings *settings   = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:10];
    VLRNotificationScheduler *scheduler = [[VLRNotificationScheduler alloc] init];
    NSString *key                       = @"";
    
    XCTAssertNoThrow([scheduler updateSettings:settings forKey:key andError:nil], @"Fail");
}

- (void)testUpdateSettingsInvalidCase01 {
    VLRNotificationSettings *settings   = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:10];
    VLRNotificationScheduler *scheduler = [[VLRNotificationScheduler alloc] init];
    NSString *key;
    
    XCTAssertThrows([scheduler updateSettings:settings forKey:key andError:nil], @"Fail");
}

- (void)testUpdateSettingsInvalidCase02 {
    VLRNotificationSettings *settings;
    VLRNotificationScheduler *scheduler = [[VLRNotificationScheduler alloc] init];
    NSString *key                       = @"MY_KEY";
    
    XCTAssertThrows([scheduler updateSettings:settings forKey:key andError:nil], @"Fail");
}

- (void)testUpdateSettingsInvalidCase03 {
    VLRNotificationSettings *settings;
    VLRNotificationScheduler *scheduler = [[VLRNotificationScheduler alloc] init];
    NSString *key;
    
    XCTAssertThrows([scheduler updateSettings:settings forKey:key andError:nil], @"Fail");
}

#pragma mark - NotifyIfNeededForKey

- (void)testNotifyIfNeededForKeyValidCase01 {
    VLRNotificationSettings *settings   = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:10];
    VLRNotificationScheduler *scheduler = [[VLRNotificationScheduler alloc] init];
    NSString *key                       = @"MY_KEY";
    
    [scheduler initWithSettings:settings forKey:key];
    [scheduler updateSettings:settings forKey:key andError:nil];
    
    XCTAssertNoThrow([scheduler notifyIfNeededForKey:key], @"Fail");
}

- (void)testNotifyIfNeededForKeyInvalidCase01 {
    VLRNotificationScheduler *scheduler = [[VLRNotificationScheduler alloc] init];
    NSString *key                       = @"ANOTHER_KEY";
    
    XCTAssertThrows([scheduler notifyIfNeededForKey:key], @"failed");
}

- (void)testNotifyIfNeededForKeyInvalidCase02 {
    VLRNotificationScheduler *scheduler = [[VLRNotificationScheduler alloc] init];
    NSString *key;
    
    XCTAssertThrows([scheduler notifyIfNeededForKey:key], @"failed");
}

#pragma mark - AllKeys

- (void)testAllKeysValidCase01 {
    VLRNotificationSettings *settings   = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:10];
    VLRNotificationScheduler *scheduler = [[VLRNotificationScheduler alloc] init];
    NSString *key                       = @"MY_KEY";
    
    [scheduler initWithSettings:settings forKey:key];
    
    XCTAssertNotNil([scheduler allKeys], @"Failed");
}

- (void)testAllKeysValidCase02 {
    VLRNotificationScheduler *scheduler = [[VLRNotificationScheduler alloc] init];
    
    XCTAssertNotNil([scheduler allKeys], @"Failed");
}

- (void)testAllKeysValidCase03 {
    VLRNotificationSettings *settings   = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:10];
    VLRNotificationScheduler *scheduler = [[VLRNotificationScheduler alloc] init];
    NSString *key                       = @"MY_KEY";
    
    [scheduler initWithSettings:settings forKey:key];
    
    XCTAssertNotEqual([[scheduler allKeys] count], 0, @"Failed");
}

#pragma mark - IncrementEventCount

- (void)testIncrementEventCountValidCase01 {
    VLRNotificationSettings *settings   = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:10];
    VLRNotificationScheduler *scheduler = [[VLRNotificationScheduler alloc] init];
    NSString *key                       = @"MY_KEY";
    
    [scheduler initWithSettings:settings forKey:key];
    
    XCTAssertNoThrow([scheduler incrementEventCountForKey:key], @"Failed");
}

- (void)testIncrementEventCountValidCase02 {
    VLRNotificationSettings *settings   = [[VLRNotificationSettings alloc] initWithDaysUntil:10 eventsUntil:10];
    VLRNotificationScheduler *scheduler = [[VLRNotificationScheduler alloc] init];
    NSString *key                       = @"";
    
    [scheduler initWithSettings:settings forKey:key];
    
    XCTAssertNoThrow([scheduler incrementEventCountForKey:key], @"Failed");
}

- (void)testIncrementEventCountInvalidCase01 {
    VLRNotificationScheduler *scheduler = [[VLRNotificationScheduler alloc] init];
    NSString *key;
    
    XCTAssertThrows([scheduler incrementEventCountForKey:key], @"Failed");
}

- (void)testIncrementEventCountInvalidCase02 {
    VLRNotificationScheduler *scheduler = [[VLRNotificationScheduler alloc] init];
    NSString *key                       = @"ANOTHER_KEY";
    
    XCTAssertThrows([scheduler incrementEventCountForKey:key], @"Failed");
}

@end
