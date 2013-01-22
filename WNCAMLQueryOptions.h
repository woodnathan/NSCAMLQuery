//
//  WNCAMLQueryOptions.h
//  NSCAML
//
//  Created by Nathan Wood on 22/01/13.
//  Copyright (c) 2013 Nathan Wood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/tree.h>

typedef enum {
    WNCAMLQueryOptionsViewScopeNone = 0,
    WNCAMLQueryOptionsViewScopeRecursive,
    WNCAMLQueryOptionsViewScopeRecursiveAll,
    WNCAMLQueryOptionsViewScopeFilesOnly
} WNCAMLQueryOptionsViewScope;

@interface WNCAMLQueryOptions : NSObject <NSCopying>

- (xmlNodePtr)queryOptionsNode;

@property (nonatomic, assign) BOOL dateInUTC;
@property (nonatomic, copy) NSString *folder;
@property (nonatomic, copy) NSString *listItemCollectionPositionNext; // Paging
@property (nonatomic, assign) BOOL includeMandatoryColumns;
// TODO: @property (nonatomic, assign) int meetingInstanceID;
@property (nonatomic, assign) WNCAMLQueryOptionsViewScope viewAttributes;
// TODO: RecurrencePatternXMLVersion
@property (nonatomic, assign) BOOL includePermissions;
@property (nonatomic, assign) BOOL expandUserField;
@property (nonatomic, assign) BOOL recurrenceOrderBy;
@property (nonatomic, assign) BOOL includeAttachmentURLs;
@property (nonatomic, assign) BOOL includeAttachmentVersion;
@property (nonatomic, assign) BOOL removeInvalidXMLCharacters;
// TODO: OptimizeFor
@property (nonatomic, copy) NSString *extraIDs;
@property (nonatomic, assign) BOOL optimizeLookups;
@property (nonatomic, assign) BOOL includeFragmentChanges;

@end
