//
//  WNCAMLQuery.m
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

#import "WNCAMLQuery.h"

@implementation WNCAMLQuery

+ (xmlNodePtr)queryElementWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors
{
    return [self queryElementWithPredicate:predicate sortDescriptors:sortDescriptors mapping:nil];
}

+ (xmlNodePtr)queryElementWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors fields:(NSArray *)fields
{
    NSMutableDictionary *mapping = [[NSMutableDictionary alloc] initWithCapacity:fields.count];
    for (NSObject *field in fields)
        [mapping setObject:[fields valueForKey:@"name"] forKey:[fields valueForKey:@"displayName"]];
    return [self queryElementWithPredicate:predicate sortDescriptors:sortDescriptors mapping:mapping];
}

+ (xmlNodePtr)queryElementWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors mapping:(NSDictionary *)mapping
{
    mapping = [mapping copy];
    
    xmlNodePtr queryElement = xmlNewNode(NULL, (const xmlChar *)"Query");
    
    xmlNodePtr whereElement = [WNPredicateTransformer transformPredicateIntoWhereElement:predicate mapping:mapping];
    if (whereElement)
        xmlAddChild(queryElement, whereElement);
    
    xmlNodePtr orderElement = [WNSortTransformer transformSortDescriptorsIntoOrderElement:sortDescriptors mapping:mapping];
    if (orderElement)
        xmlAddChild(queryElement, orderElement);
    
    return queryElement;
}

@end
