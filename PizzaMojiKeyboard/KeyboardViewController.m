//
//  KeyboardViewController.m
//  PizzaMojiKeyboard
//
//  Created by Amar Bhatia on 1/20/19.
//  Copyright © 2019 Amar-Bhatia. All rights reserved.
//

#import "KeyboardViewController.h"
#import "CustomKeyboardViewController.h"
#import "KeyboardCollectionViewCell.h"

@interface KeyboardViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIButton *nextKeyboardButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (strong, nonatomic) CustomKeyboardViewController *keyboard;
@property UICollectionView *collectionView;
@property UICollectionView *letterKeyboardCollectionView;
@property NSArray *imageNames;



// Keyboard Rows
@property (weak, nonatomic) IBOutlet UIView *numbersRow1View;
@property (weak, nonatomic) IBOutlet UIView *numbersRow2View;
@property (weak, nonatomic) IBOutlet UIView *numbersSymbolsRow3View;
@property (weak, nonatomic) IBOutlet UIView *symbolsRow1View;
@property (weak, nonatomic) IBOutlet UIView *symbolsRow2View;


// Keys
@property (weak, nonatomic) IBOutlet UIButton *letterButtonsArray;

@property (weak, nonatomic) IBOutlet UIButton *switchModeRow3Button;
@property (weak, nonatomic) IBOutlet UIButton *switchModeRow4Button;
@property (weak, nonatomic) IBOutlet UIButton *shiftButton;
@property (weak, nonatomic) IBOutlet UIButton *spaceButton;
@property (weak, nonatomic) IBOutlet UIButton *globeKey;
@property (weak, nonatomic) IBOutlet UIButton *oneTwoThreeButton;
@property (weak, nonatomic) IBOutlet UIButton *returnButton;


@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSURL *localDirectory = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask][0];
    NSLog(@"KEYBOARD ---> %@", localDirectory.absoluteString);
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.imageNames = [NSArray arrayWithObjects:
                       @"cheese",
                       @"pepperoni",
                       @"sausage",
                       @"meatlovers",
                       @"veggie",
                       @"deepdish",
                       @"breakfast",
                       @"lunch",
                       @"dinner",
                       @"sunday",
                       @"monday",
                       @"tuesday",
                       @"wednesday",
                       @"thursday",
                       @"friday",
                       @"saturday",
                       @"cheatday",
                       @"mopizza",
                       @"pizzapie",
                       @"sliceaday",
                       @"pizzatown",
                       @"pizzaordeath",
                       @"pizzaparty",
                       @"toppingbacon",
                       @"toppingblackolives",
                       @"toppingmushrooms",
                       @"toppingonions",
                       @"toppingpepperoni",
                       @"toppingpeppers",
                       @"toppingpineapple",
                       @"toppingsausage",
                       @"toppingshrimp",
                       @"toppingbasil",
                       @"toppingtomato",
                       nil];
    
    
    // Perform custom UI setup here
    [self.keyboard.globeKey addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    //    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(void)onKeyboardHide:(NSNotification *)notification {
    NSLog(@"---> KEYBOARD HIDE NOTIFICATION");
}

-(void)setupGlobalButton {
    UIImage *globalImage = [UIImage imageNamed:@"globalbutton"];
    CGRect globalFrame = CGRectMake(0, 0, 88, 44);
    
    self.nextKeyboardButton = [[UIButton alloc] initWithFrame:globalFrame];
    [self.nextKeyboardButton setBackgroundImage:globalImage forState:UIControlStateNormal];
    
    [self.nextKeyboardButton sizeToFit];
    self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false;
    
    [self.nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.nextKeyboardButton];
    
    [self.nextKeyboardButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.nextKeyboardButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

-(void)setupDeleteButton {
    UIImage *deleteImage = [UIImage imageNamed:@"deletebutton"];
    CGRect deleteFrame = CGRectMake(0, 0, 88, 44);
    
    self.deleteButton = [[UIButton alloc] initWithFrame:deleteFrame];
    [self.deleteButton setBackgroundImage:deleteImage forState:UIControlStateNormal];
    
    [self.deleteButton sizeToFit];
    self.deleteButton.translatesAutoresizingMaskIntoConstraints = false;
    
    [self.deleteButton addTarget:self action:@selector(keyboardViewDidInputDelete) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.deleteButton];
    
    [self.deleteButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.deleteButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

#pragma Change Keyboard

// Change Next Keyboard

-(void)addGestureToKeyboard {
    [self.keyboard.globeKey addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
}

-(BOOL)isOpenAccessGranted {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSLog(@"pasteboard: %@", pasteboard);
    if(pasteboard) {
        NSLog(@"Full Access On");
        return YES;
    } else {
        NSLog(@"Full Access: Off");
        return NO;
    }
}

-(BOOL)isCustomKeyboardEnabled {
    NSString *bundleID = @"AmarBhatia.PizzaMoji";
    NSArray *keyboards = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] objectForKey:@"Keyboard"];
    for (NSString *keyboard in keyboards) {
        if ([keyboard isEqualToString:bundleID])
            return YES;
    }
    
    return NO;
}



@end
