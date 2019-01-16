//
//  IndexHelper.m
//  FastNumber
//
//  Created by swelzh on 2019/1/16.
//  Copyright © 2019 swelzh. All rights reserved.
//

#import "IndexHelper.h"
#import <UIKit/UIKit.h>

@implementation IndexHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        _intervalNumber = 4;
    }
    return self;
}

- (BOOL)isRowEnd:(NSIndexPath *)indexPath{
    
    NSInteger cellCount = kRowCount + 1;
    // 判断是否行末
    BOOL isRowEnd = (indexPath.row + 1) % cellCount == 0 ;
    return isRowEnd;
}

- (BOOL)isInterval:(NSIndexPath *)indexPath{
    NSInteger current = indexPath.row;
    NSInteger cellCount = kRowCount + 1;
    NSInteger columnIndex = current % cellCount ;
    return (columnIndex + 1) % self.intervalNumber == 0;
}

@end
