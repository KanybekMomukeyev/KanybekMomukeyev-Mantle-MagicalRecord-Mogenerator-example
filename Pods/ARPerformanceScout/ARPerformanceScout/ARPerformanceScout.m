//
//  ARPerformanceScout.m
//
// Copyright (c) 2013 Artsy (http://artsy.net/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ARPerformanceScout.h"

static NSDate *_timerStartDate = nil;
static BOOL _timerStarted = NO;

@interface ARPerformanceScout()
+ (void)startTimer;
+ (void)stopTimerAndLog;
+ (void)measure:(ARpSMeasureBlock)block;
+ (void)measure:(ARpSMeasureBlock)block completion:(ARpSCompletionBlock)completion;
+ (void)blockCurrentThreadForNumberOfSeconds:(NSTimeInterval)seconds;
@end

@implementation ARPerformanceScout

#pragma mark - Blocking

+ (void)blockCurrentThreadForNumberOfSeconds:(NSTimeInterval)seconds {
    [NSThread sleepForTimeInterval:seconds];
}

#pragma mark - Execution time measurements

+ (void)measure:(ARpSMeasureBlock)block {
    [ARPerformanceScout measure:block completion:^(NSTimeInterval executionTime) {
        [ARPerformanceScout logMeasureExecutionTimeResult:executionTime];
    }];
}

+ (void)measure:(ARpSMeasureBlock)block completion:(ARpSCompletionBlock)completion {
    NSDate *startDate = [NSDate date];
    block();
    NSDate *finishDate = [NSDate date];
    NSTimeInterval executionTime = [finishDate timeIntervalSinceDate:startDate];
    completion(executionTime);
}

#pragma mark - Time profiling methods

+ (void)startTimer {
    if (_timerStarted) {
        return;
    }
    _timerStarted = YES;
    _timerStartDate = [NSDate date];
}

+ (void)stopTimerAndLog {
    if (NO == _timerStarted) {
        return;
    }
    
    NSTimeInterval runningTime = [[NSDate date] timeIntervalSinceDate:_timerStartDate];
    [ARPerformanceScout logStopTimerResult:runningTime];
    _timerStarted = NO;
}

#pragma mark - Logging methods

+ (void)logStopTimerResult:(NSTimeInterval)runningTimeInterval {
    printf("\n≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌\n⊛ ARPerformanceScout ⊛\n\n✔ Timed: %fs\n≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌\n",runningTimeInterval);
}

+ (void)logMeasureExecutionTimeResult:(NSTimeInterval)executionTime {    
    printf("\n≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌\n⊛ ARPerformanceScout ⊛\n\n✔ Measured: %fs\n≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌≌\n",executionTime);
}

#pragma mark - Inline C functions API

void inline ARpS_startTimer() {
    [ARPerformanceScout startTimer];
}

void inline ARpS_stopTimerAndLog() {
    [ARPerformanceScout stopTimerAndLog];
}

void inline ARpS_blockThread(NSTimeInterval seconds) {
    [ARPerformanceScout blockCurrentThreadForNumberOfSeconds:seconds];
}

void inline ARpS_measure(ARpSMeasureBlock measureBlock) {
    [ARPerformanceScout measure:measureBlock];
}

void inline ARpS_measureAndRunCompletionBlock(ARpSMeasureBlock measureBlock, ARpSCompletionBlock completionBlock) {
    [ARPerformanceScout measure:measureBlock completion:completionBlock];
}

@end
