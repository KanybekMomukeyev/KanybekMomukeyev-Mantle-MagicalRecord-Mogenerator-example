//
//  ARPerformanceScout.h
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

#import <Foundation/Foundation.h>

typedef void (^ARpSMeasureBlock)(void);
typedef void (^ARpSCompletionBlock)(NSTimeInterval executionTime);

@interface ARPerformanceScout : NSObject
@end

///--------------------
/// @name ARpS API
///--------------------

/**
 Starts an internal timer when called. To be used with `ARpS_stopTimerAndLog()`.
 */
extern void inline ARpS_startTimer();

/**
 Logs out the time difference from the last `ARpS_startTimer()` call.
 */
extern void inline ARpS_stopTimerAndLog();

/**
 Block the thread the function is being called on for a number of seconds.
 
 @param seconds The number of seconds to block the thread for.
 */
extern void inline ARpS_blockThread(NSTimeInterval seconds);

/**
 Measure the time taken to run a block of code.
 
 @param measureBlock The block of code to be run and measured.
 */
extern void inline ARpS_measure(ARpSMeasureBlock measureBlock);

/**
 Measure the time taken to run a block of code and run a completion block afterwards.
 
 @param measureBlock The block of code to be run and measured.
 @param completionBlock A block of code to be run after `measureBlock` is finished. It contains the time taken to run `measureBlock`.
 */
extern void inline ARpS_measureAndRunCompletionBlock(ARpSMeasureBlock measureBlock, ARpSCompletionBlock completionBlock);

#ifndef DEBUG
#warning You are including this code with a non-DEBUG configuration setup. ARPerformanceScout code should not be delivered in production.
#endif
