//
//  AddViewController.m
//  记账本
//
//  Created by William on 2018/2/13.
//  Copyright © 2018年 William. All rights reserved.
//

#import "AddViewController.h"
#import "ProjectTableViewCell.h"
#import "CLAlertView.h"
#import "Product.h"
#import "BillList.h"
#import "DatePickerView.h"



@interface AddViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,CLAlertViewDelegate,ProjectTableViewCellDelegate>
@property (nonatomic,strong)DatePickerView *datePickerView;
@property (weak, nonatomic) IBOutlet UITextField *dateTextFied;
@property (weak, nonatomic) IBOutlet UIView *topView;
//确认日期设置按钮
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
//进货
@property (weak, nonatomic) IBOutlet UIButton *stockInSelected;
//出售
@property (nonatomic,assign)BillListRemarks remark;
@property (weak, nonatomic) IBOutlet UIButton *saleOutSelected;
@property (weak, nonatomic) IBOutlet UITableView *projectTableView;
//“空空如也”label
@property (weak, nonatomic) IBOutlet UILabel *emptyLabel;

//产品数组
@property (nonatomic,strong) NSMutableArray<Product *> *productArray;

@property (weak, nonatomic) IBOutlet UIView *buttonView;


@property (nonatomic,assign)double totalPrice;

//结算按钮
@property (weak, nonatomic) IBOutlet UIButton *countBtn;




@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加记录";
    //设置输入框的代理
    self.dateTextFied.delegate = self;
    self.projectTableView.delegate = self;
    self.projectTableView.dataSource = self;
    
    //隐藏分割线
    self.projectTableView.separatorStyle = NO;

    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];
    if(self.isEditStatement != YES){
        //让输入框显示当前日期
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
        //将时间转换成字符串
        NSDateFormatter  *dateFormat=[[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"YYYY年MM月dd日"];
        self.dateStr = [dateFormat stringFromDate:date];
        
    }
    self.dateTextFied.text = self.dateStr;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(returnBack)];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



+(AddViewController *)editViewWithDate :(NSString *)date billListRemark :(BillListRemarks)remark productArray :(NSMutableArray *)array{
    AddViewController *addVC = [[AddViewController alloc] init];
    //日期
    addVC.dateStr = date;
    //备注选择状态
    addVC.stockInSelected.selected = (remark == BillListRemarksStockIn);
    addVC.saleOutSelected.selected = (remark == BillListRemarksSellOut);
    //product数组
    addVC.productArray = array;
    addVC.isEditStatement = YES;
    
    return addVC;
}




//显示日期选择器
-(void)datePickerDisplay{
    if(self.datePickerView == nil){
        //创建日期选择器
        self.datePickerView = [[[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:nil options:nil] firstObject];
        self.datePickerView.frame = CGRectMake(0, ScreenH, ScreenW, 200);
        self.datePickerView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        //设置本地化支持的语言（在此是中文)
        self.datePickerView.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        //显示方式是只显示年月日
        self.datePickerView.datePicker.datePickerMode = UIDatePickerModeDate;
        //设置按钮监听
        [self.datePickerView.cancel addTarget:self action:@selector(cancelDateSelect) forControlEvents:UIControlEventTouchUpInside];
        [self.datePickerView.certain addTarget:self action:@selector(certainDateSelect) forControlEvents:UIControlEventTouchUpInside];
        
        
//        //毛玻璃特效
//        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
//        effectView.frame = self.datePickerView.frame;
//        [self.datePickerView addSubview:effectView];
    }

    
    //设置显示动画
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.datePickerView.frame;
        frame.origin.y = ScreenH - 200;
        self.datePickerView.frame = frame;
    }];

    
    
    [self.view addSubview:self.datePickerView];
    
    

    
}


-(void)returnBack{
    if(self.isEditStatement == YES){
        [self countPrice:self.countBtn];
    }
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer

{
    [self.view endEditing:YES];
}



//懒加载productArray
-(NSMutableArray *)productArray{
    if(_productArray == nil){
        _productArray = [NSMutableArray array];
    }
    return _productArray;
}

#pragma-mark valueChange Method

//选择备注按钮
//设置按钮按下的效果
- (IBAction)touchDown:(UIButton *)sender {
    [sender setBackgroundImage:[UIImage imageNamed:@"TouchDown.png"] forState:UIControlStateNormal];
}
- (IBAction)touchUp:(UIButton *)sender {
    [sender setBackgroundImage:[UIImage imageNamed:@"Touched.png"] forState:UIControlStateNormal];
    //由于按钮只能有一个是选中状态  故需要做判断
    if (sender == self.stockInSelected) {
        [self.saleOutSelected setBackgroundImage:[UIImage imageNamed:@"UnTouch.png"] forState:UIControlStateNormal];
        self.remark = BillListRemarksStockIn;
    }
    else if(sender == self.saleOutSelected)
    {
        [self.stockInSelected setBackgroundImage:[UIImage imageNamed:@"UnTouch.png"] forState:UIControlStateNormal];
        self.remark = BillListRemarksSellOut;
    }
}



#pragma-mark UITextFiled Delegate Method
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{


    //收起键盘
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    //显示
    [self datePickerDisplay];
    return NO;
}

//选择时间的view
//确认按钮
-(void)certainDateSelect{
//    获得时间对象
        NSDate *date = self.datePickerView.datePicker.date;
        //将时间转换成字符串
        NSDateFormatter  *dateFormat=[[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"YYYY年MM月dd日"];
        self.dateStr = [dateFormat stringFromDate:date];
        self.dateTextFied.text = self.dateStr;
//    设置离开动画
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.datePickerView.frame;
        frame.origin.y = ScreenH + 200;
        self.datePickerView.frame = frame;
    }];
    
    
}
//取消按钮
-(void)cancelDateSelect{
    
    
    
    //设置离开动画
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.datePickerView.frame;
        frame.origin.y = ScreenH + 200;
        self.datePickerView.frame = frame;
    }];
    
}


#pragma-mark buttonClickResponder

- (IBAction)addProject:(id)sender {
    //结束输入
    [self.view endEditing:YES];
    //增加一条项目
    self.emptyLabel.hidden = YES;
    //创建对象
    //创建产品对象保存
    Product *product = [[Product alloc] init];
    [self.productArray addObject:product];
    //刷新数据
    [self.projectTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.productArray.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
}

//结算并保存
- (IBAction)countPrice:(UIButton *)sender {
    //结束全局的输入
    [self.view endEditing:YES];
    //计算总价
    __block double total = 0;

        [self.productArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Product *product = (Product *)obj;
            total += product.price;
        }];
    
    self.totalPrice = total;
    
    //创建BillList对象
    BillList *list = [BillList billListWithDate:self.dateStr billListRemarks:self.remark products:[NSArray arrayWithArray:self.productArray] andTotlePrice:self.totalPrice];
    [self.delegate addViewController:self sendBillList:list];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}



    
//根据title动态改变button的宽度
//-(void)buttonChangeWidthWithprice :(double)price{
//    NSString *title = [NSString stringWithFormat:@"总金额 : %.2lf 元",price];
//    [self.countBtn setTitle:title forState:UIControlStateNormal];
//
//    //求取宽度
//    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:self.countBtn.titleLabel.font.fontName size:self.countBtn.titleLabel.font.pointSize]}];
//
//    //    titleSize.height = 40;
//    titleSize.width += 20;
//
//
//    //改变宽度
//    [UIView animateWithDuration:0.3 animations:^{
//        self.countBtn.frame = CGRectMake((self.buttonView.frame.size.width - titleSize.width) / 2, (self.buttonView.frame.size.height - self.countBtn.frame.size.height) / 2, titleSize.width, self.countBtn.frame.size.height);
//    }];
//}

    
    

#pragma-mark UITableViewDelegate Method
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.productArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ProductCellID";
//    ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    ProjectTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if(cell == nil){
        cell = [ProjectTableViewCell projectTableViewCellWithTableView:tableView identifier:identifier];
    }
    
    cell.delegate = self;
    cell.indexAtTableView = indexPath.row;
    Product *p = [self.productArray objectAtIndex:indexPath.row];
            if(p.name != nil){
                cell.addNameImg.hidden = YES;
                [cell.productName setTitle:p.name forState:UIControlStateNormal];
            }
            if(p.unit != nil){
                cell.addUnitImg.hidden = YES;
                [cell.unitName setTitle:p.unit forState:UIControlStateNormal];
            }
            if(p.number != 0){
                cell.number.text = [NSString stringWithFormat:@"%ld",p.number];
                
            }
            if(p.price != 0){
                cell.price.text = [NSString stringWithFormat:@"%.2lf",p.price];
            }


    tableView.rowHeight = 120;
    
    //添加轻扫手势
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe)];
    gesture.direction = UISwipeGestureRecognizerDirectionRight;
    [tableView addGestureRecognizer:gesture];
    
    
    return cell;
}


//轻扫手势
-(void)rightSwipe{
    [self.projectTableView setEditing:NO animated:YES];
}




//左滑删除
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    //删除
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

        
        //移除记录
        [self.productArray removeObjectAtIndex:indexPath.row];
    
        //局部刷新删除操作
        [self.projectTableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationMiddle];
        
        //此处必须得再刷新一次否则会出现cell错乱的问题
        [self.projectTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
        
        [self.projectTableView setEditing:NO animated:YES];
        
        
        
        
        //显示“空空如也”label
        if(self.productArray.count == 0){
            self.emptyLabel.hidden = NO;
        }
    }];
    return @[deleteRowAction];
    
    
}


#pragma-mark ProjectTableViewCellDelegate Method


-(void)projectTableViewCellAnnounceDelegateScroll:(ProjectTableViewCell *)cell{
    
    
    if(self.productArray.count >= 2){
        if(self.projectTableView.tableFooterView == nil){
            self.projectTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH / 5)];
        }
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:cell.indexAtTableView inSection:0];
        //滑到指定位置
        [self.projectTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    
}

#pragma-mark sendValueMethod
//number改变
-(void)ProjectTableViewCellNumberValueChanged:(NSNumber *)number inTableViewCell:(ProjectTableViewCell *)cell{
    NSInteger index = cell.indexAtTableView;
    Product *p = [self.productArray objectAtIndex:index];
    p.number = number.integerValue;
    [self.productArray replaceObjectAtIndex:index withObject:p];
//    NSLog(@"\n\n\n%@\n\n\n\n",number);

}
//price改变
-(void)ProjectTableViewCellPriceValueChanged:(NSNumber *)price inTableViewCell:(ProjectTableViewCell *)cell{
    NSInteger index = cell.indexAtTableView;
    Product *p = [self.productArray objectAtIndex:index];
    p.price = price.doubleValue;
    
    [self.productArray replaceObjectAtIndex:index withObject:p];
}
//name改变
-(void)ProjectTableViewCellProductNameValueChanged:(NSString *)name inTableViewCell:(ProjectTableViewCell *)cell{
    NSInteger index = cell.indexAtTableView;
    //设置按钮title
    cell.addNameImg.hidden = YES;
    [cell.productName setTitle:name forState:UIControlStateNormal];
    //更新数组中的数据
    Product *p = [self.productArray objectAtIndex:index];
    p.name = name;
    [self.productArray replaceObjectAtIndex:index withObject:p];
}
//unit改变
-(void)ProjectTableViewCellUnitNameValueChanged:(NSString *)name inTableViewCell:(ProjectTableViewCell *)cell{
    NSInteger index = cell.indexAtTableView;
    //设置按钮title
    cell.addUnitImg.hidden = YES;
    [cell.unitName setTitle:name forState:UIControlStateNormal];
    //更新数组中的数据
    Product *p = [self.productArray objectAtIndex:index];
    p.unit = name;
    [self.productArray replaceObjectAtIndex:index withObject:p];
}

@end
