//
//  LWWEBViewController.m
//  BreatheDoctor
//
//  Created by comv on 15/12/8.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWWEBViewController.h"

@interface LWWEBViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@end

@implementation LWWEBViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.titleString) {
        [super addNavBar:self.titleString];
    }else{
        [super addNavBar:@"更多"];
    }
    [super addBackButton:@"nav_btnBack.png"];

}
- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - init

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
    }
    return _webView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.webView.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.view,0).bottomSpaceToView(self.view,0).rightSpaceToView(self.view,0);
    
    [self.view addSubview:self.webView];
    NSURL *url =[NSURL URLWithString:self.url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];

    [request setTimeoutInterval:10];
    [self.webView loadRequest:request];
    
    [LWProgressHUD displayProgressHUD:self.view displayText:@"请稍后..."];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [LWProgressHUD closeProgressHUD:webView];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [LWProgressHUD closeProgressHUD:webView];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
