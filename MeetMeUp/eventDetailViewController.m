//
//  eventDetailViewController.m
//  MeetMeUp
//
//  Created by Chris Snyder on 8/4/14.
//  Copyright (c) 2014 Chris Snyder. All rights reserved.
//

#import "eventDetailViewController.h"
#import "webViewController.h"

@interface eventDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *rsvpLabel;

@property (weak, nonatomic) IBOutlet UILabel *whoHostingLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation eventDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.dictionaryFromSourceView[@"name"];
    self.rsvpLabel.text = [NSString stringWithFormat:@"%@",self.dictionaryFromSourceView[@"yes_rsvp_count"]];
    self.whoHostingLabel.text = self.dictionaryFromSourceView[@"name"];
    self.descriptionLabel.text = self.dictionaryFromSourceView[@"description"];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *nav = segue.destinationViewController;
    webViewController *vc = (webViewController *) nav.topViewController;
    vc.urlString = self.dictionaryFromSourceView[@"event_url"];
    
    
}

@end
