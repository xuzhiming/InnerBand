//
//  FunctionTest.m
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

@interface FunctionTest : GHTestCase
@end

@implementation FunctionTest

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

- (void)testBounds {
	CGRect IB_RECT_50_X_100_SIZED_200_BY_400 = CGRectMake(50, 100, 200, 400);
	CGRect rect;
	
	rect = IB_RECT_INSET_BY_LEFT_TOP_RIGHT_BOTTOM(IB_RECT_50_X_100_SIZED_200_BY_400, 10, 20, 30, 40);
	GHAssertEquals(CGRectMake(60, 120, 160, 340), rect, nil);
    
	rect = IB_RECT_INSET_BY_TOP_BOTTOM(IB_RECT_50_X_100_SIZED_200_BY_400, 30, 60);
	GHAssertEquals(CGRectMake(50, 130, 200, 310), rect, nil);
    
	rect = IB_RECT_INSET_BY_LEFT_RIGHT(IB_RECT_50_X_100_SIZED_200_BY_400, 30, 60);
	GHAssertEquals(CGRectMake(80, 100, 110, 400), rect, nil);

    rect = IB_RECT_WITH_X(IB_RECT_50_X_100_SIZED_200_BY_400, 10);
	GHAssertEquals(CGRectMake(10, 100, 200, 400), rect, nil);
    
	rect = IB_RECT_WITH_Y(IB_RECT_50_X_100_SIZED_200_BY_400, 10);
	GHAssertEquals(CGRectMake(50, 10, 200, 400), rect, nil);
    
	rect = IB_RECT_WITH_X_Y(IB_RECT_50_X_100_SIZED_200_BY_400, 10, 20);
	GHAssertEquals(CGRectMake(10, 20, 200, 400), rect, nil);

    rect = IB_RECT_OFFSET_X(IB_RECT_50_X_100_SIZED_200_BY_400, 1);
	GHAssertEquals(CGRectMake(51, 100, 200, 400), rect, nil);

    rect = IB_RECT_OFFSET_Y(IB_RECT_50_X_100_SIZED_200_BY_400, 1);
	GHAssertEquals(CGRectMake(50, 101, 200, 400), rect, nil);

	rect = IB_RECT_WITH_WIDTH_HEIGHT(IB_RECT_50_X_100_SIZED_200_BY_400, 60, 80);
	GHAssertEquals(CGRectMake(50, 100, 60, 80), rect, nil);
    
	rect = IB_RECT_WITH_WIDTH(IB_RECT_50_X_100_SIZED_200_BY_400, 120);
	GHAssertEquals(CGRectMake(50, 100, 120, 400), rect, nil);

	rect = IB_RECT_WITH_WIDTH_FROM_RIGHT(IB_RECT_50_X_100_SIZED_200_BY_400, 50);
	GHAssertEquals(CGRectMake(200, 100, 50, 400), rect, nil);

	rect = IB_RECT_WITH_HEIGHT(IB_RECT_50_X_100_SIZED_200_BY_400, 150);
	GHAssertEquals(CGRectMake(50, 100, 200, 150), rect, nil);
    
	rect = IB_RECT_STACKED_OFFSET_BY_X(IB_RECT_50_X_100_SIZED_200_BY_400, 10);
	GHAssertEquals(CGRectMake(260, 100, 200, 400), rect, nil);
    
	rect = IB_RECT_STACKED_OFFSET_BY_Y(IB_RECT_50_X_100_SIZED_200_BY_400, 10);
	GHAssertEquals(CGRectMake(50, 510, 200, 400), rect, nil);
}

- (void)testBoxing {
	GHAssertEquals(NO, IB_UNBOX_BOOL(IB_BOX_BOOL(NO)), nil);
	GHAssertEquals(0, IB_UNBOX_INT(IB_BOX_INT(0)), nil);
	GHAssertEquals(0L, IB_UNBOX_LONG(IB_BOX_LONG(0L)), nil);
	GHAssertEquals(0U, IB_UNBOX_UINT(IB_BOX_UINT(0U)), nil);
	GHAssertEqualsWithAccuracy(0.0F, IB_UNBOX_FLOAT(IB_BOX_FLOAT(0.0F)), 0.000001, nil);
	GHAssertEqualsWithAccuracy(0.0, IB_UNBOX_DOUBLE(IB_BOX_DOUBLE(0.0)), 0.000001, nil);
	
	GHAssertEquals(YES, IB_UNBOX_BOOL(IB_BOX_BOOL(YES)), nil);
	GHAssertEquals(1, IB_UNBOX_INT(IB_BOX_INT(1)), nil);
	GHAssertEquals(1L, IB_UNBOX_LONG(IB_BOX_LONG(1L)), nil);
	GHAssertEquals(1U, IB_UNBOX_UINT(IB_BOX_UINT(1U)), nil);
	GHAssertEqualsWithAccuracy(1.0F, IB_UNBOX_FLOAT(IB_BOX_FLOAT(1.0F)), 0.000001, nil);
	GHAssertEqualsWithAccuracy(1.0, IB_UNBOX_DOUBLE(IB_BOX_DOUBLE(1.0)), 0.000001, nil);
}

- (void)testStringify {
	GHAssertEqualObjects(@"0", IB_STRINGIFY_INT(0), nil);
	GHAssertEqualObjects(@"1", IB_STRINGIFY_INT(1), nil);
}

- (void)testColorConversions {
	GHAssertEquals(1.0f, IB_RGB256_TO_COL(IB_COL_TO_RGB256(1.0)), nil);
	GHAssertEquals(0.0f, IB_RGB256_TO_COL(0), nil);
	GHAssertEquals(1.0f, IB_RGB256_TO_COL(255), nil);
}

- (void)testNumericIntegerConstraints {
    GHAssertEquals(0, IB_CONSTRAINED_INT_VALUE(-1, 0, 100), nil);    
    GHAssertEquals(0, IB_CONSTRAINED_INT_VALUE(0, 0, 100), nil);    
    GHAssertEquals(1, IB_CONSTRAINED_INT_VALUE(1, 0, 100), nil);    
    GHAssertEquals(99, IB_CONSTRAINED_INT_VALUE(99, 0, 100), nil);    
    GHAssertEquals(100, IB_CONSTRAINED_INT_VALUE(100, 0, 100), nil);    
    GHAssertEquals(100, IB_CONSTRAINED_INT_VALUE(101, 0, 100), nil);    
}

- (void)testNumericFloatDoubleConstraints {
    GHAssertEqualsWithAccuracy(0.5f, IB_CONSTRAINED_FLOAT_VALUE(0.0f, 0.5f, 99.5f), 0.01f, nil);    
    GHAssertEqualsWithAccuracy(0.5f, IB_CONSTRAINED_FLOAT_VALUE(0.5f, 0.5f, 99.5f), 0.01f, nil);    
    GHAssertEqualsWithAccuracy(1.0f, IB_CONSTRAINED_FLOAT_VALUE(1.0f, 0.5f, 99.5f), 0.01f, nil);    
    GHAssertEqualsWithAccuracy(99.0f, IB_CONSTRAINED_FLOAT_VALUE(99.0f, 0.5f, 99.5f), 0.01f, nil);    
    GHAssertEqualsWithAccuracy(99.5f, IB_CONSTRAINED_FLOAT_VALUE(99.5f, 0.5f, 99.5f), 0.01f, nil);    
    GHAssertEqualsWithAccuracy(99.5f, IB_CONSTRAINED_FLOAT_VALUE(100.0f, 0.5f, 99.5f), 0.01f, nil);    

    GHAssertEqualsWithAccuracy(0.5, IB_CONSTRAINED_DOUBLE_VALUE(0.0, 0.5, 99.5), 0.01, nil);    
    GHAssertEqualsWithAccuracy(0.5, IB_CONSTRAINED_DOUBLE_VALUE(0.5, 0.5, 99.5), 0.01, nil);    
    GHAssertEqualsWithAccuracy(1.0, IB_CONSTRAINED_DOUBLE_VALUE(1.0, 0.5, 99.5), 0.01, nil);    
    GHAssertEqualsWithAccuracy(99.0, IB_CONSTRAINED_DOUBLE_VALUE(99.0, 0.5, 99.5), 0.01, nil);    
    GHAssertEqualsWithAccuracy(99.5, IB_CONSTRAINED_DOUBLE_VALUE(99.5, 0.5, 99.5), 0.01, nil);    
    GHAssertEqualsWithAccuracy(99.5, IB_CONSTRAINED_DOUBLE_VALUE(100.0, 0.5, 99.5), 0.01, nil);    
}

@end
