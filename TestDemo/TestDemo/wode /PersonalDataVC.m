//
//  PersonalDataVC.m
//  TestDemo
//
//  Created by 曹进龙 on 2017/8/24.
//  Copyright © 2017年 曹进龙. All rights reserved.
//

#import "PersonalDataVC.h"
#import "AreaModel.h"
#import "CityModel.h"
#import "ProvinceModel.h"


@interface PersonalDataVC ()<UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate,UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    NSString *judeString;
    
    UIView *bgView;
    UIToolbar   *_pickerDateToolbar;
    UIPickerView *_pickerView;
    NSDictionary *_areaDic;
    NSMutableArray *_provinceArr;
    
    NSString *areaString;
    
    //日期选择
    UIDatePicker *datePicker;
    NSString *dataString;
    
    NSString *sex;
    NSArray *array2;
    
    UIImageView *iconimage;
}
@property(nonatomic,copy)UIImageView *pickerImageView;


@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PersonalDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor  whiteColor];
    self.title = @"个人资料";

    array2 = @[@"男", @"女"];

    [self loading];
    [self.view addSubview:self.tableView];
    
}
-(UITableView *)tableView
{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeiveWidth, kDeiveHeight) style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellIDss";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
    }
    if (indexPath.section == 0) {
        NSArray *array = @[@"个人头像", @"昵称", @"生日", @"性别", @"地区"];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", array[indexPath.row]];
        if (indexPath.row == 0) {
            iconimage = [[UIImageView alloc] initWithFrame:CGRectMake(kDeiveWidth -60, 7, 30, 30)];
            iconimage.layer.cornerRadius = 15;
            iconimage.layer.masksToBounds = YES;
//            iconimage.backgroundColor = [UIColor blackColor];
            iconimage.image = _pickerImageView.image;
            [cell addSubview:iconimage];
        }else if (indexPath.row == 1){
        
        
        }else if (indexPath.row == 2){
            
            cell.detailTextLabel.text = dataString;
        }else if (indexPath.row == 3){
            
            cell.detailTextLabel.text = sex;
        }else if (indexPath.row == 4){
            
            cell.detailTextLabel.text = areaString;
            
        }
        
    }else{
        cell.textLabel.text = @"收货地址";
        cell.detailTextLabel.text = @"新建/修改";
    
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            _pickerImageView = iconimage;
            
            UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册选择",@"相机拍摄", nil];
            [sheet showInView:self.view];
            
            [self.view endEditing:YES];

        }
        if (indexPath.row == 2) {
             [self dataPickerView];
        }else if (indexPath.row == 3){
            judeString = @"性别";
            [self uiConfig];

        }else if (indexPath.row == 4) {
            judeString = @"地区";
            [self uiConfig];
            
        }
    }
    
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSLog(@"buttonIndex=%lu",(long)buttonIndex);
    if (buttonIndex == 0)//相册选择
    {
        UIImagePickerController *pickView = [[UIImagePickerController alloc]init];
        pickView.delegate =self;
        
        //        pickView.allowsEditing = YES;//设置可编辑
        
        [self presentViewController:pickView animated:YES completion:nil];
    }
    else if(buttonIndex == 1)//相机拍摄
    {
        
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            
            UIImagePickerController *pickView = [[UIImagePickerController alloc]init];
            pickView.sourceType =UIImagePickerControllerSourceTypeCamera;
            pickView.delegate =self;
            
            [self presentViewController:pickView animated:YES completion:nil];
            
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"相机不可用" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [alertView show];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //图片压缩，因为原图都是很大的，不必要传原图
    UIImage *scaleImage = [self scaleImage:originImage toScale:0.1];
    
    _pickerImageView.image=scaleImage;
    
    
    NSData *data;
    //以下这两步都是比较耗时的操作，最好开一个HUD提示用户，这样体验会好些，不至于阻塞界面
    if (UIImagePNGRepresentation(scaleImage) == nil) {
        //将图片转换为JPG格式的二进制数据
        data = UIImageJPEGRepresentation(scaleImage, 0.5);
    } else {
        //将图片转换为PNG格式的二进制数据
        data = UIImagePNGRepresentation(scaleImage);
    }
    
    // 把头像图片存到本地
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"1111.jpg"]];   // 保存文件的名称
    //    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    [data writeToFile:filePath atomically:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    [self.tableView reloadData];
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark- 缩放图片
-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


#pragma mark -- 生日
-(void)dataPickerView{
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    [self.view addSubview:bgView];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 216, [UIScreen mainScreen].bounds.size.width, 216)];
    datePicker.datePickerMode = UIDatePickerModeDate;//模式选择
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
    datePicker.locale = locale;
    
    [bgView addSubview:datePicker];
    
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
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(toolBardataDoneClick)];
    [barItems addObject:doneBtn];
    [_pickerDateToolbar setItems:barItems animated:YES];

    
}
- (void)toolBardataDoneClick{
    NSDate *pickerData1 = [datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];//设置输出的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dataString = [dateFormatter stringFromDate:pickerData1];
    
    [self.tableView reloadData];
    
    [bgView removeFromSuperview];
    
}

- (void)loading
{
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        [self prepareData];
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            //            [self uiConfig];
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
    [self.view addSubview:bgView];

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

    if ([judeString isEqualToString:@"性别"]) {
        if (sex.length == 0) {
            sex = @"男";
        }
  
        [self.tableView reloadData];

    }else{
        if (areaString.length == 0) {
            ProvinceModel *model = _provinceArr[0];
            CityModel *cityModel = model.citiesArr[0];
            NSString *str = [cityModel.code description];
            NSArray *arr = _areaDic[str];
            AreaModel *areaModel = [[AreaModel alloc]init];
            [areaModel setValuesForKeysWithDictionary:arr[0]];
            
            if ([model.name isEqualToString:cityModel.name]) {
                areaString = [NSString stringWithFormat:@"%@  %@",cityModel.name,areaModel.name];
            }else{
                areaString = [NSString stringWithFormat:@"%@  %@  %@",model.name,cityModel.name,areaModel.name];
            }

        }
        
        [self.tableView reloadData];

    }
    
    
    [bgView removeFromSuperview];
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    if ([judeString isEqualToString:@"性别"]) {
        return 1;
    }
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if ([judeString isEqualToString:@"性别"]) {

        return 2;
    }else{
        
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
    
   
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    if ([judeString isEqualToString:@"性别"]) {
        return array2[row];
        
    }else{
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
    
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if ([judeString isEqualToString:@"性别"]) {
        sex = array2[row];
    }else{
    
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
        
        if ([model.name isEqualToString:cityModel.name]) {
            areaString = [NSString stringWithFormat:@"%@  %@",cityModel.name,areaModel.name];
        }else{
            areaString = [NSString stringWithFormat:@"%@  %@  %@",model.name,cityModel.name,areaModel.name];
        }
        
    }
    

   
    
    //    NSLog(@"省:%@ 市:%@ 区:%@",model.name,cityModel.name,areaModel.name);
    
    
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
