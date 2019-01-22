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

@interface KeyboardViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UIActionSheetDelegate>

@property (nonatomic, strong) UIButton *nextKeyboardButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (strong, nonatomic) CustomKeyboardViewController *keyboard;
@property UICollectionView *collectionView;
@property UICollectionView *letterKeyboardCollectionView;
@property NSArray *imageNames;
@property int shiftStatus; //0 = off, 1 = on, 2 = caps lock



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

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect collectionFrame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 44);
    
    self.collectionView.frame = collectionFrame;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageNames.count;
}

-(KeyboardCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    KeyboardCollectionViewCell *keyboardCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
    if(keyboardCell.emojiImageView == nil) {
        keyboardCell.emojiImageView = [[UIImageView alloc] initWithFrame:keyboardCell.contentView.frame];
        keyboardCell.emojiImageView.contentMode = UIViewContentModeScaleAspectFit;
        [keyboardCell.contentView addSubview:keyboardCell.emojiImageView];
    }
    
    keyboardCell.targetName = self.imageNames[indexPath.row];
    keyboardCell.imageName = [NSString stringWithFormat:@"%@Keyboard", keyboardCell.targetName];
    keyboardCell.emojiImageView.image = [UIImage imageNamed:keyboardCell.imageName];
    
    return keyboardCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSLog(@"SELECTED");
    
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    
    //Uncomment following 3 lines to allow sharing at small size
    //    NSString *targetName = self.imageNames[indexPath.row];
    //    NSString *imageName = [NSString stringWithFormat:@"%@Keyboard", targetName];
    //    pb.image = [UIImage imageNamed:imageName];
    
    //Comment out following line to disallow sharing full-size images
    pb.image = [UIImage imageNamed:self.imageNames[indexPath.row]];
    pb.persistent = NO;
    
    UILabel *notify = [[UILabel alloc] initWithFrame:self.view.frame];
    //    notify.hidden = YES;
    notify.alpha = 0.0;
    notify.backgroundColor = [UIColor blackColor];
    
    notify.text = @"Copied to Clipboard!";
    notify.textColor = [UIColor whiteColor];
    notify.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:notify];
    [UIView animateWithDuration:0.3 animations:^{
        notify.alpha = 0.75;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            notify.alpha = 0.0;
        } completion:^(BOOL finished) {
            [notify removeFromSuperview];
        }];
    }];
}

-(void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}
                       
-(void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    
}

#pragma mark -


- (void)keyboardViewShouldAdvanceToNextInputMode:(id) sender {
    [self advanceToNextInputMode];

}

- (void) initializeKeyboard {
    
    //start with shift on
    _shiftStatus = 1;
    
    //initialize space key double tap
    UITapGestureRecognizer *spaceDoubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(spaceKeyDoubleTapped:)];
    
    spaceDoubleTap.numberOfTapsRequired = 2;
    [spaceDoubleTap setDelaysTouchesEnded:NO];
    
    [self.spaceButton addGestureRecognizer:spaceDoubleTap];
    
    //initialize shift key double and triple tap
    UITapGestureRecognizer *shiftDoubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shiftKeyDoubleTapped:)];
    UITapGestureRecognizer *shiftTripleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shiftKeyPressed:)];
    
    shiftDoubleTap.numberOfTapsRequired = 2;
    shiftTripleTap.numberOfTapsRequired = 3;
    
    [shiftDoubleTap setDelaysTouchesEnded:NO];
    [shiftTripleTap setDelaysTouchesEnded:NO];
    
    [self.shiftButton addGestureRecognizer:shiftDoubleTap];
    [self.shiftButton addGestureRecognizer:shiftTripleTap];
    
}

#pragma mark - key methods

- (IBAction)globeKeyPressed:(UIButton *)sender {
    //required functionality, switches to user's next keyboard
    [self advanceToNextInputMode];

}

- (IBAction)backspaceKeyPressed:(UIButton *)sender {
    [self.textDocumentProxy deleteBackward];

}

- (IBAction)returnKeyPressed:(UIButton *)sender {
    [self.textDocumentProxy insertText:@"\n"];

}

- (IBAction)shiftKeyboard:(UIButton *)sender {
    //if shift is on or in caps lock mode, turn it off. Otherwise, turn it on
    _shiftStatus = _shiftStatus > 0 ? 0 : 1;
    
    [self shiftKeys];

}

- (IBAction)shiftKeyPressed:(UIButton *)sender {
    //if shift is on or in caps lock mode, turn it off. Otherwise, turn it on
    _shiftStatus = _shiftStatus > 0 ? 0 : 1;
    
    [self shiftKeys];

}


-(void) shiftKeyDoubleTapped: (UIButton*) sender {
    
    //set shift to caps lock and set all letters to uppercase
    _shiftStatus = 2;
    
    [self shiftKeys];
    
}

- (void) shiftKeys {
    
    //if shift is off, set letters to lowercase, otherwise set them to uppercase
    if (_shiftStatus == 0) {
        for (UIButton* letterButton in self.letterButtonsArray) {
            [letterButton setTitle:letterButton.titleLabel.text.lowercaseString forState:UIControlStateNormal];
        }
    } else {
        for (UIButton* letterButton in self.letterButtonsArray) {
            [letterButton setTitle:letterButton.titleLabel.text.uppercaseString forState:UIControlStateNormal];
        }
    }
    
    //adjust the shift button images to match shift mode
    NSString *shiftButtonImageName = [NSString stringWithFormat:@"shift_%i.png", _shiftStatus];
    [self.shiftButton setImage:[UIImage imageNamed:shiftButtonImageName] forState:UIControlStateNormal];
    
    
    NSString *shiftButtonHLImageName = [NSString stringWithFormat:@"shift_%iHL.png", _shiftStatus];
    [self.shiftButton setImage:[UIImage imageNamed:shiftButtonHLImageName] forState:UIControlStateHighlighted];
    
}


- (IBAction)spaceKeyPressed:(UIButton *)sender {
    [self.textDocumentProxy insertText:@" "];
}

- (IBAction)switchKeyboardMode:(UIButton *)sender {
    self.numbersRow1View.hidden = YES;
    self.numbersRow2View.hidden = YES;
    self.symbolsRow1View.hidden = YES;
    self.symbolsRow2View.hidden = YES;
    self.numbersSymbolsRow3View.hidden = YES;
    
    //switches keyboard to ABC, 123, or #+= mode
    //case 1 = 123 mode, case 2 = #+= mode
    //default case = ABC mode
    
    switch (sender.tag) {
            
        case 1: {
            self.numbersRow1View.hidden = NO;
            self.numbersRow2View.hidden = NO;
            self.numbersSymbolsRow3View.hidden = NO;
            
            //change row 3 switch button image to #+= and row 4 switch button to ABC
            [self.switchModeRow3Button setImage:[UIImage imageNamed:@"symbols.png"] forState:UIControlStateNormal];
            [self.switchModeRow3Button setImage:[UIImage imageNamed:@"symbolsHL.png"] forState:UIControlStateHighlighted];
            self.switchModeRow3Button.tag = 2;
            [self.switchModeRow4Button setImage:[UIImage imageNamed:@"abc.png"] forState:UIControlStateNormal];
            [self.switchModeRow4Button setImage:[UIImage imageNamed:@"abcHL.png"] forState:UIControlStateHighlighted];
            self.switchModeRow4Button.tag = 0;
        }
            break;
            
        case 2: {
            self.symbolsRow1View.hidden = NO;
            self.symbolsRow2View.hidden = NO;
            self.numbersSymbolsRow3View.hidden = NO;
            
            //change row 3 switch button image to 123
            [self.switchModeRow3Button setImage:[UIImage imageNamed:@"numbers.png"] forState:UIControlStateNormal];
            [self.switchModeRow3Button setImage:[UIImage imageNamed:@"numbersHL.png"] forState:UIControlStateHighlighted];
            self.switchModeRow3Button.tag = 1;
        }
            break;
            
        default:
            //change the row 4 switch button image to 123
            [self.switchModeRow4Button setImage:[UIImage imageNamed:@"numbers.png"] forState:UIControlStateNormal];
            [self.switchModeRow4Button setImage:[UIImage imageNamed:@"numbersHL.png"] forState:UIControlStateHighlighted];
            self.switchModeRow4Button.tag = 1;
            break;
    }

}

- (IBAction)keyPressed:(UIButton *)sender {
    //inserts the pressed character into the text document
    [self.textDocumentProxy insertText:sender.titleLabel.text];
    
    //if shiftStatus is 1, reset it to 0 by pressing the shift key
    if (_shiftStatus == 1) {
        [self shiftKeyPressed:self.shiftButton];
    }

}


// Unused Keyboard Methods

- (void)keyboardViewShouldDismiss
{
    [self dismissKeyboard];
}

- (void)keyboardViewDidInputDelete
{
    [self.textDocumentProxy deleteBackward];
}

- (void)keyboardViewDidInputReturn
{
    [self.textDocumentProxy insertText:@"\n"];
}

- (void)keyboardViewBackCursor
{
    [self.textDocumentProxy adjustTextPositionByCharacterOffset:-1];
}

- (void)keyboardViewForwardCursor
{
    [self.textDocumentProxy adjustTextPositionByCharacterOffset:1];
}

- (void)keyboardView:(KeyboardViewController *)keyboardViewController didAcceptCandidate:(NSString *)candidate
{
    [self.textDocumentProxy insertText:candidate];
}



@end
