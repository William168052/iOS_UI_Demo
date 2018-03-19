//
//  ViewController.m
//  iOS多线程-多图下载Demo
//
//  Created by William on 2018/3/18.
//  Copyright © 2018年 William. All rights reserved.
//

#import "ViewController.h"
#import "App.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSMutableArray *dataArray;
//缓存图片
@property (nonatomic,strong)NSMutableDictionary *images;

//操作缓存
@property (nonatomic,strong)NSMutableDictionary *operations;

//下载队列
@property (nonatomic,strong)NSOperationQueue *queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view, typically from a nib.
}

//接收到内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //移除缓存中所有图片
    [self.images removeAllObjects];
    
    //停止操作队列中所有下载操作
    [self.queue cancelAllOperations];
}

-(NSOperationQueue *)queue{
    if(!_queue){
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 5;
    }
    return _queue;
}

//懒加载图片
-(NSMutableArray *)dataArray{
    if(!_dataArray){
        NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"apps" ofType:@"plist"]];
        
        //字典数组->模型数组
        NSMutableArray *muArr = [NSMutableArray array];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dict = (NSDictionary *)obj;
            App *a = [App appWithDictionary:dict];
            [muArr addObject:a];
        }];
        
        _dataArray = muArr;
        
    }
    return _dataArray;
}

-(NSMutableDictionary *)images{
    if(!_images){
        _images = [NSMutableDictionary dictionary];
    }
    return _images;
}

-(NSMutableDictionary *)operations{
    if(!_operations){
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"app";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UITableViewCell alloc] init];
    }
    
    App *a = [self.dataArray objectAtIndex:indexPath.row];
    
    //设置标题
    cell.textLabel.text = a.name;
    cell.detailTextLabel.text = a.download;
    //判断缓存中是否有图片如果没有先去检查磁盘缓存，如果有磁盘缓存则保存一份到内存并设置
    UIImage *img = [self.images objectForKey:a.icon];
    if(img){
        cell.imageView.image = img;
    }else{
        //获得文件夹路径
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        //获得图片路径（不带‘/’）(最后一个文件节点)
        NSString *fileName = [a.icon lastPathComponent];
        //拼接图片全路径
        NSString *filePath = [caches stringByAppendingPathComponent:fileName];
        
        
        //检查磁盘缓存
        NSData *imgData = [NSData dataWithContentsOfFile:filePath];
        imgData = nil;
        if(imgData){
            //如果有缓存
            UIImage *image = [UIImage imageWithData:imgData];
            cell.imageView.image = image;
            
            //保存到缓存
            [self.images setObject:image forKey:a.icon];
        }else{
            //如果没有
            
            //设置占位图片
            cell.imageView.image = [UIImage imageNamed:@"placeHolder_img"];
            
            //检查该图片是否正在下载，如果是则什么都不做
            
            if([self.operations objectForKey:a.icon] == nil){
                //下载图片（开子线程）
                self.queue = [[NSOperationQueue alloc] init];
                NSBlockOperation *opr = [NSBlockOperation blockOperationWithBlock:^{
                    //获取url
                    NSURL *url = [NSURL URLWithString:a.icon];
                    
                    //下载二进制数据
                    NSData *data = [NSData dataWithContentsOfURL:url];
                    //转成图片
                    UIImage *image = [UIImage imageWithData:data];
                    
                    //容错处理
                    if(image){
                        //将操作cong'huan'cun移除
                        [self.operations removeObjectForKey:a.icon];
                        return;
                    }
                    
                    //模拟网速慢的情况
                    [NSThread sleepForTimeInterval:2.0];
                    
                    //保存图片到内存缓存（防止多次重复下载）
                    [self.images setObject:image forKey:a.icon];
                    
                    //将图片的二进制数据写到沙盒
                    [data writeToFile:filePath atomically:YES];
                    
                    //刷新UI（主线程）
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    //                    cell.imageView.image = image;
                    //主动刷新对应的行
                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }];
                    
                    //移除下载图片操作
                    [self.operations removeObjectForKey:a.icon];
                    
                    
                    
                }];
                
                //添加操作到缓存
                [self.operations setObject:opr forKey:a.icon];
                
                //添加任务到队列
                [self.queue addOperation:opr];
            }
            
            
            
        }
        
    }
    
    
    
    tableView.rowHeight = 80;
    
    
    
    
    
    return cell;
}





@end
