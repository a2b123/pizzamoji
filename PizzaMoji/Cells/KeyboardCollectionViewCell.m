//
//  KeyboardCollectionViewCell.m
//  PizzaMoji
//
//  Created by Amar Bhatia on 1/22/19.
//  Copyright © 2019 Amar-Bhatia. All rights reserved.
//

#import "KeyboardCollectionViewCell.h"

@implementation KeyboardCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupCell];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupCell];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    
    
    self.userInteractionEnabled = YES;
    
}


@end
