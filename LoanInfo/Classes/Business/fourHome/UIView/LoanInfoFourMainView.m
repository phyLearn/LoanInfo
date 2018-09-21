//
//  LoanInfoFourMainView.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoFourMainView.h"
#import "LoanInfoFourImport.h"

@interface LoanInfoFourMainView()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (nonatomic, strong) LoanInfoMyHeaderView *headView;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableDictionary *cellData;//用于控制cell列表

@end
@implementation LoanInfoFourMainView

static NSString *const myMainCell = @"MyMainCell";

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
    }
    return self;
}

- (void)refreshCellData:(NSDictionary *)dict{
    self.cellData = [dict mutableCopy];
    [self addSubview:self.mainTableView];
}

- (void)refreshHeaderView:(NSDictionary *)dict{
    [self.headView refreshUI:dict];
}

- (LoanInfoMyHeaderView *)headView{
    if(!_headView){
        _headView = [[NSBundle mainBundle] loadNibNamed:@"LoanInfoMyHeaderView" owner:self options:0][0];
        _headView.frame = CGRectMake(0, 0, self.bounds.size.width, [LoanInfoTools scaleWithWidth:self.bounds.size.width andWidthScale:329 heihgtScale:124]);
    }
    return _headView;
}

- (UITableView *)mainTableView{
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableHeaderView = self.headView;
        _mainTableView.backgroundColor = [LoanInfoMainConfig getBackgroundColor];
        _mainTableView.bounces = NO;
        [_mainTableView registerNib:[UINib nibWithNibName: myMainCell bundle:nil] forCellReuseIdentifier:myMainCell];
    }
    return _mainTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSArray *sectionArr = self.cellData[@"sectionArr"];
    return sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArr = self.cellData[@"sectionArr"];
    NSDictionary *cellDict = sectionArr[section];
    NSArray *cellArr = cellDict[@"cellArr"];
    return cellArr.count;
}

#pragma mark-cell的复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyMainCell *cell = [tableView dequeueReusableCellWithIdentifier:myMainCell];
    NSDictionary *cellDict = self.cellData[@"sectionArr"][indexPath.section][@"cellArr"][indexPath.row];
    [cell refreshUI:cellDict];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellClickBlock = ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FourTableViewDidClickObser" object:cellDict];
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [LoanInfoMainConfig getBackgroundColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [LoanInfoTools scaleWithWidth:self.bounds.size.width andWidthScale:335 heihgtScale:50];
}
@end
