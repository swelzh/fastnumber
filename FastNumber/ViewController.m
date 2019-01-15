//
//  ViewController.m
//  FastNumber
//
//  Created by swelzh on 2019/1/15.
//  Copyright © 2019 swelzh. All rights reserved.
//

#import "ViewController.h"
#import "RememberNumberController.h"
//#import "FastNumber-swift.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchDown {
    
    
    RememberNumberController *vc = [[RememberNumberController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
