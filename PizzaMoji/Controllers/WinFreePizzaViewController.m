//
//  WinFreePizzaViewController.m
//  PizzaMoji
//
//  Created by Amar Bhatia on 1/20/19.
//  Copyright © 2019 Amar-Bhatia. All rights reserved.
//

#import "WinFreePizzaViewController.h"

@interface WinFreePizzaViewController ()

@property (weak, nonatomic) IBOutlet UIButton *getAppButton;

@end

@implementation WinFreePizzaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"FREE PIZZA";
    self.getAppButton.layer.cornerRadius = 5;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< Back" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];

}


- (IBAction)onGetAppButtonPressed:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://itunes.apple.com/us/app/box-score-guest-host/id696243799?mt=8"]];
}

- (void)dismissView {
    [[self navigationController] popViewControllerAnimated:YES];
}



@end
