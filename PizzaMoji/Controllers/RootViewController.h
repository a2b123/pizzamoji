//
//  RootViewController.h
//  PizzaMoji
//
//  Created by Amar Bhatia on 1/19/19.
//  Copyright © 2019 Amar-Bhatia. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RootViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    
    __weak IBOutlet UICollectionView *emojiCollectionView;
    __weak IBOutlet UICollectionViewFlowLayout *layout;
    
    
}

@end

