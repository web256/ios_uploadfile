//
//  UploadFile.h
//  uploadfile
//
//  Created by 王德康 on 15/6/11.
//  Copyright (c) 2015年 王德康. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadFile : NSObject
// POST 其他变量
@property(nonatomic, strong) NSDictionary *postParams;
- (void)uploadFileWithURL:(NSURL *)url data:(NSData *)data;
@end
