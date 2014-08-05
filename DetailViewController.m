//
//  DetailViewController.m
//  MeetMeUp
//
//  Created by Nicolas Semenas on 04/08/14.
//  Copyright (c) 2014 Nicolas Semenas. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *RSVPLabel;
@property (weak, nonatomic) IBOutlet UITextField *hostingLabel;
@property (weak, nonatomic) IBOutlet UIWebView *descriptionBrowser;

@end

@implementation DetailViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"onViewWebPage"])
    {
        // Get reference to the destination view controller
        WebViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.meet = self.meet;
    }
}




- (void)viewDidLoad {
    
    self.nameLabel.text = [self.meet objectForKey:@"name"];
    self.RSVPLabel.text = [NSString stringWithFormat:@"%@", [self.meet objectForKey:@"yes_rsvp_count"]];
    NSDictionary *hosting = [self.meet objectForKey:@"group"];
    self.hostingLabel.text = [hosting objectForKey:@"name"];

    NSString * description = [self.meet objectForKey:@"description"];
    [self.descriptionBrowser loadHTMLString:description baseURL:nil];
 
}



@end
