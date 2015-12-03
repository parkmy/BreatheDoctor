//
//  SecondMenuView.m
//  LoveBB
//
//  Created by AngelLL on 15/10/22.
//  Copyright © 2015年 Daniel_Li. All rights reserved.
//

#import "LWCustomMenu.h"
#import "LWPatientListModel.h"

#define TopToView 10

#define LeftToView 90
#define CellLineEdgeInsets UIEdgeInsetsMake(0, 10, 0, 10)
#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight        [UIScreen mainScreen].bounds.size.height

@interface LWCustomMenu()
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat rowHeight;
@end
@implementation LWCustomMenu

- (instancetype)initWithDataArr:(NSArray *)dataArr origin:(CGPoint)origin width:(CGFloat)width rowHeight:(CGFloat)rowHeight
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        if (rowHeight <= 0) {
            rowHeight = 35;
        }
        self.backgroundColor = [UIColor clearColor];
        self.origin = origin;
        self.rowHeight = rowHeight;
        self.arrData = [dataArr copy];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, rowHeight * dataArr.count) style:UITableViewStylePlain];
        self.tableView.center = CGPointMake(self.frame.size.width/2, self.tableView.frame.size.height/2+10);
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self addSubview:_tableView];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
        _tableView.layer.cornerRadius = 2;
        _tableView.bounces = NO;
        _tableView.separatorColor = [UIColor colorWithWhite:0.3 alpha:1];
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [self.tableView setSeparatorInset:CellLineEdgeInsets];
            
        }
        
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [self.tableView setLayoutMargins:CellLineEdgeInsets];
            
        }

    }
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWCustomMenu"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"LWCustomMenu"];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;

    LWPatientListModel *model = self.arrData[indexPath.row];
    
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"(%ld)",model.count];
    
//    if (self.arrImgName.count > indexPath.row) {
//        cell.imageView.image = [UIImage imageNamed:self.arrImgName[indexPath.row]];
////        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.3];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(jhCustomMenu:didSelectRowAtIndexPath:)]){
        [self.delegate jhCustomMenu:tableView didSelectRowAtIndexPath:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissWithCompletion:nil];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:CellLineEdgeInsets];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:CellLineEdgeInsets];
        
    }
    
}

- (void)dismissWithCompletion:(void (^)(LWCustomMenu *object))completion
{
//    __weak __typeof(self) weakSelf = self;
//    [UIView animateWithDuration:0.2 animations:^{
//        weakSelf.alpha = 0;
//        weakSelf.tableView.alpha =0;
//    } completion:^(BOOL finished) {
//        [weakSelf removeFromSuperview];
//        if (completion) {
//            completion(weakSelf);
//        }
//        if (weakSelf.dismiss) {
//            weakSelf.dismiss();
//        }
//    }];
    if (completion) {
        completion(self);
    }
    if (self.dismiss) {
        self.dismiss();
    }
    [self removeFromSuperview];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (![touch.view isEqual:self.tableView]) {
        [self dismissWithCompletion:nil];
    }
}

- (void)drawRect:(CGRect)rect

{
    
    
//    [colors[serie] setFill];
    
    //拿到当前视图准备好的画板
    
    CGContextRef
    context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    
    CGContextBeginPath(context);//标记
    
    CGContextSetRGBStrokeColor(context, 38/255.0, 38/255.0, 38/255.0, 1);
    
    CGContextMoveToPoint(context,
                         self.frame.size.width/2-10, 12);//设置起点
    
    CGContextAddLineToPoint(context,
                            self.frame.size.width/2, 2);
    
    CGContextAddLineToPoint(context,
                            self.frame.size.width/2+10, 12);
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [self.tableView.backgroundColor setFill]; //设置填充色
    
//    [self.tableView.backgroundColor setStroke]; //设置边框颜色
    
    CGContextDrawPath(context,
                      kCGPathFillStroke);//绘制路径path
}

@end
