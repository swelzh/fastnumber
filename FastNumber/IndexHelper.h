//
//  IndexHelper.h
//  FastNumber
//
//  Created by swelzh on 2019/1/16.
//  Copyright © 2019 swelzh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kRowCount 12

@interface IndexHelper : NSObject

@property (nonatomic, assign) NSInteger intervalNumber;//间隔数

// 是否行尾
- (BOOL)isRowEnd:(NSIndexPath *)indexPath;
// 末尾间隔数
- (BOOL)isInterval:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
