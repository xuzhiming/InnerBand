//
//  ArrayTest.m
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

@interface ArrayTest : GHTestCase
@end

@implementation ArrayTest

- (void)setUpClass {
    // Run at start of all tests in the class
}

- (void)tearDownClass {
    // Run at end of all tests in the class
}

- (void)setUp {
    // Run before each test method
}

- (void)tearDown {
    // Run after each test method
}   

- (void)testUnretainingArray {
	NSMutableArray *array = [NSMutableArray arrayUnretaining];
	
	[array addObject:IB_BOX_INT(5)];
}

- (void)testStacks {
    NSMutableArray *array = [NSMutableArray array];
    
    GHAssertEquals(0U, array.count, nil);

    [array pushObject:IB_BOX_INT(1)];
    
    GHAssertEquals(1U, array.count, nil);
    GHAssertEquals(1, IB_UNBOX_INT([array lastObject]), nil);

    [array pushObject:IB_BOX_INT(2)];

    GHAssertEquals(2U, array.count, nil);
    GHAssertEquals(2, IB_UNBOX_INT([array lastObject]), nil);
    
    NSInteger popped = IB_UNBOX_INT([array popObject]);

    GHAssertEquals(1U, array.count, nil);
    GHAssertEquals(2, popped, nil);

    popped = IB_UNBOX_INT([array popObject]);
    
    GHAssertEquals(0U, array.count, nil);
    GHAssertEquals(1, popped, nil);
}

- (void)testQueues {
    NSMutableArray *array = [NSMutableArray array];
    
    GHAssertEquals(0U, array.count, nil);
    
    [array unshiftObject:IB_BOX_INT(1)];
    
    GHAssertEquals(1U, array.count, nil);
    GHAssertEquals(1, IB_UNBOX_INT([array firstObject]), nil);
    
    [array unshiftObject:IB_BOX_INT(2)];
    
    GHAssertEquals(2U, array.count, nil);
    GHAssertEquals(2, IB_UNBOX_INT([array firstObject]), nil);
    
    NSInteger shifted = IB_UNBOX_INT([array shiftObject]);
    
    GHAssertEquals(1U, array.count, nil);
    GHAssertEquals(2, shifted, nil);
    
    shifted = IB_UNBOX_INT([array shiftObject]);
    
    GHAssertEquals(0U, array.count, nil);
    GHAssertEquals(1, shifted, nil);
}

- (void)testDeleteIfEmpty {
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *emptyArray = [NSMutableArray array];

    // nothing there
    [array deleteIf: (ib_enum_bool_t)^(id obj) { return YES; }];
    
    GHAssertEqualObjects(emptyArray, array, nil);
}

- (void)testDeleteIfByNumber {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:IB_BOX_INT(1), IB_BOX_INT(2), IB_BOX_INT(3), IB_BOX_INT(4), IB_BOX_INT(5), nil];
    NSMutableArray *oddArray = [NSMutableArray arrayWithObjects:IB_BOX_INT(1), IB_BOX_INT(3), IB_BOX_INT(5), nil];
    
    // remove the evens
    [array deleteIf: (ib_enum_bool_t)^(id obj) { return (IB_UNBOX_INT(obj) % 2 == 0); }];
    
    GHAssertEqualObjects(oddArray, array, nil);
}

- (void)testMapByNumber {
    NSArray *array = [NSMutableArray arrayWithObjects:IB_BOX_INT(1), IB_BOX_INT(2), IB_BOX_INT(3), IB_BOX_INT(4), IB_BOX_INT(5), nil];
    NSArray *doubledArray = [NSMutableArray arrayWithObjects:IB_BOX_INT(2), IB_BOX_INT(4), IB_BOX_INT(6), IB_BOX_INT(8), IB_BOX_INT(10), nil];
    
    // remove the evens
    NSArray *mappedArray = [array map: (ib_enum_id_t)^(id obj) { return IB_BOX_INT((IB_UNBOX_INT(obj) * 2)); }];
    
    GHAssertEqualObjects(doubledArray, mappedArray, nil);
}

- (void)testMapWithIndexByNumber {
    NSArray *array = [NSMutableArray arrayWithObjects:IB_BOX_INT(1), IB_BOX_INT(2), IB_BOX_INT(3), IB_BOX_INT(4), IB_BOX_INT(5), nil];
    NSArray *doubledArray = [NSMutableArray arrayWithObjects:IB_BOX_INT(2), IB_BOX_INT(4), IB_BOX_INT(6), IB_BOX_INT(8), IB_BOX_INT(10), nil];

    // remove the evens
    NSArray *mappedArray = [array mapWithIndex: (ib_enum_id_int_t)^(id obj, NSInteger idx) { return IB_BOX_INT((IB_UNBOX_INT(obj) * 2)); }];

    GHAssertEqualObjects(doubledArray, mappedArray, nil);
}

- (void)testShuffle {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"A", @"B", @"C", nil];
    
    // shuffle and verify to the best of our ability :-)
    [array shuffle];

    GHAssertTrue([array containsObject:@"A"], nil);
    GHAssertTrue([array containsObject:@"B"], nil);
    GHAssertTrue([array containsObject:@"C"], nil);
    
}

- (void)testShuffledArray {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"A", @"B", @"C", nil];
    NSArray *shuffledArray = [array shuffledArray];
    
    // shuffle and verify to the best of our ability :-)
    GHAssertTrue([shuffledArray containsObject:@"A"], nil);
    GHAssertTrue([shuffledArray containsObject:@"B"], nil);
    GHAssertTrue([shuffledArray containsObject:@"C"], nil);
    
}

- (void)testEmptyReverse {
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *reversedArray = [NSMutableArray array];
    
    [array reverse];
    
    GHAssertEqualObjects(reversedArray, array, nil);
}

- (void)testReverse {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"A", @"B", @"C", nil];
    NSMutableArray *reversedArray = [NSMutableArray arrayWithObjects:@"C", @"B", @"A", nil];
    
    [array reverse];
    
    GHAssertEqualObjects(reversedArray, array, nil);
}

- (void)testEmptyReversedArray {
    NSArray *array = [NSArray array];
    NSArray *reversedArray = [NSArray array];
    
    GHAssertEqualObjects(reversedArray, [array reversedArray], nil);
}

- (void)testReversedArray {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"A", @"B", @"C", nil];
    NSMutableArray *reversedArray = [NSMutableArray arrayWithObjects:@"C", @"B", @"A", nil];
    
    GHAssertEqualObjects(reversedArray, [array reversedArray], nil);
}

@end
