//
//  CustomKeyboardViewController.h
//  PizzaMojiKeyboard
//
//  Created by Amar Bhatia on 1/22/19.
//  Copyright © 2019 Amar-Bhatia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomKeyboardViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *globeKey;
@property NSArray *emojiIcons;


@end

NS_ASSUME_NONNULL_END
