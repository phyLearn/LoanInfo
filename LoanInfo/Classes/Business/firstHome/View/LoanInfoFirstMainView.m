//
//  LoanInfoFirstMainView.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoFirstMainView.h"
#import "LoanInfoFirstImport.h"

#define BANNERHEIGHT  100
#define ALLLOANVIEWHEIGHT 30
#define ZEROVIEWHEIGHT 100

@interface LoanInfoFirstMainView()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) HYCarouselView *bannerView;//bannerView
@property (nonatomic, strong) UITableView *mainTableView;//tableView
@property (nonatomic, strong) LoanInfoFirstZeroView *zeroView;
@property (nonatomic, strong) UIView *allLoanView; //借款总人数
@property (nonatomic, strong) NSArray *cellData;

@end
@implementation LoanInfoFirstMainView

static NSString *const mainCell = @"AppMainCell";

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.mainTableView];
        self.backgroundColor = [LoanInfoMainConfig getBackgroundColor];
    }
    return self;
}

- (NSMutableAttributedString *)contentAttributeStr:(NSString *)contentStr{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:contentStr];
    
    NSError *error;
    //正则表达式，解析出所有的数字
    NSString* regexString = @"\\d{0,}";
    //创建一个正则表达式对象，存储匹配规则
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:0 error:&error];
    NSMutableArray* rangeArray = [[NSMutableArray alloc] init];//用于存储range
    if (regex != nil) {
        //用该方法解析出所有
        NSArray* array = [regex matchesInString:contentStr options:NSMatchingReportProgress range:NSMakeRange(0, [contentStr length])];
        
        //当解析出的数组至少有一个对象时，即原文本中存在至少一个符合规则的字段
        if (array.count != 0) {
            for (NSTextCheckingResult* result in array) {
                //从NSTextCheckingResult类中取出range属性
                NSRange range = result.range;
                //如果rang长度不为0则存储
                if(range.length != 0){
                    //用字典存储range
                    NSString *rangeLocal = [NSString stringWithFormat:@"%ld",range.location];
                    NSString *rangeLenth = [NSString stringWithFormat:@"%ld",range.length];
                    NSDictionary *rangeDict = @{@"rangeLocal":rangeLocal,@"rangeLenth":rangeLenth};
                    [rangeArray addObject:rangeDict];
                }
            }
        }
    }
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([rangeArray[0][@"rangeLocal"] integerValue], [rangeArray[0][@"rangeLenth"] integerValue])];
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange([rangeArray[0][@"rangeLocal"] integerValue], [rangeArray[0][@"rangeLenth"] integerValue])];

    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([rangeArray[1][@"rangeLocal"] integerValue], [rangeArray[1][@"rangeLenth"] integerValue]+2)];
    return str;
}

- (BOOL)isNumber:(NSString *)strValue
{
    NSScanner* scan = [NSScanner scannerWithString:strValue];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

- (HYCarouselView *)bannerView{
    if(!_bannerView){
        _bannerView = [[HYCarouselView alloc] init];
    }
    return _bannerView;
}


- (UIView *)allLoanView{
    if(!_allLoanView){
        _allLoanView = [[UIView alloc] init];
        _allLoanView.backgroundColor = [LoanInfoMainConfig getRedColor];
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 20, 20)];
        [iconImageView setImage:[UIImage imageNamed:@"loaninffirstlight"]];
        [_allLoanView addSubview:iconImageView];
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.tag = 11;
        
        [_allLoanView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(iconImageView.mas_right).offset(SPACEHEIGHT);
            make.centerY.equalTo(iconImageView);
            make.size.mas_equalTo(CGSizeMake(self.frame.size.width - CGRectGetMaxX(iconImageView.frame) - 2 * SPACEHEIGHT, iconImageView.frame.size.height));
        }];
    }
    return _allLoanView;
}

- (LoanInfoFirstZeroView *)zeroView{
    if(!_zeroView){
        _zeroView = [[NSBundle mainBundle] loadNibNamed:@"LoanInfoFirstZeroView" owner:self options:0][0];
        __weak typeof(self)weakSelf = self;
        _zeroView.tapOneActionBlock = ^{
            NSDictionary *dict = weakSelf.cellData[0];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"tableViewDidClickObser" object:@{@"listId":dict[@"id"]}];
        };
    }
    return _zeroView;
}

- (UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, BANNERHEIGHT + ALLLOANVIEWHEIGHT + ZEROVIEWHEIGHT + 4 * SPACEHEIGHT)];
        _headerView.backgroundColor = [LoanInfoMainConfig getBackgroundColor];
    }
    return _headerView;
}

- (UITableView *)mainTableView{
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) style:UITableViewStyleGrouped];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.backgroundColor = [UIColor clearColor];
        _mainTableView.showsVerticalScrollIndicator = NO;
        [_mainTableView registerNib:[UINib nibWithNibName:mainCell bundle:nil] forCellReuseIdentifier:mainCell];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.tableHeaderView = self.headerView;
        
        [self.headerView addSubview:self.zeroView];
        [self.zeroView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerView).offset(20);
            make.left.equalTo(self.headerView);
            make.right.equalTo(self.headerView);
            make.height.mas_equalTo(ZEROVIEWHEIGHT);
        }];
        [self.headerView addSubview:self.allLoanView];
        [self.headerView addSubview:self.bannerView];
        //定位总人数
        [self.allLoanView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.zeroView.mas_bottom);
            make.left.equalTo(self.zeroView);
            make.right.equalTo(self.zeroView);
            make.height.mas_equalTo(ALLLOANVIEWHEIGHT);
        }];

        //定位banner
        [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.allLoanView.mas_bottom).offset(SPACEHEIGHT);
            make.left.equalTo(self.zeroView);
            make.right.equalTo(self.zeroView);
            make.height.mas_equalTo(BANNERHEIGHT);
        }];
    }
    return _mainTableView;
}

- (NSArray *)cellData{
    if(!_cellData){
        _cellData = [NSArray array];
    }
    return _cellData;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.cellData.count > 1)
        return self.cellData.count - 1;
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

#pragma mark-cell的复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppMainCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell refreshUI:self.cellData[indexPath.row+1]];
    cell.cellActionBlock = ^{
        NSDictionary *dict = self.cellData[indexPath.row + 1];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"tableViewDidClickObser" object:@{@"listId":dict[@"id"]}];
    };
    return cell;
}

#pragma mark --- 根据数据刷新View ---
- (void)refreshBannerViewWithData:(NSDictionary *)dict{
    self.bannerView.imageArray = dict[@"FirstBannerArr"];
}

//取放款人数
- (void)refreshMaxLoanViewWithData:(NSDictionary *)dict{
    UILabel *contentContent = [self.headerView viewWithTag:11];
    NSMutableAttributedString *text = [self contentAttributeStr:dict[@"maxLoanCount"]];
    contentContent.attributedText = text;
}

- (void)refresCellDataWithDict:(NSDictionary *)dict{
    self.cellData = dict[@"rowData"];
    [self.mainTableView reloadData];
}

@end
