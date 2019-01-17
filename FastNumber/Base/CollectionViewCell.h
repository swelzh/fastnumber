//
//  CollectionViewCell.h
//  CollectionView-PureCode
//
//  Created by chenyufeng on 15/10/30.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property(strong,nonatomic) UIImageView *imageView;
@property(strong,nonatomic) UILabel *textLabel;

@property(strong,nonatomic) UIImageView *leftLine;
@property(strong,nonatomic) UIImageView *rightLine;

@end
