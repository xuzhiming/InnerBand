//
//  CoreDataTest.m
//  InnerBand
//
//  InnerBand - The iOS Booster!
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//


#import "GHUnit.h"
#import "InnerBand.h"
#import "CoreDataWidget.h"

@interface CoreDataTest : GHTestCase

- (NSManagedObject *)makeWidgetWithInteger:(NSInteger)value;
- (NSManagedObject *)makeWidgetInstanceWithInteger:(NSInteger)value;
- (NSManagedObject *)makeWidgetInstanceWithInteger:(NSInteger)value inStore:(IBCoreDataStore *)store;
- (NSManagedObject *)makeWidgetWithBool:(BOOL)value;
- (NSManagedObject *)makeWidgetWithFloat:(float)value;

@end

@implementation CoreDataTest

- (void)setUpClass {
    // Run at start of all tests in the class
}

- (void)tearDownClass {
    // Run at end of all tests in the class
}

- (void)setUp {
	IBCoreDataStore *store = [IBCoreDataStore mainStore];
	
    // Run before each test method
	[store clearAllData];
}

- (void)tearDown {
    // Run after each test method
}   

- (void)testInitialization {
	NSArray *widgets;
	NSError *error = nil;
	IBCoreDataStore *store = [IBCoreDataStore mainStore];

	widgets = [store allForEntity:@"CoreDataWidget" error:&error];
	GHAssertEquals(0U, widgets.count, nil);
}

- (void)testCreation {
	NSArray *widgets;
	NSError *error = nil;
	IBCoreDataStore *store = [IBCoreDataStore mainStore];

	// add 1
	[self makeWidgetWithInteger:0];

	widgets = [store allForEntity:@"CoreDataWidget" error:&error];
	GHAssertEquals(1U, widgets.count, nil);

	// add 2
	[self makeWidgetWithInteger:0];
	
	widgets = [store allForEntity:@"CoreDataWidget" error:&error];
	GHAssertEquals(2U, widgets.count, nil);
}

- (void)testInstanceCreation {
	NSArray *widgets;
    
	// add 1
	[self makeWidgetInstanceWithInteger:0];
    
	widgets = [CoreDataWidget all];
	GHAssertEquals(1U, widgets.count, nil);
    
	// add 2
	[self makeWidgetInstanceWithInteger:0];
	
	widgets = [CoreDataWidget all];
	GHAssertEquals(2U, widgets.count, nil);
}

- (void)testInstanceStoreCreation {
	NSArray *widgets;
    IBCoreDataStore *store = [IBCoreDataStore createStore];
    
	// add 1
	[self makeWidgetInstanceWithInteger:0 inStore:store];
    
	widgets = [CoreDataWidget allInStore:store];
	GHAssertEquals(1U, widgets.count, nil);
    
	// add 2
	[self makeWidgetInstanceWithInteger:0 inStore:store];
	
	widgets = [CoreDataWidget allInStore:store];
	GHAssertEquals(2U, widgets.count, nil);
}

- (void)testRemove {
	NSArray *widgets;
	NSError *error = nil;
	
	IBCoreDataStore *store = [IBCoreDataStore mainStore];
	
	// add 3
	widgets = [NSArray arrayWithObjects:[self makeWidgetWithInteger:0], [self makeWidgetWithInteger:0], [self makeWidgetWithInteger:0], nil];
	
	// remove each
	do {
		// how many left?
		NSUInteger count = [store allForEntity:@"CoreDataWidget" error:&error].count;
		
		// remove one
        [[widgets lastObject] destroy];
		
		// verify what's left
		widgets = [store allForEntity:@"CoreDataWidget" error:&error];
		GHAssertEquals(count - 1, widgets.count, nil);
	} while (widgets.count > 0);
}

- (void)testRemoveAll {
	NSArray *widgets;
	NSError *error = nil;
	IBCoreDataStore *store = [IBCoreDataStore mainStore];
	
	// add some
	[self makeWidgetWithInteger:0];
	[self makeWidgetWithInteger:0];
	[self makeWidgetWithInteger:0];
	
	widgets = [store allForEntity:@"CoreDataWidget" error:&error];
	GHAssertEquals(3U, widgets.count, nil);
	
	// remove them all
	[store removeAllEntitiesByName:@"CoreDataWidget"];

	widgets = [store allForEntity:@"CoreDataWidget" error:&error];
	GHAssertEquals(0U, widgets.count, nil);
}

- (void)testSearchByKey {
	NSError *error = nil;
	IBCoreDataStore *store = [IBCoreDataStore mainStore];
	
	// add some
	[self makeWidgetWithInteger:0];
	[self makeWidgetWithInteger:1];
	[self makeWidgetWithInteger:2];
	
	// search
	NSManagedObject *obj = [store entityByName:@"CoreDataWidget" key:@"i" value:IB_BOX_INT(1) error:&error];
	
	GHAssertNotEquals(IB_BOX_INT(0), [obj valueForKey:@"i"], nil);
	GHAssertEquals(IB_BOX_INT(1), [obj valueForKey:@"i"], nil);
	GHAssertNotEquals(IB_BOX_INT(2), [obj valueForKey:@"i"], nil);
}

- (NSManagedObject *)makeWidgetWithInteger:(NSInteger)value {
	IBCoreDataStore *store = [IBCoreDataStore mainStore];
	NSManagedObject *widget = [store createNewEntityByName:@"CoreDataWidget"];
	[widget setValue:IB_BOX_INT(value) forKey:@"i"];
	
	return widget;
}

- (NSManagedObject *)makeWidgetInstanceWithInteger:(NSInteger)value {
	CoreDataWidget *widget = [CoreDataWidget create];
	[widget setValue:IB_BOX_INT(value) forKey:@"i"];
	
	return widget;
}

- (NSManagedObject *)makeWidgetInstanceWithInteger:(NSInteger)value inStore:(IBCoreDataStore *)store {
	CoreDataWidget *widget = [CoreDataWidget createInStore:store];
	[widget setValue:IB_BOX_INT(value) forKey:@"i"];
	
	return widget;
}

- (NSManagedObject *)makeWidgetWithBool:(BOOL)value {
	IBCoreDataStore *store = [IBCoreDataStore mainStore];
	NSManagedObject *widget = [store createNewEntityByName:@"CoreDataWidget"];
	[widget setValue:IB_BOX_BOOL(value) forKey:@"b"];
	
	return widget;
}

- (NSManagedObject *)makeWidgetWithFloat:(float)value {
	IBCoreDataStore *store = [IBCoreDataStore mainStore];
	NSManagedObject *widget = [store createNewEntityByName:@"CoreDataWidget"];
	[widget setValue:IB_BOX_FLOAT(value) forKey:@"f"];
	
	return widget;
}
@end
