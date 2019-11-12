//
//  PieView.m
//  YanFarmwork
//
//  Created by HG on 2019/11/1.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "PieView.h"

@import Charts;


@interface PieView ()<ChartViewDelegate>

@property (retain, nonatomic) PieChartView *chartView;
@property (nonatomic , assign) BOOL isValueLine;
@property (retain, nonatomic) NSMutableArray *valueArray, *keyArray;

@end

@implementation PieView

- (void)createChart {
    _keyArray = [[NSMutableArray alloc] init];
    _valueArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 2; i ++) {
        [_keyArray addObject:[NSString stringWithFormat:@"key%d",i]];
        [_valueArray addObject:[NSString stringWithFormat:@"%d",(i+10)*6]];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //创建饼图
        [self createChartView];
        
        //插入数据
        self.isValueLine = 1;
        [self setPieData];
    });
    
}

- (void)createChartView
{
    _chartView = [[PieChartView alloc]initWithFrame:_chartsView.bounds];
    [_chartsView addSubview:_chartView];
    
    /* 基本样式 */
    _chartView.delegate = self;//设置代理
    [_chartView setExtraOffsetsWithLeft:5.f top:5.f right:5.f bottom:5.f];//饼状图距离边缘的间隙
    _chartView.usePercentValuesEnabled = YES; //是否根据所提供的数据, 将显示数据转换为百分比格式
    _chartView.dragDecelerationEnabled = YES;//拖拽饼状图后是否有惯性效果
    
    
    /* 设置饼状图中间的文本 */
    _chartView.drawCenterTextEnabled = YES;//是否绘制中间的文本
    //    chartView.centerText = @"我是中心";//中间文本的文字，默认为灰色,设置中间文本的字体、颜色属性没有找到，可以用centerAttributedText代替
    NSString *text = @"";//我是中心
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:text];
    NSDictionary *dic = @{NSForegroundColorAttributeName : [UIColor cyanColor],NSFontAttributeName : [UIFont systemFontOfSize:20]};
    [attribute setAttributes:dic range:NSMakeRange(0, text.length)];
    _chartView.centerAttributedText = attribute;
    
    /* 设置饼状图中间的同心圆 */
    _chartView.drawHoleEnabled = YES; //饼状图是否是空心圆,设置为NO之后，半透明空心圆也消失咯
    _chartView.holeRadiusPercent = 0.35;//第一个空心圆半径占比
    _chartView.holeColor = [UIColor whiteColor];//第一个空心圆颜色
    _chartView.transparentCircleRadiusPercent = 0.38;//第二个空心圆半径占比，半径占比和第一个空心圆半径占比设置为一样的时候，只有一个圆咯
    _chartView.transparentCircleColor = UIColorFromHex(0xf1f1f1);//第二个空心圆颜色
    
    /* 设置饼状图扇形区块文本*/
    _chartView.drawEntryLabelsEnabled = YES; //是否显示扇形区块文本描述
    /*饼状图没有数据的显示*/
    _chartView.noDataText = @"暂无数据";//没有数据是显示的文字说明
    _chartView.noDataTextColor = UIColorFromHex(0x21B7EF);//没有数据时的文字颜色
    _chartView.noDataFont = [UIFont fontWithName:@"PingFangSC" size:15];//没有数据时的文字字体
    
    /* 设置饼状图图例样式 */
    _chartView.legend.enabled = NO;//显示饼状图图例解释说明
    _chartView.legend.maxSizePercent = 0.1;///图例在饼状图中的大小占比, 这会影响图例的宽高
    _chartView.legend.formToTextSpace = 10;//图示和文字的间隔
    _chartView.legend.font = [UIFont systemFontOfSize:10];//图例字体大小
    _chartView.legend.textColor = [UIColor blackColor];//图例字体颜色
    _chartView.legend.form = ChartLegendFormSquare;//图示样式: 方形、线条、圆形
    _chartView.legend.formSize = 5;//图示大小
    
    /* 饼状图名字 */
    _chartView.chartDescription.enabled = YES; //是否显示饼状图名字
    _chartView.chartDescription.text = @"我是饼状图名";//设置饼状图名字
    _chartView.chartDescription.textColor = [UIColor redColor];//设置饼状图名字颜色
    _chartView.chartDescription.textAlign = NSTextAlignmentLeft;//设置饼状图名字对齐方式
    _chartView.chartDescription.xOffset = 100;//饼状图名字x轴偏移
    
    
    /*饼状图交互*/
    _chartView.rotationEnabled = YES;//是否可以选择旋转
    _chartView.highlightPerTapEnabled = YES;//每个扇形区块是否可点击
 
    //    [chartView highlightValueWithX:0 dataSetIndex:0 dataIndex:0 ];//默认选中第0个数据
}

- (void)setPieData{
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (int i = 0; i < _keyArray.count; i++){
        /*
         value : 每块扇形的数值
         label : 每块扇形的文字描述
         icon  : 图片
         */
        //        [values addObject:[[PieChartDataEntry alloc]initWithValue:[_numbers[i] doubleValue] label:_names[i] icon:nil]];
        
        /*
         value : 每块扇形的数值
         label : 每块扇形的文字描述
         data  : tag值
         */
        [values addObject:[[PieChartDataEntry alloc] initWithValue:[_valueArray[i] doubleValue] label:_keyArray[i] data:[NSString stringWithFormat:@"%d",i]]];
    }
    
    /*
     图例
     values : values数组
     label : 图例的名字
     */
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithEntries:values label:@"图例说明"];//图例说明
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObject:UIColorFromHex(0x2697FE)];
    [colors addObject:UIColorFromHex(0xFF5006)];
    [colors addObject:UIColorFromHex(0x7ECBC3)];
    [colors addObject:UIColorFromHex(0xB1ACDA)];
    dataSet.colors = colors;
    
    dataSet.sliceSpace = 5; //相邻区块之间的间距
    dataSet.selectionShift = 8;//选中区块时, 放大的半径
    
    dataSet.drawIconsEnabled = NO; //扇形区块是否显示图片
    
    dataSet.entryLabelColor = [UIColor redColor];//每块扇形文字描述的颜色
    dataSet.entryLabelFont = [UIFont systemFontOfSize:15];//每块扇形的文字字体大小
    
    dataSet.drawValuesEnabled = YES;//是否显示每块扇形的数值
    dataSet.valueFont = [UIFont systemFontOfSize:11];//每块扇形数值的字体大小
    dataSet.valueColors = @[[UIColor redColor],[UIColor cyanColor],[UIColor greenColor],[UIColor grayColor]];//每块扇形数值的颜色,如果数值颜色要一样，就设置一个色就好了
    
    if(self.isValueLine) {
        /* 数值与区块之间的用于指示的折线样式*/
        dataSet.xValuePosition = PieChartValuePositionInsideSlice;//文字的位置
        dataSet.yValuePosition = PieChartValuePositionOutsideSlice;//数值的位置，只有在外面的时候，折线才有用
        dataSet.valueLinePart1OffsetPercentage = 0.8; //折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
        dataSet.valueLinePart1Length = 0.4;//折线中第一段长度占比
        dataSet.valueLinePart2Length = 0.6;//折线中第二段长度占比
        dataSet.valueLineWidth = 1;//折线的粗细
        dataSet.valueLineColor = [UIColor brownColor];//折线颜色
    }
    //设置每块扇形数值的格式
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    dataSet.valueFormatter = [[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter];
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    self.chartView.data = data;
    
    /* 设置饼状图动画 */
    self.chartView.rotationAngle = 0.0;//动画开始时的角度在0度
    [self.chartView animateWithXAxisDuration:2.0f easingOption:ChartEasingOptionEaseOutExpo];//设置动画效果
    
}

#pragma mark -- ChartViewDelegate

- (void)chartTranslated:(ChartViewBase *)chartView dX:(CGFloat)dX dY:(CGFloat)dY{
    NSLog(@"chartTranslated");
}

- (void)chartScaled:(ChartViewBase *)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY{
    NSLog(@"chartScaled");
}

- (void)chartValueNothingSelected:(ChartViewBase *)chartView{
    NSLog(@"chartValueNothingSelected");
}

- (void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight{
    NSLog(@"chartValueSelected");
    //当前选中饼状图的值
    NSLog(@"---chartValueSelected---value: x = %g,y = %g",entry.x,  entry.y);
    //当前选中饼状图的index
    NSLog(@"---chartValueSelected---value:第 %@ 个数据", entry.data);
}


@end
