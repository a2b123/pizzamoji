//
//  RootViewController.m
//  PizzaMoji
//
//  Created by Amar Bhatia on 1/19/19.
//  Copyright © 2019 Amar-Bhatia. All rights reserved.
//

#import "RootViewController.h"
#import "EmojiCollectionViewCell.h"
#import "EmojiViewController.h"
#import "SettingsViewController.h"


@interface RootViewController () {
    CGFloat cellHeight;
    NSMutableArray *emojis;
    UIImage *selectedEmoji;
    SettingsViewController *settingsVC;

}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *localDirectory = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask][0];
    NSLog(@"APP ---> %@", localDirectory.absoluteString);

    cellHeight = 150;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    CGFloat cellWidth = [self calcCellWidth:self.view.frame.size];
    layout.itemSize = CGSizeMake(cellWidth, cellHeight);
//    NSLog(@"layout.itemsize ---> %@", layout.itemSize);

    
    emojis = [[NSMutableArray alloc] initWithObjects:
              [UIImage imageNamed:@"cheese"],
              [UIImage imageNamed:@"pepperoni"],
              [UIImage imageNamed:@"sausage"],
              [UIImage imageNamed:@"meatlovers"],
              [UIImage imageNamed:@"veggie"],
              [UIImage imageNamed:@"deepdish"],
              [UIImage imageNamed:@"breakfast"],
              [UIImage imageNamed:@"lunch"],
              [UIImage imageNamed:@"dinner"],
              [UIImage imageNamed:@"sunday"],
              [UIImage imageNamed:@"monday"],
              [UIImage imageNamed:@"tuesday"],
              [UIImage imageNamed:@"wednesday"],
              [UIImage imageNamed:@"thursday"],
              [UIImage imageNamed:@"friday"],
              [UIImage imageNamed:@"saturday"],
              [UIImage imageNamed:@"cheatday"],
              [UIImage imageNamed:@"mopizza"],
              [UIImage imageNamed:@"pizzapie"],
              [UIImage imageNamed:@"sliceaday"],
              [UIImage imageNamed:@"pizzatown"],
              [UIImage imageNamed:@"pizzaordeath"],
              [UIImage imageNamed:@"pizzaparty"],
              [UIImage imageNamed:@"toppingbacon"],
              [UIImage imageNamed:@"toppingblackolives"],
              [UIImage imageNamed:@"toppingmushrooms"],
              [UIImage imageNamed:@"toppingonions"],
              [UIImage imageNamed:@"toppingpepperoni"],
              [UIImage imageNamed:@"toppingpeppers"],
              [UIImage imageNamed:@"toppingpineapple"],
              [UIImage imageNamed:@"toppingsausage"],
              [UIImage imageNamed:@"toppingshrimp"],
              [UIImage imageNamed:@"toppingbasil"],
              [UIImage imageNamed:@"toppingtomato"],
              nil];

    
    UIImage *freePizzaImage = [UIImage imageNamed:@"freepizzabutton"];
    CGRect pizzaFrame = CGRectMake(0, 0, 55, 35);
    UIButton *pizzaButton = [[UIButton alloc] initWithFrame:pizzaFrame];
    [pizzaButton setBackgroundImage:freePizzaImage forState:UIControlStateNormal];
    [pizzaButton addTarget:self action:@selector(segueToPizzaPage)
          forControlEvents:UIControlEventTouchUpInside];
    [pizzaButton setShowsTouchWhenHighlighted:YES];
    
    
    UIBarButtonItem *pizzaBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:pizzaButton];
    self.navigationItem.leftBarButtonItem = pizzaBarButtonItem;
    
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.topItem.title = @"PizzaMoji";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tablecloth"]]];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName: [UIFont fontWithName:@"soupofjustice" size:18] };
    
}

#pragma mark UICollectionView DataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EmojiCollectionViewCell *emojiCell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"EmojiCellID" forIndexPath:indexPath];
    emojiCell.emojiImageView.image = [emojis objectAtIndex:indexPath.row];
//    NSLog(@"Emoji Cell ---> %@", emojiCell);
    return emojiCell;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    NSLog(@"Emoji Count ---> %@", emojis);

    return emojis.count;
    
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    CGFloat cellWidth = [self calcCellWidth:size];
    layout.itemSize = CGSizeMake(cellWidth, 200);
    
}

-(CGFloat) calcCellWidth :(CGSize) size {
    
    float cellWidth = size.width/3;
    return cellWidth;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    selectedEmoji = [emojis objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"RootToEmojiSegue" sender:self];
}

-(void)segueToPizzaPage {
    
    UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *freePizzaVC = [mystoryboard instantiateViewControllerWithIdentifier:@"FreePizzaView"];
    [self.navigationController pushViewController:freePizzaVC animated:YES];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Pass emoji to EmojiViewController
    
    if ([segue.identifier isEqualToString:@"RootToEmojiSegue"]) {
        EmojiViewController *evc = segue.destinationViewController;
        evc.emoji = selectedEmoji;
    }
}



@end

