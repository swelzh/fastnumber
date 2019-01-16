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


+ (BOOL)isRowEnd:(NSIndexPath *)indexPath{
    
    NSInteger rowCount = kRowCount;
    NSInteger cellCount = rowCount + 1;
    // 判断是否行末
    BOOL isRowEnd = (indexPath.row + 1) % cellCount == 0 ;
    return isRowEnd;
}

@end
