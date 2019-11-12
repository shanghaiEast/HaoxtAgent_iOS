//
//  LineView.m
//  YanFarmwork
//
//  Created by HG on 2019/11/1.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "LineView.h"

#import "LHYChartView.h"

@interface LineView ()

@property (nonatomic,strong) LHYChartView *chartView;

@end

@implementation LineView

- (void)createChart {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self addChartLineView];
    });
   
}

-(void)addChartLineView{
    LHYChartView *incomeChartLineView = [[LHYChartView alloc]initWithFrame:_chartsView.bounds];
    //是否默认选中第一个
    //    incomeChartLineView.isShowFirstPaoPao = YES;
    incomeChartLineView.showPaoPaoForIndex = 6;
    //是否有网格
    incomeChartLineView.isGrid = YES;
    //是否显示所有点
    incomeChartLineView.isShow = YES;
    //是否可以浮动
    incomeChartLineView.isFloating = NO;
    //显示多少行
    incomeChartLineView.row = 6;
    //显示多少列
    incomeChartLineView.xRow = 6;
    //设置X轴坐标字体大小
    incomeChartLineView.x_Font = [UIFont systemFontOfSize:10];
    //设置X轴坐标字体颜色
    incomeChartLineView.x_Color = [UIColor colorWithHexString:@"#999999"];
    //设置Y轴坐标字体大小
    incomeChartLineView.y_Font = [UIFont systemFontOfSize:10];
    //设置Y轴坐标字体颜色
    incomeChartLineView.y_Color = [UIColor colorWithHexString:@"#999999"];
    //设置背景颜色
    incomeChartLineView.backgroundColor = [UIColor whiteColor];
    //边框标线颜色
    incomeChartLineView.borderLineColor = [UIColor colorWithHexString:@"#999999"];
    //中间标线颜色
    incomeChartLineView.middleLineColor = [UIColor colorWithHexString:@"#cbcbcb" andAlpha:0.5];
    //边框三角颜色
    incomeChartLineView.borderTriangleColor = [UIColor colorWithHexString:@"#999999"];
    //设置泡泡背景颜色
    incomeChartLineView.paopaoBackGroundColor = [UIColor colorWithHexString:@"#000000" andAlpha:0.85];
    incomeChartLineView.markColor = [UIColor colorWithHexString:@"#FF5006"];
    //设置泡泡的标题颜色
    incomeChartLineView.paopaoTitleColor = [UIColor whiteColor];
    //设置折线样式
    incomeChartLineView.chartViewStyle = LHYChartViewMoreClickLine;
    //设置图层效果
    incomeChartLineView.chartLayerStyle = LHYChartGradient;
    //设置折现效果
    incomeChartLineView.lineLayerStyle = LHYLineLayerNone;
    
    incomeChartLineView.lineWidth = 3;
    
    incomeChartLineView.paopaoBackGroundColor = [UIColor colorWithHexString:@"#111111" andAlpha:0.8];
    //渐变开始比例
    incomeChartLineView.proportion = 0.5;
    
    incomeChartLineView.isShowBezier = YES;
    //折线图是否从零点开始画
    incomeChartLineView.hiddenZreo = YES;
    //设置颜色
    incomeChartLineView.leftColorStrArr = @[@"#FFC9AB",@"#FBDBC7"];
    //是否显示Y轴零位
    incomeChartLineView.isShowZero = YES;
    //泡泡是否跟随屏幕滑动而滑动
    incomeChartLineView.paopaoFollowSliding = NO;
    //折线图数据
    incomeChartLineView.leftDataArr = @[@[@"-9999.4",@"30907",@"32010",@"33450",@"30069",@"31574",@"30692",@"33156",@"29808",@"31846",@"29772",@"29630"]];
    //底部日期
    incomeChartLineView.dataArrOfX = @[@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月",@"1月",@"2月",@"3月"];
    //泡泡标题
    //    incomeChartLineView.paopaoTitleArray = @[@"2018-04",@"2018-05",@"2018-06",@"2018-07",@"2018-08",@"2018-09",@"2018-10",@"2018-11",@"2018-12",@"2019-01",@"2019-02",@"2019-03"];
    //返回泡泡选中值
    incomeChartLineView.returnPaoPaoDataBlock = ^(NSArray *array, NSString *title) {
        NSLog(@"%@-----%@",array,title);
    };
    incomeChartLineView.paopaoDataColors = @[[UIColor colorWithHexString:@"#6dd89c"],[UIColor colorWithHexString:@"#00a1eb"],[UIColor colorWithHexString:@"#bc69e0"],[UIColor colorWithHexString:@"#385af0"]];
    //泡泡数据
    incomeChartLineView.paopaoDataArray = @[@[@"-10,000元m²",@"30,907元m²",@"32,010元m²",@"33,450元m²",@"30,069元m²",@"31,574元m²",@"30,692元m²",@"33,156元m²",@"29,808元m²",@"31,846元m²",@"29,772元m²",@"29,630元m²"],@[@"46,175元m²",@"44,915元m²",@"36,228元m²",@"50,473元m²",@"28,811元m²",@"11,876元m²",@"23,213元m²",@"26,847元m²",@"27,905元m²",@"9,562元m²",@"34,263元m²",@"25,459元m²"],@[@"20,549元m²",@"15,981元m²",@"23,375元m²",@"20,516元m²",@"19,208元m²",@"15,121元m²",@"13,776元m²",@"16,282元m²",@"30,748元m²",@"26,531元m²",@"31,298元m²",@"33,183元m²"],@[@"11,053元m²",@"25,811元m²"]];
    //开始画图
    [incomeChartLineView show];
    [_chartsView addSubview:incomeChartLineView];
}

@end
