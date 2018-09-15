//
//  LoanInfoProductsMainView.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoProductsMainView.h"
#import "LoanInfoProductsImport.h"

#define HEADERHEIGHT 180
#define CELLHEIGHT 100

@interface LoanInfoProductsMainView()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) LoanInfoProductsHeaderView *headerView;
@property (nonatomic, strong) UIButton *nextBtn;

@end
@implementation LoanInfoProductsMainView

static NSString *const productsCell = @"LoanInfoProductsCell";

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [LoanInfoMainConfig getBackgroundColor];
        [self addSubview:self.nextBtn];
        [self addSubview:self.mainTableView];
    }
    return self;
}

- (UITableView *)mainTableView{
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - self.nextBtn.frame.size.height - SPACEHEIGHT)];
        _mainTableView.backgroundColor = [UIColor clearColor];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.backgroundColor = [UIColor clearColor];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mainTableView registerNib:[UINib nibWithNibName:productsCell bundle:nil] forCellReuseIdentifier:productsCell];
        _mainTableView.tableHeaderView = self.headerView;
        _mainTableView.showsVerticalScrollIndicator = NO;
    }
    return _mainTableView;
}

- (LoanInfoProductsHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"LoanInfoProductsHeaderView" owner:self options:0][0];
        _headerView.frame = CGRectMake(0, 0, self.frame.size.width, HEADERHEIGHT);
    }
    return _headerView;
}

- (void)setProductsData:(NSDictionary *)productsData{
    _productsData = productsData;
    [self.headerView refreshUI:productsData];
    [self.mainTableView reloadData];
}

- (UIButton *)nextBtn{
    if(!_nextBtn){
        CGFloat btnWidth = self.bounds.size.width;
        CGFloat btnHeight = [LoanInfoTools scaleWithWidth:btnWidth andWidthScale:335 heihgtScale:43]; //按照335/43的比例算的
        _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - btnHeight - SPACEHEIGHT, btnWidth, btnHeight)];
        [_nextBtn setTitle:@"立即申请" forState:UIControlStateNormal];
        _nextBtn.backgroundColor = [LoanInfoMainConfig getYellowColor];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

- (void)nextBtnAction{
    self.nextBtnActionBlock();
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *productArr = self.productsData[@"productsArr"];
    return productArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELLHEIGHT;
}

#pragma mark-cell的复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoanInfoProductsCell *cell = [tableView dequeueReusableCellWithIdentifier:productsCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *productArr = self.productsData[@"productsArr"];
    [cell refreshUI:productArr[indexPath.row]];
    return cell;
}
@end
