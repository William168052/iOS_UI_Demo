//
//  DisplayViewController.m
//  iOS网络通信Demo
//
//  Created by William on 2018/1/26.
//  Copyright © 2018年 William. All rights reserved.
//

#import "DisplayViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#define baseURL @"http://120.25.226.186:32812"
@interface DisplayViewController ()

@property (nonatomic,strong) NSArray *videos;

@end

@implementation DisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1 发送网络请求
    //1.1 URL
    NSURL *url = [[NSURL alloc] initWithString:@"http://120.25.226.186:32812/video?type=JSON"];
    
    //2 创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3 发送异步请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        //解析数据
        if(connectionError){
            return;
        }
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:0];
        
        //将数据保存
        self.videos = dataDict[@"videos"];
        
        //刷新UI
        [self.tableView reloadData];
        
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifer = @"videoID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    //1 设置数据
    NSDictionary *dict = self.videos[indexPath.row];
    //1.1 设置标题
    cell.textLabel.text = dict[@"name"];
    //1.2 设置子标题
    cell.detailTextLabel.text = [NSString stringWithFormat:@"播放时间: %@ s",dict[@"length"]];
    //1.3 设置图片
    NSURL *imgURL = [NSURL URLWithString:[baseURL stringByAppendingPathComponent:dict[@"image"]]];
//    NSLog(@"%@",imgURL);
    NSData *imgData = [NSData dataWithContentsOfURL:imgURL];
    cell.imageView.image = [UIImage imageWithData:imgData];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //拿到数据
    NSDictionary *dict = self.videos[indexPath.row];
    //拼接数据
    NSURL *imgURL = [NSURL URLWithString:[baseURL stringByAppendingPathComponent:dict[@"url"]]];
    //创建播放器控制器
    MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc] initWithContentURL:imgURL];
    //弹出控制器
    [self presentViewController:vc animated:YES completion:nil];
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
