//
//  ViewController.m
//  MeetMeUp
//
//  Created by Chris Snyder on 8/4/14.
//  Copyright (c) 2014 Chris Snyder. All rights reserved.
//

#import "ViewController.h"
#import "eventDetailViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property NSArray *meetups;
@property NSDictionary *eventsDictionary;
@property NSArray *searchResults;

@property (weak, nonatomic) IBOutlet UITableView *meetUpTableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=640433f6272a63b6c12c19615e19"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        self.eventsDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];

        self.meetups = [self.eventsDictionary objectForKey:@"results"];
        [self.meetUpTableView reloadData];
        NSLog(@"%@", self.meetups);
        
    }];

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *event = [self.meetups objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text =event [@"name"];
    cell.detailTextLabel.text = event [@"address_1"];
    return  cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.meetups.count;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *selectedIndexPath = self.meetUpTableView.indexPathForSelectedRow;
    eventDetailViewController *destinationViewController = segue.destinationViewController;
    NSDictionary *dictionary = [self.meetups objectAtIndex:selectedIndexPath.row];
    destinationViewController.dictionaryFromSourceView = dictionary;
}



@end
