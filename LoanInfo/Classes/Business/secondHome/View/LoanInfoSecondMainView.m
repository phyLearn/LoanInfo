//
//  LoanInfoSecondMainView.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoSecondMainView.h"
#import "LoanInfoSecondImport.h"


#define BANNERHEIGHT  100
#define SCROLLLABELVIEWHEIGHT 30

@interface LoanInfoSecondMainView()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic, strong) UITableView *mainTableView;//tableView
@property (nonatomic, strong) NSArray *scrolTexts;
@property (nonatomic, strong) NSArray *cellData;
@property (nonatomic, strong) UIView *headerView;

@end
@implementation LoanInfoSecondMainView

static NSString *const mainCell = @"AppMainCell";

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [LoanInfoMainConfig getBackgroundColor];
        [self addSubview:self.mainTableView];
    }
    return self;
}

- (UITableView *)mainTableView{
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _mainTableView.backgroundColor = [UIColor clearColor];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.backgroundColor = [UIColor clearColor];
        [_mainTableView registerNib:[UINib nibWithNibName:mainCell bundle:nil] forCellReuseIdentifier:mainCell];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.tableHeaderView = self.headerView;
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(mjheaderRefresh)];
        _mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(mjfooterRefresh)];
    }
    return _mainTableView;
}

- (UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc] init];
        _headerView.frame = CGRectMake(0, 0, self.bounds.size.width, 10);
        _headerView.backgroundColor = [LoanInfoMainConfig getBackgroundColor];
    }
    return _headerView;
}

- (NSArray *)cellData{
    if(!_cellData){
        _cellData = [NSArray array];
    }
    return _cellData;
}

//下拉刷新
- (void)mjheaderRefresh{
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%@%ld",@"headerRefreshObser",self.currentTag] object:nil];
}

//上拉刷新
- (void)mjfooterRefresh{
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%@%ld",@"footerRefreshObser",self.currentTag] object:nil];
}

- (void)endRefresh{
    //数据来了，需要停止刷新
    if(self.mainTableView.mj_header.isRefreshing){
        [self.mainTableView.mj_header endRefreshing];
    }
    
    if(self.mainTableView.mj_footer.isRefreshing){
        [self.mainTableView.mj_footer endRefreshing];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

#pragma mark-cell的复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppMainCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell refreshUI:self.cellData[indexPath.row]];
    cell.cellActionBlock = ^{
        NSDictionary *dict = self.cellData[indexPath.row];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"secondTableViewDidClickObser" object:@{@"listId":dict[@"id"]}];
    };
    return cell;
}

#pragma mark --- 刷新数据 ---
- (void)refresCellDataWithDict:(NSDictionary *)dict page:(NSString *)inpage{
    [self endRefresh];
    NSInteger page = [inpage integerValue];
    if(page > 1){//如果不是第一页就要将数据递增
        NSMutableArray *newArr = [NSMutableArray arrayWithArray:self.cellData];
        NSArray *rowData = dict[@"rowData"];
        for(NSDictionary *newDict in rowData){
            [newArr addObject:newDict];
        }
        self.cellData = newArr;
    }else{
        self.cellData = dict[@"rowData"];
    }
    [self.mainTableView reloadData];
}
@end
