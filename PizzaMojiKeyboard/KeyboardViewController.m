//
//  KeyboardViewController.m
//  PizzaMojiKeyboard
//
//  Created by Amar Bhatia on 1/20/19.
//  Copyright © 2019 Amar-Bhatia. All rights reserved.
//

#import "KeyboardViewController.h"

@interface KeyboardViewController ()


@property UICollectionView *collectionView;
@property UICollectionView *letterKeyboardCollectionView;
@property NSArray *imageNames;


@property (weak, nonatomic) IBOutlet UIButton *globeKey;

// Keyboard Rows
@property (weak, nonatomic) IBOutlet UIView *numbersRow1View;
@property (weak, nonatomic) IBOutlet UIView *numbersRow2View;
@property (weak, nonatomic) IBOutlet UIView *numbersSymbolsRow3View;

// Keys
@property (weak, nonatomic) IBOutlet UIView *symbolsRow1View;
@property (weak, nonatomic) IBOutlet UIView *symbolsRow2View;

@property (weak, nonatomic) IBOutlet UIButton *returnButton;
@property (weak, nonatomic) IBOutlet UIButton *spaceButton;
@property (weak, nonatomic) IBOutlet UIButton *shiftButton;

@property (weak, nonatomic) IBOutlet UIButton *oneTwoThreeButton;
@property (weak, nonatomic) IBOutlet UIButton *switchModeRow4Button;
@property (weak, nonatomic) IBOutlet UIButton *switchModeRow3Button;

@property (weak, nonatomic) IBOutlet UIButton *letterButtonsArray;



@end

@implementation KeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSURL *localDirectory = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask][0];
    NSLog(@"KEYBOARD ---> %@", localDirectory.absoluteString);
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    

}


@end
