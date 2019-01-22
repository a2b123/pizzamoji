//
//  CustomKeyboardViewController.m
//  PizzaMojiKeyboard
//
//  Created by Amar Bhatia on 1/21/19.
//  Copyright © 2019 Amar-Bhatia. All rights reserved.
//

#import "CustomKeyboardViewController.h"

@interface CustomKeyboardViewController ()

@end

@implementation CustomKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"KeyboardCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
    self.emojiIcons = [NSArray arrayWithObjects:@"skull", @"skull", @"skull", @"skull", @"skull", @"skull", @"skull", @"skull", @"skull", @"skull", @"skull", @"skull", @"skull", @"skull", @"skull", @"skull", nil];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 30;
}

- (KeyboardCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KeyboardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.emojiImageView.image = [UIImage imageNamed:[self.emojiIcons objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    KeyboardCollectionViewCell *cell = (KeyboardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSArray *views = [cell.contentView subviews];
    UIImage *imageTitle = [views objectAtIndex:0];
}





@end
