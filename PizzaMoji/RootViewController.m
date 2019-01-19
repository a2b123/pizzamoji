//
//  RootViewController.m
//  PizzaMoji
//
//  Created by Amar Bhatia on 1/19/19.
//  Copyright © 2019 Amar-Bhatia. All rights reserved.
//

#import "RootViewController.h"


@interface RootViewController ()
{
    CGFloat cellHeight;
    NSMutableArray *emojis;
    UIImage *selectedImage; 
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *localDictionary = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask][0];
    NSLog(@"APP ---> %@", localDictionary.absoluteString);
}



@end
