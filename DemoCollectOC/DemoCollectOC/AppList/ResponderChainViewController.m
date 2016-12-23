//
//  ResponderChainViewController.m
//  DemoCollectOC
//
//  Created by ShawnDu on 2016/12/23.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import "ResponderChainViewController.h"

@interface ContainerView : UIView

@end

@implementation ContainerView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addTap];
    }
    return self;
}

- (void)addTap {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tap];
}

- (void)tapped:(UIGestureRecognizer *)tap {
    NSLog(@" %@ tapped:%@", self.class, NSStringFromCGPoint([tap locationInView:self]));
}
@end

@interface FirstView : UIView

@end

@implementation FirstView
@end

@interface FirstFriendView : UIView

@end

@implementation FirstFriendView

@end

@interface SecondView : UIView

@end

@implementation SecondView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        [self addTap];
    }
    return self;
}

- (void)addTap {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tap];
}

- (void)tapped:(UIGestureRecognizer *)tap {
    NSLog(@"%@ tapped:%@", self.class, NSStringFromCGPoint([tap locationInView:self]));
}

@end
@interface ResponderChainViewController ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *firstView;
@property (nonatomic, strong) UIView *firstFriendView;
@property (nonatomic, strong) UIView *secondView;
@end

@implementation ResponderChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    // Do any additional setup after loading the view.
}

- (void)initViews {
    [self addContainerView];
    [self addFirstView];
    [self addFirstFriendView];
    [self addSecondView];
}

- (void)addContainerView {
    _containerView = [[ContainerView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    _containerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_containerView];
}

- (void)addFirstView {
    _firstView = [[FirstView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2 - 20)];
    _firstView.backgroundColor = [UIColor greenColor];
    [self.containerView addSubview:_firstView];
}

- (void)addFirstFriendView {
    _firstFriendView = [[FirstFriendView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2 + 10, self.view.frame.size.width, self.view.frame.size.height/2 - 20)];
    _firstFriendView.backgroundColor = [UIColor greenColor];
    [self.containerView addSubview:_firstFriendView];
}

- (void)addSecondView {
    _secondView = [[SecondView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 50)];
    _secondView.backgroundColor = [UIColor redColor];
    [self.firstView addSubview:_secondView];
}

@end
