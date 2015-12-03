//
//  LWChatPager.m
//
//  Created by   on 15/11/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWChatPager.h"


NSString *const kLWChatPagerEndRow = @"endRow";
NSString *const kLWChatPagerPageSize = @"pageSize";
NSString *const kLWChatPagerGetCount = @"getCount";
NSString *const kLWChatPagerLastPage = @"lastPage";
NSString *const kLWChatPagerStartRow = @"startRow";
NSString *const kLWChatPagerTotalRows = @"totalRows";
NSString *const kLWChatPagerCurrentPage = @"currentPage";
NSString *const kLWChatPagerFirstPage = @"firstPage";
NSString *const kLWChatPagerTotalPages = @"totalPages";


@interface LWChatPager ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWChatPager

@synthesize endRow = _endRow;
@synthesize pageSize = _pageSize;
@synthesize getCount = _getCount;
@synthesize lastPage = _lastPage;
@synthesize startRow = _startRow;
@synthesize totalRows = _totalRows;
@synthesize currentPage = _currentPage;
@synthesize firstPage = _firstPage;
@synthesize totalPages = _totalPages;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.endRow = [[self objectOrNilForKey:kLWChatPagerEndRow fromDictionary:dict] doubleValue];
            self.pageSize = [[self objectOrNilForKey:kLWChatPagerPageSize fromDictionary:dict] doubleValue];
            self.getCount = [[self objectOrNilForKey:kLWChatPagerGetCount fromDictionary:dict] boolValue];
            self.lastPage = [[self objectOrNilForKey:kLWChatPagerLastPage fromDictionary:dict] boolValue];
            self.startRow = [[self objectOrNilForKey:kLWChatPagerStartRow fromDictionary:dict] doubleValue];
            self.totalRows = [[self objectOrNilForKey:kLWChatPagerTotalRows fromDictionary:dict] doubleValue];
            self.currentPage = [[self objectOrNilForKey:kLWChatPagerCurrentPage fromDictionary:dict] doubleValue];
            self.firstPage = [[self objectOrNilForKey:kLWChatPagerFirstPage fromDictionary:dict] boolValue];
            self.totalPages = [[self objectOrNilForKey:kLWChatPagerTotalPages fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endRow] forKey:kLWChatPagerEndRow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageSize] forKey:kLWChatPagerPageSize];
    [mutableDict setValue:[NSNumber numberWithBool:self.getCount] forKey:kLWChatPagerGetCount];
    [mutableDict setValue:[NSNumber numberWithBool:self.lastPage] forKey:kLWChatPagerLastPage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startRow] forKey:kLWChatPagerStartRow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalRows] forKey:kLWChatPagerTotalRows];
    [mutableDict setValue:[NSNumber numberWithDouble:self.currentPage] forKey:kLWChatPagerCurrentPage];
    [mutableDict setValue:[NSNumber numberWithBool:self.firstPage] forKey:kLWChatPagerFirstPage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalPages] forKey:kLWChatPagerTotalPages];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.endRow = [aDecoder decodeDoubleForKey:kLWChatPagerEndRow];
    self.pageSize = [aDecoder decodeDoubleForKey:kLWChatPagerPageSize];
    self.getCount = [aDecoder decodeBoolForKey:kLWChatPagerGetCount];
    self.lastPage = [aDecoder decodeBoolForKey:kLWChatPagerLastPage];
    self.startRow = [aDecoder decodeDoubleForKey:kLWChatPagerStartRow];
    self.totalRows = [aDecoder decodeDoubleForKey:kLWChatPagerTotalRows];
    self.currentPage = [aDecoder decodeDoubleForKey:kLWChatPagerCurrentPage];
    self.firstPage = [aDecoder decodeBoolForKey:kLWChatPagerFirstPage];
    self.totalPages = [aDecoder decodeDoubleForKey:kLWChatPagerTotalPages];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_endRow forKey:kLWChatPagerEndRow];
    [aCoder encodeDouble:_pageSize forKey:kLWChatPagerPageSize];
    [aCoder encodeBool:_getCount forKey:kLWChatPagerGetCount];
    [aCoder encodeBool:_lastPage forKey:kLWChatPagerLastPage];
    [aCoder encodeDouble:_startRow forKey:kLWChatPagerStartRow];
    [aCoder encodeDouble:_totalRows forKey:kLWChatPagerTotalRows];
    [aCoder encodeDouble:_currentPage forKey:kLWChatPagerCurrentPage];
    [aCoder encodeBool:_firstPage forKey:kLWChatPagerFirstPage];
    [aCoder encodeDouble:_totalPages forKey:kLWChatPagerTotalPages];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWChatPager *copy = [[LWChatPager alloc] init];
    
    if (copy) {

        copy.endRow = self.endRow;
        copy.pageSize = self.pageSize;
        copy.getCount = self.getCount;
        copy.lastPage = self.lastPage;
        copy.startRow = self.startRow;
        copy.totalRows = self.totalRows;
        copy.currentPage = self.currentPage;
        copy.firstPage = self.firstPage;
        copy.totalPages = self.totalPages;
    }
    
    return copy;
}


@end
