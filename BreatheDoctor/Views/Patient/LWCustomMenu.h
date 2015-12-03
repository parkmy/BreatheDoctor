//
//  SecondMenuView.h
//  LoveBB
//
//  Created by AngelLL on 15/10/22.
//  Copyright © 2015年 Daniel_Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LWCustomMenuDelegate <NSObject>
@optional
- (void)jhCustomMenu:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

typedef void(^Dismiss)(void);
@interface LWCustomMenu : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) id<LWCustomMenuDelegate> delegate;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) NSArray *arrImgName;
@property (nonatomic, copy) Dismiss dismiss;

- (instancetype)initWithDataArr:(NSArray *)dataArr origin:(CGPoint)origin width:(CGFloat)width rowHeight:(CGFloat)rowHeight;

- (void)dismissWithCompletion:(void (^)(LWCustomMenu *object))completion;
@end
