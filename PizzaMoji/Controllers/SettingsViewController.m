//
//  SettingsViewController.m
//  PizzaMoji
//
//  Created by Amar Bhatia on 1/19/19.
//  Copyright © 2019 Amar-Bhatia. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< Back" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];

}


-(void)viewDidAppear:(BOOL)animated {
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tablecloth"]]];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
}

- (void)dismissView {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)onRateAppButtonPressed:(UIButton*)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.apple.com"]];
}

- (IBAction)onInstallKeyboardButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"SettingsToTutorialSegue" sender:self];
}


- (IBAction)onShareWithFriendsButtonPressed:(UIButton *)sender {
    [self shareContent];
}


- (IBAction)onFollowUsButtonPressed:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.instagram.com/boxscoregames/"]];
}

- (IBAction)onWinFreePizzaButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"WinFreePizzaSegue" sender:self];

}

- (IBAction)onPrivacyPolicyButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"PrivacyPolicySegue" sender:self];

}

- (IBAction)onContactUsButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"ContactUsSegue" sender:self];

}


// Allows separator lines to extend full width of view
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)shareContent{
    
    NSString *message = @"Pizza. Emojis. Enough said.\nLearn more at boxscoregames.com!\n\n#PizzaEmojiApp";
    UIImage *image = [UIImage imageNamed:@"sliceaday"];
    NSArray *shareItems = @[message, image];
    UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
    
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)cell{
    
    
}

@end
