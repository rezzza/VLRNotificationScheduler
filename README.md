VLRNotificationScheduler
========================

Simple notification scheduler using thresholds.


## VLRNotificationScheduler

### Attributes:
- NSUInteger usesCount;
- NSDictionnary *VLRNotificationSchedules;

### Methods:
- (VLRNotificationScheduler *) sharedInstance
- (void) setSettings:(VLRNotificationSettings *)settings forKey:(NSString *)key;
- (void) notifyIfNeeded;
- (void) notifyIfNeededForKey:(NSString *)key;
- (void) incrementEventCount
- (void) incrementEventCountForKey:(NSString *)key;


## VLRNotificationSchedule

### Attributes:
- VlRNotificationSettings;
- NSDate *lastUpdate;
- NSUInteger eventCount;

### Methods:
+ (VLRNotificationSchedule *) initWithSettings:(VLRNotificationSettings *)settings;
- (void) incrementEventCount;
- (void) update;
- (BOOL) shouldNotify;


## VLRNotificationSettings
- NSUInteger daysUntil;
- NSUInteger usesUntil;
- NSUInteger eventsUnitl;

+ (VLRNotificationSettings *)initWithDaysUntil:(NSUinterger)days usesUntil:(NSUInteger)uses eventsUntil:(NSUInteger)events;
