//
//  LWPickerViewController.m
//  BreatheDoctor
//
//  Created by comv on 15/12/31.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPickerViewController.h"

@interface LWPickerViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *pickerBackView;
@property (nonatomic, copy) NSString *seleIndexString;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHight;
@property (nonatomic, copy) NSString *str1;
@property (nonatomic, copy) NSString *str2;
@end

@implementation LWPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.bottomHight.constant = self.pickerBackView.height;
    _str1 = @"00";
    _str2 = @"00";
    self.seleIndexString = @"00:00";
}
- (void)dismissPickerView{
    _completeDismiss?_completeDismiss():nil;
    [self.view removeFromSuperview];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissPickerView];
}
- (IBAction)close:(id)sender {
    _completeChooseBlock?_completeChooseBlock(@"00:00"):nil;

}
- (IBAction)comper:(id)sender {
    _completeChooseBlock?_completeChooseBlock(self.seleIndexString):nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return component == 0?24:component == 1?1:60;
}
- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        NSString *string = nil;
        if (row < 10) {
            string = [NSString stringWithFormat:@"0%ld时",row];
        }else{
            string = [NSString stringWithFormat:@"%ld时",row];
        }
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        
        [attributedString addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Light" size:kNSPXFONTFLOAT(28)],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"]} range:NSMakeRange(attributedString.length-1, 1)];
        [attributedString addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Light" size:kNSPXFONTFLOAT(80)],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"]} range:NSMakeRange(0, attributedString.length-1)];

        return attributedString;
        
    }else if (component == 1)
    {
        return [[NSMutableAttributedString alloc] initWithString:@":"] ;
    }else{
    
        NSString *string = nil;
        if (row < 10) {
            string = [NSString stringWithFormat:@"0%ld分",row];
        }else{
            string = [NSString stringWithFormat:@"%ld分",row];
        }
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        
        [attributedString addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Light" size:kNSPXFONTFLOAT(28)],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"]} range:NSMakeRange(attributedString.length-1, 1)];
        [attributedString addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Light" size:kNSPXFONTFLOAT(80)],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"]} range:NSMakeRange(0, attributedString.length-1)];

        return attributedString;
    
    }


    
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        if (row < 10) {
            return [NSString stringWithFormat:@"0%ld",row];
        }
        return [NSString stringWithFormat:@"%ld",row];
    }else if (component == 1)
    {
        return @":";
    }
    if (row < 10) {
        return [NSString stringWithFormat:@"0%ld",row];
    }
    return [NSString stringWithFormat:@"%ld",row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        if (row < 10) {
            _str1 = [NSString stringWithFormat:@"0%ld",row];
        }else
        {
            _str1 = [NSString stringWithFormat:@"%ld",row];
        }
    }else if (component == 2)
    {
        if (row < 10) {
            _str2 = [NSString stringWithFormat:@"0%ld",row];
        }else
        {
            _str2 = [NSString stringWithFormat:@"%ld",row];
        }
    }
    
    self.seleIndexString = [NSString stringWithFormat:@"%@:%@",_str1,_str2];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
