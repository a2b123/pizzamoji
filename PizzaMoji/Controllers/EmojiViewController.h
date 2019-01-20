//
//  EmojiViewController.h
//  PizzaMoji
//
//  Created by Amar Bhatia on 1/19/19.
//  Copyright © 2019 Amar-Bhatia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmojiViewController : UIViewController

@property UIImage *emoji;
@property (weak, nonatomic) IBOutlet UIImageView *emojiImageView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;


@end

NS_ASSUME_NONNULL_END
