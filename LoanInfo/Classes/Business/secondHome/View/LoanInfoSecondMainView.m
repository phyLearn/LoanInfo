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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellData.count - 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

#pragma mark-cell的复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppMainCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell refreshUI:self.cellData[indexPath.row + 1]];
    cell.cellActionBlock = ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"secondTableViewDidClickObser" object:nil];
    };
    return cell;
}

#pragma mark --- 刷新数据 ---
- (void)refresCellDataWithDict:(NSDictionary *)dict{
    self.cellData = dict[@"rowData"];
    [self.mainTableView reloadData];
}
@end
