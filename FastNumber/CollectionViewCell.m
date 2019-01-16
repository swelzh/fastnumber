
//
//  CollectionViewCell.m
//  CollectionView-PureCode
//
//  Created by chenyufeng on 15/10/30.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "CollectionViewCell.h"
#import "Masonry.h"
#import "EDColor.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

  self = [super initWithFrame:frame];
  if (self) {
     
      self.textLabel = [[UILabel alloc] init];
      self.textLabel.textAlignment = NSTextAlignmentCenter;
      [self addSubview:self.textLabel];
      self.textLabel.backgroundColor = [UIColor colorWithHex:0xF4F2D7];
      
      [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.right.bottom.top.equalTo(self);
      }];
      
      
//      self.leftLine = [[UIImageView alloc] init];
//      self.leftLine.backgroundColor = [UIColor grayColor];
//      [self addSubview:self.leftLine];
//      [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
//          make.top.left.bottom.equalTo(self);
//          make.width.equalTo(@(1));
//      }];
      
      
      self.rightLine = [[UIImageView alloc] init];
      self.rightLine.backgroundColor = [UIColor lightGrayColor];
      [self addSubview:self.rightLine];
      [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.right.bottom.equalTo(self);
          make.width.equalTo(@(1));
      }];
      
       
      
  }
  return self;
}

@end
