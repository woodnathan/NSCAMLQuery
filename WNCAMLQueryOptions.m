//
//  WNCAMLQueryOptions.m
//  NSCAML
//
//  Created by Nathan Wood on 22/01/13.
//  Copyright (c) 2013 Nathan Wood. All rights reserved.
//

#import "WNCAMLQueryOptions.h"


@interface WNCAMLQueryOptions () {
@private
    xmlNodePtr _xmlNode;
    BOOL _validNode;
}

@property (nonatomic, strong) NSRecursiveLock *lock;

- (void)invalidateNode;
- (xmlNodePtr)generateQueryOptionsElement;

xmlNodePtr xmlNewBooleanNodeOnParent(xmlNodePtr parent, const char *name, BOOL value);
xmlNodePtr xmlNewNodeOnParent(xmlNodePtr parent, const char *name, const char *attr, xmlChar *content);
inline xmlChar *stringValueForBoolean(BOOL boolean);
inline xmlChar *stringValueForString(NSString *string);
inline xmlChar *stringValueForViewScope(WNCAMLQueryOptionsViewScope scope);

@end


@implementation WNCAMLQueryOptions

- (id)init
{
    self = [super init];
    if (self)
    {
        self.lock = [[NSRecursiveLock alloc] init];
    }
    return self;
}

- (void)dealloc
{
    if (self->_xmlNode != NULL)
    {
        xmlFreeNode(self->_xmlNode);
        self->_xmlNode = NULL;
    }
}

- (id)copyWithZone:(NSZone *)zone
{
    WNCAMLQueryOptions *copy = [[[self class] alloc] init];
    copy->_dateInUTC = self->_dateInUTC;
    copy->_folder = [self->_folder copy];
    return copy;
}

- (xmlNodePtr)queryOptionsNode
{
    [self.lock lock];
    if (self->_xmlNode == NULL || self->_validNode == NO)
    {
        if (self->_xmlNode != NULL)
        {
            xmlFreeNode(self->_xmlNode);
            self->_xmlNode = NULL;
        }
        
        self->_xmlNode = [self generateQueryOptionsElement];
        self->_validNode = YES;
    }
    
    xmlNodePtr node = xmlCopyNode(self->_xmlNode, 1);
    [self.lock unlock];
    
    return node;
}

- (void)invalidateNode
{
    [self.lock lock];
    self->_validNode = NO;
    [self.lock unlock];
}

- (xmlNodePtr)generateQueryOptionsElement
{
    xmlNodePtr queryOptsElement = xmlNewNode(NULL, (const xmlChar *)"QueryOptions");
    
    xmlNewBooleanNodeOnParent(queryOptsElement, "DateInUTC", self.dateInUTC);
    if (self.folder)
        xmlNewNodeOnParent(queryOptsElement, "Folder", NULL, stringValueForString(self.folder));
    if (self.listItemCollectionPositionNext)
        xmlNewNodeOnParent(queryOptsElement, "Paging", "ListItemCollectionPositionNext", stringValueForString(self.listItemCollectionPositionNext));
    xmlNewBooleanNodeOnParent(queryOptsElement, "IncludeMandatoryColumns", self.includeMandatoryColumns);
//    TODO: meetingInstanceID
    if (self.viewAttributes != WNCAMLQueryOptionsViewScopeNone)
        xmlNewNodeOnParent(queryOptsElement, "ViewAttributes", "Scope", stringValueForViewScope(self.viewAttributes));
//    TODO: RecurrencePatternXMLVersion
    xmlNewBooleanNodeOnParent(queryOptsElement, "IncludePermissions", self.includePermissions);
    xmlNewBooleanNodeOnParent(queryOptsElement, "ExpandUserField", self.expandUserField);
    xmlNewBooleanNodeOnParent(queryOptsElement, "IncludeAttachmentUrls", self.includeAttachmentURLs);
    xmlNewBooleanNodeOnParent(queryOptsElement, "IncludeAttachmentVersion", self.includeAttachmentVersion);
    xmlNewBooleanNodeOnParent(queryOptsElement, "RemoveInvalidXmlCharacters", self.removeInvalidXMLCharacters);
//    TODO: OptimizeFor
    xmlNewNodeOnParent(queryOptsElement, "ExtraIds", NULL, stringValueForString(self.extraIDs));
    xmlNewBooleanNodeOnParent(queryOptsElement, "OptimizeLookups", self.optimizeLookups);
    xmlNewBooleanNodeOnParent(queryOptsElement, "IncludeFragmentChanges", self.includeFragmentChanges);
    
    return queryOptsElement;
}

#pragma mark - C methods

xmlNodePtr xmlNewBooleanNodeOnParent(xmlNodePtr parent, const char *name, BOOL value)
{
    return xmlNewNodeOnParent(parent, name, NULL, stringValueForBoolean(value));
}

xmlNodePtr xmlNewNodeOnParent(xmlNodePtr parent, const char *name, const char *attr, xmlChar *content)
{
    if (parent == NULL)
        return NULL;
    
    xmlNodePtr node = xmlNewNode(NULL, (xmlChar *)name);
    
    if (attr)
        xmlNewProp(node, (xmlChar *)attr, content);
    else
        xmlNodeSetContent(node, content);
    
    xmlAddChild(parent, node);
    
    return node;
}

xmlChar *stringValueForBoolean(BOOL boolean)
{
    return (xmlChar *)(boolean ? "True" : "False");
}

xmlChar *stringValueForString(NSString *string)
{
    return (xmlChar *)[string UTF8String];
}

xmlChar *stringValueForViewScope(WNCAMLQueryOptionsViewScope scope)
{
    switch (scope) {
        case WNCAMLQueryOptionsViewScopeRecursive:
            return (xmlChar *)"Recursive";
        case WNCAMLQueryOptionsViewScopeRecursiveAll:
            return (xmlChar *)"RecursiveAll";
        case WNCAMLQueryOptionsViewScopeFilesOnly:
            return (xmlChar *)"FilesOnly";
        case WNCAMLQueryOptionsViewScopeNone:
        default:
            break;
    }
    return (xmlChar *)"";
}

@end
