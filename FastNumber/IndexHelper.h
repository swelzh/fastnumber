//
//  IndexHelper.h
//  FastNumber
//
//  Created by swelzh on 2019/1/16.
//  Copyright © 2019 swelzh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kRowCount 16

@interface IndexHelper : NSObject

@property (nonatomic, assign) NSInteger intervalNumber;//间隔数

- (BOOL)isRowEnd:(NSIndexPath *)indexPath;
- (BOOL)isInterval:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
