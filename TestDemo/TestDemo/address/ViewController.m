//
//  ViewController.m
//  TestDemo
//
//  Created by 曹进龙 on 2017/8/21.
//  Copyright © 2017年 曹进龙. All rights reserved.
//

#import "ViewController.h"

#import "AddressTableViewCell.h"
#import "AreaModel.h"
#import "CityModel.h"
#import "ProvinceModel.h"
#import "DefaultAddressCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate,UIPickerViewDataSource>{
    
    UIView *bgView;
    UIToolbar   *_pickerDateToolbar;
    UIPickerView *_pickerView;
    NSDictionary *_areaDic;
    NSMutableArray *_provinceArr;
    
    NSString *areaString;
    
    
}
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    areaString = @"";
    
    [self loading];

    
    [self.view addSubview:self.tableView];

    
}
- (void)loading
{
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        [self prepareData];
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            [self uiConfig];
        });
        
    });
}
- (void)prepareData
{
    //area.plist是字典
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    _areaDic = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    
    //city.plist是数组
    NSString *plist = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSMutableArray *dataCity = [[NSMutableArray alloc] initWithContentsOfFile:plist];
    
    _provinceArr = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in dataCity) {
        ProvinceModel *model  = [[ProvinceModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        model.citiesArr = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in model.cities) {
            CityModel *cityModel = [[CityModel alloc]init];
            [cityModel setValuesForKeysWithDictionary:dic];
            [model.citiesArr addObject:cityModel];
        }
        [_provinceArr addObject:model];
    }
    
}
- (void)uiConfig
{
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];

    //picker view 有默认高度216
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 216, [UIScreen mainScreen].bounds.size.width, 216)];
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [_pickerView selectRow:0 inComponent:0 animated:YES];
    [bgView addSubview:_pickerView];
    
    _pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,  [UIScreen mainScreen].bounds.size.height - 216  - 44,  [UIScreen mainScreen].bounds.size.width, 44)];
    _pickerDateToolbar.barStyle = UIBarStyleDefault;
    _pickerDateToolbar.backgroundColor = [UIColor whiteColor];
    [_pickerDateToolbar sizeToFit];
    [bgView addSubview:_pickerDateToolbar];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(toolBarCanelClick)];
    [barItems addObject:cancelBtn];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(toolBarDoneClick)];
    [barItems addObject:doneBtn];
    [_pickerDateToolbar setItems:barItems animated:YES];
    
    
}
- (void) toolBarCanelClick{
    
    [bgView removeFromSuperview];

    
}
- (void) toolBarDoneClick{
    
    NSLog(@"完成 ~~~ %@" ,areaString);
    
    [bgView removeFromSuperview];

    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (0 == component){
        
        return _provinceArr.count;
        
    }else if(1==component){
        
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        ProvinceModel *model =   _provinceArr[rowProvince];
        return model.citiesArr.count;
        
    }else{
        
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSInteger rowCity = [pickerView selectedRowInComponent:1];
        ProvinceModel *model = _provinceArr[rowProvince];
        CityModel *cityModel = model.citiesArr[rowCity];
        NSString *str = [cityModel.code description];
        NSArray *arr =  _areaDic[str];
        
        return arr.count;
    
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (0 == component){
        ProvinceModel *model = _provinceArr[row];
        return model.name;
    }
    else if(1==component){
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        ProvinceModel *model = _provinceArr[rowProvince];
        CityModel *cityModel = model.citiesArr[row];
        return cityModel.name;
    }else{
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSInteger rowCity = [pickerView selectedRowInComponent:1];
        ProvinceModel *model = _provinceArr[rowProvince];
        CityModel *cityModel = model.citiesArr[rowCity];
        NSString *str = [cityModel.code description];
        NSArray *arr = _areaDic[str];
        AreaModel *areaModel = [[AreaModel alloc]init];
        [areaModel setValuesForKeysWithDictionary:arr[row]];
        return areaModel.name;
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if(0 == component){
        
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
    
    }
    if(1 == component){
        [pickerView reloadComponent:2];
    }
    
    NSInteger selectOne = [pickerView selectedRowInComponent:0];
    NSInteger selectTwo = [pickerView selectedRowInComponent:1];
    NSInteger selectThree = [pickerView selectedRowInComponent:2];
    
    ProvinceModel *model = _provinceArr[selectOne];
    CityModel *cityModel = model.citiesArr[selectTwo];
    NSString *str = [cityModel.code description];
    NSArray *arr = _areaDic[str];
    AreaModel *areaModel = [[AreaModel alloc]init];
    [areaModel setValuesForKeysWithDictionary:arr[selectThree]];
    areaString = [NSString stringWithFormat:@"%@  %@  %@",model.name,cityModel.name,areaModel.name];
//    NSLog(@"省:%@ 市:%@ 区:%@",model.name,cityModel.name,areaModel.name);
    
    
    [self.tableView reloadData];
}

#pragma mark -- tableView
-(UITableView *)tableView
{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStyleGrouped];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.tableFooterView = [[UIView alloc] init];
    }
    
    return _tableView;

}

#pragma mark -- UITableViewDelegate, UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
    
        return 6;
    
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 5) {
            return 80;
        }
    }
    
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
//        if (indexPath.row == 3) {
//            
//            
//        }else{
            NSString *cellID = @"AddressTableViewCell";
            AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[AddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if (indexPath.row == 0) {
                cell.textField.placeholder = @"收件人姓名";
            }else if (indexPath.row == 1){
                cell.textField.placeholder = @"手机号";
            }else if (indexPath.row == 2){
                cell.textField.placeholder = @"身份证（可选填，购买报税商品必填）";
            }else if (indexPath.row == 3){
                cell.textField.placeholder = @"省 市  区";
                cell.textField.text = areaString;
                cell.textField.enabled = NO;
            }else if (indexPath.row == 4){
                cell.textField.placeholder = @"乡/镇/街道";
            }else if (indexPath.row == 5){
                cell.textField.placeholder = @"详细地址（无需重复填写省市区）";
            }
            
        
            return cell;
//        }
    }
    
    
    NSString *cellID = @"DefaultAddressCell";
    DefaultAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[DefaultAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.aSwitch addTarget:self action:@selector(switched:) forControlEvents:UIControlEventValueChanged];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 3) {
            [self uiConfig];
            
            [self.view addSubview:bgView];
        }
    }
   
    

}
- (void) switched:(UISwitch *)sender{
    
    NSLog(@"开关 ~~~  %@", sender.on?@"YES":@"NO");

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
