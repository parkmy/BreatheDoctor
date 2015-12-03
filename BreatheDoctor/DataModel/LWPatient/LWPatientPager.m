//
//  LWPatientPager.m
//
//  Created by   on 15/11/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LWPatientPager.h"


NSString *const kLWPatientPagerEndRow = @"endRow";
NSString *const kLWPatientPagerPageSize = @"pageSize";
NSString *const kLWPatientPagerGetCount = @"getCount";
NSString *const kLWPatientPagerLastPage = @"lastPage";
NSString *const kLWPatientPagerStartRow = @"startRow";
NSString *const kLWPatientPagerCurrentPage = @"currentPage";
NSString *const kLWPatientPagerTotalPages = @"totalPages";
NSString *const kLWPatientPagerFirstPage = @"firstPage";
NSString *const kLWPatientPagerTotalRows = @"totalRows";


@interface LWPatientPager ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LWPatientPager

@synthesize endRow = _endRow;
@synthesize pageSize = _pageSize;
@synthesize getCount = _getCount;
@synthesize lastPage = _lastPage;
@synthesize startRow = _startRow;
@synthesize currentPage = _currentPage;
@synthesize totalPages = _totalPages;
@synthesize firstPage = _firstPage;
@synthesize totalRows = _totalRows;


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
            self.endRow = [[self objectOrNilForKey:kLWPatientPagerEndRow fromDictionary:dict] doubleValue];
            self.pageSize = [[self objectOrNilForKey:kLWPatientPagerPageSize fromDictionary:dict] doubleValue];
            self.getCount = [[self objectOrNilForKey:kLWPatientPagerGetCount fromDictionary:dict] boolValue];
            self.lastPage = [[self objectOrNilForKey:kLWPatientPagerLastPage fromDictionary:dict] boolValue];
            self.startRow = [[self objectOrNilForKey:kLWPatientPagerStartRow fromDictionary:dict] doubleValue];
            self.currentPage = [[self objectOrNilForKey:kLWPatientPagerCurrentPage fromDictionary:dict] doubleValue];
            self.totalPages = [[self objectOrNilForKey:kLWPatientPagerTotalPages fromDictionary:dict] doubleValue];
            self.firstPage = [[self objectOrNilForKey:kLWPatientPagerFirstPage fromDictionary:dict] boolValue];
            self.totalRows = [[self objectOrNilForKey:kLWPatientPagerTotalRows fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endRow] forKey:kLWPatientPagerEndRow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageSize] forKey:kLWPatientPagerPageSize];
    [mutableDict setValue:[NSNumber numberWithBool:self.getCount] forKey:kLWPatientPagerGetCount];
    [mutableDict setValue:[NSNumber numberWithBool:self.lastPage] forKey:kLWPatientPagerLastPage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startRow] forKey:kLWPatientPagerStartRow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.currentPage] forKey:kLWPatientPagerCurrentPage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalPages] forKey:kLWPatientPagerTotalPages];
    [mutableDict setValue:[NSNumber numberWithBool:self.firstPage] forKey:kLWPatientPagerFirstPage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalRows] forKey:kLWPatientPagerTotalRows];

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

    self.endRow = [aDecoder decodeDoubleForKey:kLWPatientPagerEndRow];
    self.pageSize = [aDecoder decodeDoubleForKey:kLWPatientPagerPageSize];
    self.getCount = [aDecoder decodeBoolForKey:kLWPatientPagerGetCount];
    self.lastPage = [aDecoder decodeBoolForKey:kLWPatientPagerLastPage];
    self.startRow = [aDecoder decodeDoubleForKey:kLWPatientPagerStartRow];
    self.currentPage = [aDecoder decodeDoubleForKey:kLWPatientPagerCurrentPage];
    self.totalPages = [aDecoder decodeDoubleForKey:kLWPatientPagerTotalPages];
    self.firstPage = [aDecoder decodeBoolForKey:kLWPatientPagerFirstPage];
    self.totalRows = [aDecoder decodeDoubleForKey:kLWPatientPagerTotalRows];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_endRow forKey:kLWPatientPagerEndRow];
    [aCoder encodeDouble:_pageSize forKey:kLWPatientPagerPageSize];
    [aCoder encodeBool:_getCount forKey:kLWPatientPagerGetCount];
    [aCoder encodeBool:_lastPage forKey:kLWPatientPagerLastPage];
    [aCoder encodeDouble:_startRow forKey:kLWPatientPagerStartRow];
    [aCoder encodeDouble:_currentPage forKey:kLWPatientPagerCurrentPage];
    [aCoder encodeDouble:_totalPages forKey:kLWPatientPagerTotalPages];
    [aCoder encodeBool:_firstPage forKey:kLWPatientPagerFirstPage];
    [aCoder encodeDouble:_totalRows forKey:kLWPatientPagerTotalRows];
}

- (id)copyWithZone:(NSZone *)zone
{
    LWPatientPager *copy = [[LWPatientPager alloc] init];
    
    if (copy) {

        copy.endRow = self.endRow;
        copy.pageSize = self.pageSize;
        copy.getCount = self.getCount;
        copy.lastPage = self.lastPage;
        copy.startRow = self.startRow;
        copy.currentPage = self.currentPage;
        copy.totalPages = self.totalPages;
        copy.firstPage = self.firstPage;
        copy.totalRows = self.totalRows;
    }
    
    return copy;
}


@end
