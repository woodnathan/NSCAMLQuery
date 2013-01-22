//
//  WNCAMLQuery.h
//
//  Copyright (c) 2013 Nathan Wood (http://www.woodnathan.com/)
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
#import <libxml/tree.h>
#import "WNPredicateTransformer.h"
#import "WNSortTransformer.h"
#import "WNCAMLQueryOptions.h"

@interface WNCAMLQuery : NSObject

+ (xmlNodePtr)queryElementWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors;
+ (xmlNodePtr)queryElementWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors fields:(NSArray *)fields;
+ (xmlNodePtr)queryElementWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors mapping:(NSDictionary *)mapping;

@end
