//
//  webViewController.m
//  MeetMeUp
//
//  Created by Chris Snyder on 8/4/14.
//  Copyright (c) 2014 Chris Snyder. All rights reserved.
//

#import "webViewController.h"

@interface webViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@end

@implementation webViewController

- (IBAction)onBackButtonPressed:(id)sender
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];

    }
}

- (IBAction)onForwardButtonPressed:(id)sender {
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.webView.delegate = self;
    self.backButton.enabled = NO;
    self.backButton.alpha = .5;

    self.forwardButton.enabled = NO;
    self.forwardButton.alpha = .5;

    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [self.webView loadRequest:request];
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.loadingIndicator startAnimating];
    self.loadingIndicator.backgroundColor = [UIColor greenColor];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([self.webView canGoBack]) {
        self.backButton.enabled = YES;
        self.backButton.alpha = 1;
    } else {
        self.backButton.enabled = NO;
        self.backButton.alpha = .5;
    }

    if ([self.webView canGoForward]) {
        self.forwardButton.enabled = YES;
        self.forwardButton.alpha = 1;
    } else {
        self.forwardButton.enabled = NO;
        self.forwardButton.alpha = .5;
    }
    [self.loadingIndicator stopAnimating];
    self.loadingIndicator.hidden = YES;
}

@end
