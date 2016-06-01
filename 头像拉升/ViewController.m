//
//  ViewController.m
//  头像拉升
//
//  Created by qzp on 16/6/1.
//  Copyright © 2016年 qzp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView * headImageView;
@property (nonatomic, strong) UIView * titleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.scrollView.contentSize = CGSizeMake(0, 1000);
    self.scrollView.delegate = self;
    
    _titleView = ({
        UIView * titleView = [[UIView alloc] init];
        titleView;
    });

    self.navigationItem.titleView = self.titleView;
    
    [self.titleView addSubview: self.headImageView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UIScrollViewDelegate-
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y + scrollView.contentInset.top;
    
    CGFloat scale = 1.0;
    
    //放大
    if (y < 0) {
        //最大距离300 ，发大倍数1.5
        scale = MIN(1.5, 1 - y /300);
        
        
    }
    else if (y > 0) { //缩放
        //缩放最下倍数
        scale = MAX(0.45, 1- y/300);
    }
    self.headImageView.transform = CGAffineTransformMakeScale(scale, scale);
    
    //保证头像 y 位置不变
    CGRect frame = self.headImageView.frame;
    frame.origin.y = - self.headImageView.layer.cornerRadius /2;
    self.headImageView.frame = frame;
    
}


#pragma mark--Getter-

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"icon120"]];
        _headImageView.bounds = CGRectMake(0, 0, 70, 70);
        _headImageView.layer.cornerRadius = CGRectGetWidth(_headImageView.bounds)/2;
        _headImageView.center = CGPointMake(self.titleView.center.x, 20);
        _headImageView.clipsToBounds = YES;
    }
    return  _headImageView;
}

@end
