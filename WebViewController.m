//
//  WebViewController.m
//  MeetMeUp
//
//  Created by Nicolas Semenas on 05/08/14.
//  Copyright (c) 2014 Nicolas Semenas. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;

@end



@implementation WebViewController

- (IBAction)onBackButtonPressed:(id)sender {
    
    [self.myWebView goBack];
    
}

- (IBAction)onForwardButtonPressed:(id)sender {
    
    [self.myWebView goForward];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myWebView.delegate = self;
    
    NSString * webPage = [self.meet objectForKey:@"event_url"];
    
    NSURL *url = [[NSURL alloc] initWithString:webPage];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];

    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"onBack"])
    {
        // Get reference to the destination view controller
        WebViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.meet = self.meet;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.loadingLabel.hidden = YES;
}



@end
