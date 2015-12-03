//
//  LWChatPager.h
//
//  Created by   on 15/11/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LWChatPager : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double endRow;
@property (nonatomic, assign) double pageSize;
@property (nonatomic, assign) BOOL getCount;
@property (nonatomic, assign) BOOL lastPage;
@property (nonatomic, assign) double startRow;
@property (nonatomic, assign) double totalRows;
@property (nonatomic, assign) double currentPage;
@property (nonatomic, assign) BOOL firstPage;
@property (nonatomic, assign) double totalPages;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
