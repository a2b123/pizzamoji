//
//  EmojiViewController.m
//  PizzaMoji
//
//  Created by Amar Bhatia on 1/19/19.
//  Copyright © 2019 Amar-Bhatia. All rights reserved.
//

#import "EmojiViewController.h"

@interface EmojiViewController ()

@end

@implementation EmojiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.emojiImageView.image = self.emoji;
    self.shareButton.layer.cornerRadius = 5;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< Back" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
    
    //add tap gesture to emoji imageview
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareContent)];
    tap.cancelsTouchesInView = YES;
    tap.numberOfTapsRequired = 1;
    
    [self.emojiImageView addGestureRecognizer:tap];
    self.emojiImageView.userInteractionEnabled = YES;
    
    [self.slider addTarget:self
                    action:@selector(sliderValueChanged:)
          forControlEvents:UIControlEventValueChanged];

}

- (void)viewWillAppear:(BOOL)animated {
    [self sliderValueChanged:self.slider];
}

- (void)dismissView {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)onShareButtonPressed:(UIButton *)sender {
    [self shareContent];
}

-(void)shareContent{
    
    NSString *message = @"#PizzaEmojiApp";
    //Uncomment the following line once we're ready to use slider
    //    UIImage *image = [self transformImageFromImageView];
    UIImage *image = self.emojiImageView.image;
    NSLog(@"%@", image);
    NSArray *shareItems = @[message, image];
    UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
}


- (UIImage *)transformImageFromImageView {
    
    
    CGSize size = CGSizeApplyAffineTransform(self.emoji.size, CGAffineTransformMakeScale(self.slider.value, self.slider.value));
    Boolean hasAlpha = false;
    CGFloat scale = self.slider.value * 0.15;
    UIGraphicsBeginImageContextWithOptions(size, hasAlpha, scale);
    
    [self.emoji drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaled = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    NSLog(@"%f :: %f", scaled.size.width, scaled.size.height);
    
    return scaled;
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    self.emojiImageView.transform = CGAffineTransformMakeScale(sender.value, sender.value);
    NSLog(@"%f :: %f", self.emojiImageView.frame.size.width, self.emojiImageView.frame.size.height);
    NSLog(@"%f :: %f", self.emojiImageView.frame.origin.x, self.emojiImageView.frame.origin.y);
}





@end
