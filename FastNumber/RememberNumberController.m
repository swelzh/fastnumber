//
//  RememberNumberController.m
//  FastNumber
//
//  Created by swelzh on 2019/1/15.
//  Copyright © 2019 swelzh. All rights reserved.
//

#import "RememberNumberController.h"

#import "CollectionViewCell.h"
#import "AppDelegate.h"
#import "CollectionReusableView.h"
#import "IndexHelper.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)


static int marginLeft = 20;
static int marginRight = 20;


@interface RememberNumberController()
    <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic) UICollectionView *collectionView;
@property(strong,nonatomic) NSMutableArray *arr;
@property(strong,nonatomic) IndexHelper *indexHelper;


@end

@implementation RememberNumberController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    self = [super init];
    if (self) {
        _indexHelper = [[IndexHelper alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //不要忘记初始化；
    self.arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 400; i++) {
        NSNumber *nubmer = @(arc4random_uniform(10));
        [self.arr addObject:nubmer];
    }
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    CGFloat itemWidth = (SCREEN_WIDTH - 20 -20) / kRowCount;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc] initWithFrame:[[UIScreen mainScreen] bounds] collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionCell"];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self itemNumbers];
}

- (NSInteger)itemNumbers{
    NSInteger cloumnCount = kRowCount;
    NSInteger realCloumnCount = cloumnCount + 1;
    NSInteger rowCount = self.arr.count % cloumnCount == 0 ? self.arr.count/cloumnCount : self.arr.count/cloumnCount + 1;
    
    NSInteger realTotal = realCloumnCount * rowCount ;
    return realTotal;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionCell" forIndexPath:indexPath];
//    cell.imageView.image = [self.arr objectAtIndex:indexPath.row];
//    cell.textLabel.text = [[NSString alloc] initWithFormat:@"{%ld,%ld}",indexPath.section,indexPath.row];
    if ([self.indexHelper isRowEnd:indexPath]) {
        cell.textLabel.text = [NSString stringWithFormat:@"Row%ld",(indexPath.row + 1)/(kRowCount + 1)];
    }else if (indexPath.row < self.arr.count) {
        cell.textLabel.text = [[self.arr objectAtIndex:indexPath.row] stringValue];
    }else{
        cell.textLabel.text = @"";
    }
    
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusable = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        
        CollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
        view.title.text = [[NSString alloc] initWithFormat:@"头部视图%ld",indexPath.section];
        reusable = view;
    }
    return reusable;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger cellCount = kRowCount + 1;
    BOOL isRowEnd = (indexPath.row + 1) % cellCount == 0 ;
    
    NSString *message = [[NSString alloc] initWithFormat:@"你点击了第%ld个section，第%ld个cell %@",(long)indexPath.section,(long)indexPath.row, isRowEnd?@"行末啊":@"不是行末"];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击确定后执行的操作；
    }]];
    [self presentViewController:alert animated:true completion:^{
        //显示提示框后执行的事件；
    }];
}



#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger rowCount = kRowCount;
    NSInteger cellCount = kRowCount + 1;
    
    CGFloat displayWidth = SCREEN_WIDTH - marginLeft - marginRight;
    CGFloat rowLabelWidth = 70;
    
    
    
    // 判断是否行末
    BOOL isRowEnd = [self.indexHelper isRowEnd:indexPath];
    
    // 数字cell
    CGFloat itemWidth = (displayWidth - rowLabelWidth) / rowCount;
    CGFloat itemHeight = itemWidth;
    CGSize itemSize = CGSizeMake(itemWidth, itemWidth);
    
    // 行数cell
    if (isRowEnd) {
        itemSize = CGSizeMake(rowLabelWidth, itemHeight);
    }
    
    return itemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, marginLeft, 10, marginRight);
//    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(300, 20);
}
/*
 
 - (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
 - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
 - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
 */



@end
