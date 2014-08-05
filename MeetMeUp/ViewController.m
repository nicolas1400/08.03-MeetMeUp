//
//  ViewController.m
//  MeetMeUp
//
//  Created by Nicolas Semenas on 04/08/14.
//  Copyright (c) 2014 Nicolas Semenas. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSDictionary * meetups;

@end

@implementation ViewController

- (IBAction)onBack:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=7712287c1c136a1b7f6b7949238187f"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.meetups = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [self.tableView reloadData];
    }];
}



-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"onViewDetails"])
    {
        // Get reference to the destination view controller
        DetailViewController *vc = [segue destinationViewController];
        


        
        // Pass any objects to the view controller here, like...
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        NSArray * results = [self.meetups objectForKey:@"results"];
        NSDictionary * thisMeet = [results objectAtIndex:path.row];

        
        
        vc.meet = thisMeet;
    }
}

#pragma mark - TableView Delegates

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     NSArray * results = [self.meetups objectForKey:@"results"];
     NSDictionary * thisMeet = [results objectAtIndex:indexPath.row];
     NSDictionary * thisVenue = [thisMeet objectForKey:@"venue"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
 
    cell.textLabel.text = [thisMeet objectForKey:@"name"];
    cell.detailTextLabel.text =  [thisVenue objectForKey:@"address_1"];
    
//    NSURL *url = [NSURL URLWithString:[superhero objectForKey:@"avatar_url"]];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    cell.imageView.image = [UIImage imageWithData:data];
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray * results = [self.meetups objectForKey:@"results"];
    return results.count;
}


@end
