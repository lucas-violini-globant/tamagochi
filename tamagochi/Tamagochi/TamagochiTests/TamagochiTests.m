//
//  TamagochiTests.m
//  TamagochiTests
//
//  Created by Lucas on 11/18/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TamagochiPet.h"
#import "TamagochiNetworking.h"
#import "PetRanking.h"

@interface TamagochiTests : XCTestCase

@property (nonatomic, strong) TamagochiPet *petForTest;

@end

@implementation TamagochiTests

-(void)startRankingDownload
{
    TamagochiNetworking *tn = [[TamagochiNetworking alloc] init];
    TamagochiTests * __weak weakerSelf = self;
    [tn downloadPetsArrayFromServerWithSuccess:^{[weakerSelf petRankingDownloadSuccess];}
                                       failure:^{[weakerSelf petRankingDownloadFailure];}];
}


-(void)petRankingDownloadFailure
{
    
}

-(void)petRankingDownloadSuccess
{
    
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.petForTest = [TamagochiPet newInstanceClean];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

-(void)test1EnergyStartValue{
    XCTAssertTrue([self.petForTest getEnergy] == 50, @"Test for energy initial value: PASSED");
}

-(void)test2EnergyFluctuation {
    float energyAfterExercise = [self.petForTest getEnergy] - 10;
    [self.petForTest exercise];
    XCTAssertTrue([self.petForTest getEnergy] == energyAfterExercise, @"Test for energy after exercise PASSED");
}

-(void)test3ExperienceResetAfterLevelPassed
{
    self.petForTest = [TamagochiPet newInstanceClean];
    TamagochiFood *food = [[TamagochiFood alloc]  initWithFoodId:6]; //Le doy comida para que nunca quede exhausto (6:Manzana, le da 10 de energia)
    int i;
    for (i=1;i<8;i++)
    {
        [self.petForTest exercise];
        [self.petForTest eatFood:food];
    }
    NSLog(@"Experience is %f and should be 5",[self.petForTest getExperience]);
    //XCTAssertTrue([self.petForTest getExperience] == 5.0f,@"Test for experience PASSED");
}

-(void)test4PetRankingGET
{
    NSLog(@"RANKING COUNT BEFORE TEST: %d",[[PetRanking sharedInstance ]count]);
    XCTestExpectation *expectation = [self expectationWithDescription:@"test4PetRankingGET"];
    TamagochiNetworking *tn = [[TamagochiNetworking alloc] init];
    [tn downloadPetsArrayFromServerWithSuccess:^{XCTAssert([[PetRanking sharedInstance] count] > 0, @"!*!*!*===COUNT OF PET RANKING: %d ===*!*!*!",[[PetRanking sharedInstance] count]);
                                                [expectation fulfill];}
                                       failure:^{XCTAssertFalse([[PetRanking sharedInstance] count] == 0);
                                                 [expectation fulfill];}
     ];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) { if (error) {
        NSLog(@"Timeout Error: %@", error);
        XCTFail(@"Timeout error");
    }
    }];
}

    

@end