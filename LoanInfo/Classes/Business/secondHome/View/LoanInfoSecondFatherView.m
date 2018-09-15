//
//  LoanInfoSecondFatherView.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/11.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoSecondFatherView.h"
#import "LoanInfoSecondImport.h"

@interface LoanInfoSecondFatherView()
<
    SGPageTitleViewDelegate,
    SGPageContentScrollViewDelegate
>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;

@end
@implementation LoanInfoSecondFatherView

- (instancetype)initWithFrame:(CGRect)frame withDele:(UIViewController *)vc{
    self = [super initWithFrame:frame];
    if(self){
        [self setUpPageViewWithDele:vc];
    }
    return self;
}

//初始化segment
- (void)setUpPageViewWithDele:(UIViewController *)vc{
    NSArray *titleArr = @[@"今日新口子",@"期限最长",@"最好申请",@"最快放款"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleFont = [UIFont systemFontOfSize:12];
    configure.indicatorHeight = 2;
    configure.indicatorCornerRadius = .5;
    configure.titleColor = [LoanInfoMainConfig getLighGrayColor];
    configure.titleSelectedColor = [UIColor blackColor];
    configure.indicatorColor = [LoanInfoMainConfig getYellowColor];
    configure.indicatorStyle = SGIndicatorStyleDefault;
    configure.showBottomSeparator = NO;
    configure.showVerticalSeparator = YES;
    configure.verticalSeparatorColor = [LoanInfoMainConfig getLineColor];
    configure.verticalSeparatorReduceHeight = 2 * SPACEHEIGHT;
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, self.bounds.size.width, 44) delegate:self titleNames:titleArr configure:configure];
    [self addSubview:self.pageTitleView];
    self.pageTitleView.selectedIndex = 0;
    
    LoanInfoSecondChildViewController *childOneVC = [[LoanInfoSecondChildViewController alloc] init];
    LoanInfoSecondChildViewController *childTwoVC = [[LoanInfoSecondChildViewController alloc] init];
    LoanInfoSecondChildViewController *childThridVC = [[LoanInfoSecondChildViewController alloc] init];
    LoanInfoSecondChildViewController *childFourVC = [[LoanInfoSecondChildViewController alloc] init];
    NSArray *childArr = @[childOneVC,childTwoVC,childThridVC,childFourVC];
    
    CGFloat contentViewHeight = self.bounds.size.height - CGRectGetMaxY(self.pageTitleView.frame);
    self.pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pageTitleView.frame), self.frame.size.width, contentViewHeight) parentVC:vc childVCs:childArr];
    self.pageContentScrollView.delegatePageContentScrollView = self;
    [self addSubview:self.pageContentScrollView];
}

//scrollview代理
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentScrollView setPageContentScrollViewCurrentIndex:selectedIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView index:(NSInteger)index {
    /// 说明：在此获取标题or当前子控制器下标值
    HYLog(@"index - - %ld", index);
}

@end
