//
//  HoleTest.m
//  GolfScore
//
//  Created by 中川 高志 on 2013/03/09.
//  Copyright (c) 2013年 CFlat. All rights reserved.
//

#import "HoleTest.h"
#import "Hole.h"
@implementation HoleTest {
    Hole *hole;
    CLLocation *nowLocation, *posLocation;
}

- (void)setUp {
    hole = [[Hole alloc] initWithPer:3];
    CLLocationCoordinate2D loc1, loc2;
    loc1.latitude = 34.701909;
    loc1.longitude = 135.4949770;
    nowLocation = [[CLLocation alloc] initWithLatitude:loc1.latitude
                                                         longitude:loc1.longitude];
    loc2.latitude    = 35.681382;
    loc2.longitude    =139.766084;
    posLocation = [[CLLocation alloc] initWithLatitude:loc2.latitude
                                                         longitude:loc2.longitude];
}

- (void)tearDown {
    [NSThread sleepForTimeInterval:1.0];
    hole = nil;
}

- (void)testHoleHasPerValue{
    STAssertTrue(hole.per >= 0, @"Hole should have 0 or positive per score");
}

- (void)testHoleCanAddStroke {
    [hole addStrokeAtLocation:nowLocation];
    [hole addStrokeAtLocation:posLocation];
    STAssertTrue(hole.totalStroke == 2, @"Hole can Add Stroke");
}

- (void)testDistanceFromStartPosition {
    STAssertNoThrow([hole distanceFromStartPositionInMiles], @"Hole should know the distance from start position");
}

- (void)testCalcDistanceFromStartPosition {
    [hole addStrokeAtLocation:nowLocation];
    [hole addStrokeAtLocation:posLocation];
    NSUInteger dist = [hole distanceFromStartPositionInMiles];
    STAssertTrue(dist > 249 && dist < 251, @"Distance is between 249 and 251 miles");
}

- (void)testStrokeCountAndLocationCountIsSame {
    [hole addStrokeAtLocation:nowLocation];
    [hole addStrokeAtLocation:posLocation];
    STAssertEquals(hole.totalStroke, [hole.locations count], @"TotalStroke and location count should be the same");
}

@end
