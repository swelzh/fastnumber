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
#import "Masonry.h"
#import "EDColor.h"
#import "FastNumberKeyboard.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)


static int marginLeft = 10;
static int marginRight = 10;


@interface RememberNumberController()
    <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,
FastNumberKeyboardDelegate>

@property(strong,nonatomic) UICollectionView *collectionView;
@property(strong,nonatomic) NSMutableArray *arr;
@property(strong,nonatomic) IndexHelper *indexHelper;
@property(strong,nonatomic) UIView *inputView;

@property (strong, nonatomic) UITextField *textField;

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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 400; i++) {
        NSNumber *nubmer = @(arc4random_uniform(10));
        [self.arr addObject:nubmer];
    }
    [self addSubViews];
}


- (void)addSubViews{
    
    self.view.backgroundColor = [UIColor colorWithHex:0xF4F2D7];
    
    
    // addInputView
    UIView *inputView = [UIView new];
    inputView.backgroundColor= [UIColor colorWithHex:0xF4F2D7];;
    [self.view addSubview:inputView];
    self.inputView = inputView;
    
    
    
    
    // addCollectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView.backgroundColor = [UIColor colorWithHex:0xF4F2D7];
    self.collectionView.backgroundView.backgroundColor = [UIColor colorWithHex:0xF4F2D7];
    self.collectionView = [[UICollectionView alloc] initWithFrame:[[UIScreen mainScreen] bounds] collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionCell"];
    self.collectionView.scrollEnabled = YES;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.inputView.mas_top);
    }];
    
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@(200));
    }];
    
    // inputView
    // Create and configure the keyboard.
    FastNumberKeyboard *keyboard = [[FastNumberKeyboard alloc] initWithFrame:CGRectZero];
    keyboard.allowsDecimalPoint = YES;
    keyboard.delegate = self;
    
    // Configure an example UITextField.
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.backgroundColor = [UIColor yellowColor];
    textField.inputView = keyboard;
    [self.view addSubview:textField];
    self.textField = textField;
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


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionCell" forIndexPath:indexPath];
 
    if ([self.indexHelper isRowEnd:indexPath]) {
        cell.textLabel.text = [NSString stringWithFormat:@"row%ld",(indexPath.row + 1)/(kRowCount + 1)];
        cell.rightLine.hidden = YES;
    }else if (indexPath.row < self.arr.count) {
        cell.textLabel.text = [[self.arr objectAtIndex:indexPath.row] stringValue];
        cell.rightLine.hidden = ![self.indexHelper isInterval:indexPath];
    }else{
        cell.textLabel.text = @"";
        cell.rightLine.hidden = YES;
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



#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger rowCount = kRowCount;
   
    CGFloat displayWidth = SCREEN_WIDTH - marginLeft - marginRight;
    CGFloat rowLabelWidth = 60;
    
    
    
    // 判断是否行末
    BOOL isRowEnd = [self.indexHelper isRowEnd:indexPath];
    
    // 数字cell
    CGFloat itemWidth = (displayWidth - rowLabelWidth) / rowCount;
    CGFloat itemHeight = itemWidth+2;
    CGSize itemSize = CGSizeMake(itemWidth, itemHeight);
    
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




/*
 
 - (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
 - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
 - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
 */


#pragma mark - FastNumberKeyboardDelegate.

- (BOOL)numberKeyboardShouldReturn:(FastNumberKeyboard *)numberKeyboard
{
    // Do something with the done key if neeed. Return YES to dismiss the keyboard.
    return YES;
}

@end
