//
//  LWMainPager.m
//
//  Created by   on 15/11/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWMainPager.h"


NSString *const kLWMainPagerEndRow = @"endRow";
NSString *const kLWMainPagerPageSize = @"pageSize";
NSString *const kLWMainPagerGetCount = @"getCount";
NSString *const kLWMainPagerLastPage = @"lastPage";
NSString *const kLWMainPagerStartRow = @"startRow";
NSString *const kLWMainPagerTotalRows = @"totalRows";
NSString *const kLWMainPagerCurrentPage = @"currentPage";
NSString *const kLWMainPagerFirstPage = @"firstPage";
NSString *const kLWMainPagerTotalPages = @"totalPages";


@interface LWMainPager ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWMainPager

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
            self.endRow = [[self objectOrNilForKey:kLWMainPagerEndRow fromDictionary:dict] doubleValue];
            self.pageSize = [[self objectOrNilForKey:kLWMainPagerPageSize fromDictionary:dict] doubleValue];
            self.getCount = [[self objectOrNilForKey:kLWMainPagerGetCount fromDictionary:dict] boolValue];
            self.lastPage = [[self objectOrNilForKey:kLWMainPagerLastPage fromDictionary:dict] boolValue];
            self.startRow = [[self objectOrNilForKey:kLWMainPagerStartRow fromDictionary:dict] doubleValue];
            self.totalRows = [[self objectOrNilForKey:kLWMainPagerTotalRows fromDictionary:dict] doubleValue];
            self.currentPage = [[self objectOrNilForKey:kLWMainPagerCurrentPage fromDictionary:dict] doubleValue];
            self.firstPage = [[self objectOrNilForKey:kLWMainPagerFirstPage fromDictionary:dict] boolValue];
            self.totalPages = [[self objectOrNilForKey:kLWMainPagerTotalPages fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endRow] forKey:kLWMainPagerEndRow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageSize] forKey:kLWMainPagerPageSize];
    [mutableDict setValue:[NSNumber numberWithBool:self.getCount] forKey:kLWMainPagerGetCount];
    [mutableDict setValue:[NSNumber numberWithBool:self.lastPage] forKey:kLWMainPagerLastPage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startRow] forKey:kLWMainPagerStartRow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalRows] forKey:kLWMainPagerTotalRows];
    [mutableDict setValue:[NSNumber numberWithDouble:self.currentPage] forKey:kLWMainPagerCurrentPage];
    [mutableDict setValue:[NSNumber numberWithBool:self.firstPage] forKey:kLWMainPagerFirstPage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalPages] forKey:kLWMainPagerTotalPages];

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

    self.endRow = [aDecoder decodeDoubleForKey:kLWMainPagerEndRow];
    self.pageSize = [aDecoder decodeDoubleForKey:kLWMainPagerPageSize];
    self.getCount = [aDecoder decodeBoolForKey:kLWMainPagerGetCount];
    self.lastPage = [aDecoder decodeBoolForKey:kLWMainPagerLastPage];
    self.startRow = [aDecoder decodeDoubleForKey:kLWMainPagerStartRow];
    self.totalRows = [aDecoder decodeDoubleForKey:kLWMainPagerTotalRows];
    self.currentPage = [aDecoder decodeDoubleForKey:kLWMainPagerCurrentPage];
    self.firstPage = [aDecoder decodeBoolForKey:kLWMainPagerFirstPage];
    self.totalPages = [aDecoder decodeDoubleForKey:kLWMainPagerTotalPages];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_endRow forKey:kLWMainPagerEndRow];
    [aCoder encodeDouble:_pageSize forKey:kLWMainPagerPageSize];
    [aCoder encodeBool:_getCount forKey:kLWMainPagerGetCount];
    [aCoder encodeBool:_lastPage forKey:kLWMainPagerLastPage];
    [aCoder encodeDouble:_startRow forKey:kLWMainPagerStartRow];
    [aCoder encodeDouble:_totalRows forKey:kLWMainPagerTotalRows];
    [aCoder encodeDouble:_currentPage forKey:kLWMainPagerCurrentPage];
    [aCoder encodeBool:_firstPage forKey:kLWMainPagerFirstPage];
    [aCoder encodeDouble:_totalPages forKey:kLWMainPagerTotalPages];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWMainPager *copy = [[LWMainPager alloc] init];
    
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
