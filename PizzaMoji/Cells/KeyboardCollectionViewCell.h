//
//  KeyboardCollectionViewCell.h
//  PizzaMoji
//
//  Created by Amar Bhatia on 1/21/19.
//  Copyright © 2019 Amar-Bhatia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyboardCollectionViewCell : UICollectionViewCell

@property UIImageView *emojiImageView;
@property NSString *imageName;
@property NSString *targetName;

@end

NS_ASSUME_NONNULL_END
