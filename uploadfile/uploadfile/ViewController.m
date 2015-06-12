//
//  ViewController.m
//  uploadfile
//
//  Created by 王德康 on 15/6/11.
//  Copyright (c) 2015年 王德康. All rights reserved.
//

#import "ViewController.h"
#import "UploadFile.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UploadFile *uploadFile = [[UploadFile alloc] init];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"头像1.png" ofType:nil];
    
    NSDictionary *params = @{@"_name":@"wangdk", @"tel":@"18618155653"};
    uploadFile.postParams = params;
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    [uploadFile uploadFileWithURL:[NSURL URLWithString:@"http://credit_bank.alltosun.net/user/test/upload_file"] data:data];
    

}


@end
