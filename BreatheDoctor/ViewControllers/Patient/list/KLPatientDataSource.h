//
//  KLPatientDataSource.h
//  BreatheDoctor
//
//  Created by comv on 16/4/21.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWPatientListCtr.h"

@class KLPatientListModel;

@interface KLPatientDataSource : NSObject<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *patientDics;
@property (nonatomic, strong) NSArray        *keys;
@property (nonatomic, strong) NSMutableArray *searchArray;
@property (nonatomic, assign) BOOL          isSearch;

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) UISearchBar    *searchBar;

@property (nonatomic, assign) LISTTYPE       listType;

@property (nonatomic, copy) void(^didSelectTableCellBlock)(NSIndexPath *index ,KLPatientListModel *obj);

@end
