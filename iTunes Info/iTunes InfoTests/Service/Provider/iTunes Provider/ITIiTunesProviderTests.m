//
//  ITIiTunesProviderTests.m
//  iTunes Info
//
//  Created by Ricardo Casanova on 30/06/2017.
//  Copyright © 2017 Pijp Technologies. All rights reserved.
//

#import <XCTest/XCTest.h>

//__ iTunes Provider
#import "ITIiTunesProvider.h"

@interface ITIiTunesProviderTests : XCTestCase

@property (nonatomic, strong) ITIiTunesProvider *iTunesProvider;

@end

@implementation ITIiTunesProviderTests

- (void)setUp {
    [super setUp];
    self.iTunesProvider = [ITIiTunesProvider new];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testiTunesCreateProvider {
    XCTAssert(self.iTunesProvider != nil, @"TEST FAILED: No provider could be created.");
}

- (void)testSingleSearch {
    XCTestExpectation *search = [self expectationWithDescription:@"search"];
    [self.iTunesProvider iTunesProviderSearchWithTerm:@"beatles" oncompletion:^(NSArray *results, NSInteger errorCode, NSString *errorMessage) {
        XCTAssertEqual(errorCode, ITIErrorNoErrorCode, "TEST FAILED: No response from api.");
        [search fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testCompleteSearch {
    XCTestExpectation *search = [self expectationWithDescription:@"search"];
    [self.iTunesProvider iTunesProviderSearchWithTerm:@"michael+jackson" oncompletion:^(NSArray *results, NSInteger errorCode, NSString *errorMessage) {
        XCTAssertEqual(errorCode, ITIErrorNoErrorCode, "TEST FAILED: No response from api.");
        [search fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testCompleteUpperSearch {
    XCTestExpectation *search = [self expectationWithDescription:@"search"];
    [self.iTunesProvider iTunesProviderSearchWithTerm:@"MICHAEL+JACKSON" oncompletion:^(NSArray *results, NSInteger errorCode, NSString *errorMessage) {
        XCTAssertEqual(errorCode, ITIErrorNoErrorCode, "TEST FAILED: No response from api.");
        [search fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testCompleteUpperLowerSearch {
    XCTestExpectation *search = [self expectationWithDescription:@"search"];
    [self.iTunesProvider iTunesProviderSearchWithTerm:@"MiChAEL+jAckSOn" oncompletion:^(NSArray *results, NSInteger errorCode, NSString *errorMessage) {
        XCTAssertEqual(errorCode, ITIErrorNoErrorCode, "TEST FAILED: No response from api.");
        [search fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

@end
