//
//  commentsViewController.m
//  MeetMeUp
//
//  Created by Chris Snyder on 8/4/14.
//  Copyright (c) 2014 Chris Snyder. All rights reserved.
//

#import "commentsViewController.h"
#import "eventDetailViewController.h"

@interface commentsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *commentTableView;
@property NSArray *commentsArray;
@property NSDictionary *commentsDictionary;

@end

@implementation commentsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=640433f6272a63b6c12c19615e19"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         self.commentsDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];

         self.commentsArray = [self.commentsDictionary objectForKey:@"results"];

         [self.commentTableView reloadData];
         NSLog(@"%@", self.commentsArray);
         
     }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *comments = [self.commentsArray objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    cell.textLabel.text =comments [@"comment"];
    cell.detailTextLabel.text = comments [@"member_id"];
    return  cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.commentsArray.count;
}

- (IBAction)onDismissTap:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
