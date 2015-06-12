//
//  UploadFile.m
//  uploadfile
//
//  Created by 王德康 on 15/6/11.
//  Copyright (c) 2015年 王德康. All rights reserved.
//


#import "UploadFile.h"

@interface UploadFile()
// 文件内容长度
@property(nonatomic, copy) NSString *contentLenth;

// 文件类型
@property(nonatomic, copy) NSString *contentType;

// 上传文件的Name  PHP接收的name
@property(nonatomic, copy) NSString *uploadFieldName;

// 文件MIME类型
@property(nonatomic, copy) NSString *mimeType;

// 分隔符类型
@property(nonatomic, copy) NSString *boundaryStr;

// 本次上传的标示符
@property(nonatomic, copy) NSString *randomIDStr;

@end

@implementation UploadFile

// 设置默认MIME类型
- (NSString *)mimeType {
    if (_mimeType == nil) {
        _mimeType = @"image/png";
    }
    return _mimeType;
}

// 设置默认分隔符号
- (NSString *)boundaryStr {
    if (_boundaryStr == nil) {
        _boundaryStr = @"--";
    }
    return _boundaryStr;
}

// 设置默认表单name
- (NSString *)uploadFieldName {
    if (_uploadFieldName == nil) {
        _uploadFieldName = @"uploadfile";
    }
    
    return _uploadFieldName;
}

// 上传标示符号
- (NSString *)randomIDStr {
    if (_randomIDStr == nil) {
        _randomIDStr = @"alltosun";
    }
    return _randomIDStr;
}


#pragma mark - 私有方法
/**
 *
 * 生成http头部分
 * @params NSString mimeType 类型
 * @params NSString uploadFile 上传文件名
 *
 */
- (NSString *)topStringWithMimeType:(NSString *)mimeType uploadFile:(NSString *)uploadFile
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\n", self.boundaryStr, self.randomIDStr];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\n", self.uploadFieldName, uploadFile];
    [strM appendFormat:@"Content-Type: %@\n\n", mimeType];
    
    NSLog(@"%@", strM);
    return strM;
}

/**
 *  生成普通POST变量头部
 */
- (NSString *)buildPostParams:(NSString *)name content:(NSString *)content {
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"\n%@%@\n", self.boundaryStr, self.randomIDStr];
    [strM appendString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\n\n", name]];
    [strM appendString:[NSString stringWithFormat:@"%@\n", content]];
    return strM;
}

/**
 *  组合所有POST字符串的其他变量
 */
- (NSString *)buildPostParamsAll {
    
    NSMutableString *strM = [NSMutableString string];
    NSArray *allKey = [self.postParams allKeys];
    for (NSString *key  in allKey) {
        
        NSString *content = [self.postParams objectForKey:key];
        
        [strM appendFormat:@"\n%@%@\n", self.boundaryStr, self.randomIDStr];
        [strM appendString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\n\n", key]];
        [strM appendString:[NSString stringWithFormat:@"%@\n", content]];
    }
    
    return strM;
}

/**
 *  上传指定二进制数据
 *  @params NSURL 提交的URL
 *  @params NSData 提交的数据
 */
- (void)uploadFileWithURL:(NSURL *)url data:(NSData *)data {
    
    
    NSMutableString *str = [NSMutableString string];
    
    // 获取请求头部分，并设置MIME类型和文件名
    NSString *headTopStr = [self topStringWithMimeType:self.mimeType uploadFile:@"头像1.png"];
    // 组合NSData数据
    NSMutableData *dataM = [NSMutableData data];
    [dataM appendData:[headTopStr dataUsingEncoding:NSUTF8StringEncoding]];
    
     // 组合二进制
    [dataM appendData:data];
    
    [str appendString:headTopStr];

    
    // 获取其变量
    NSString *otherStr = [self buildPostParamsAll];
    if (otherStr.length) {
        [dataM appendData:[otherStr dataUsingEncoding:NSUTF8StringEncoding]];
    }

    
    // 获取请求尾部的规则字符
    NSString *headBottomStr = [self bottomString];
    
    [str appendString:headBottomStr];

    [dataM appendData:[headBottomStr dataUsingEncoding:NSUTF8StringEncoding]];

    
    NSLog(@"%@", str);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:2.0];
    
    // 设置请求头，文件长度
    NSString *dataLength = [NSString stringWithFormat:@"%ld", (long)dataM.length];
    [request setValue:dataLength forHTTPHeaderField:@"Content-Length"];
    
    // 设置请求头文件类型
    NSString *strContentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", self.randomIDStr];
    [request setValue:strContentType forHTTPHeaderField:@"Content-Type"];
    
    // 设置请求体
    request.HTTPBody = dataM;
    
    request.HTTPMethod = @"POST";
    
    // 考虑到多线程
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString *responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", responseStr);
    }];
    
}

/**
 * 生成http尾部部分
 */
- (NSString *)bottomString
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\n", self.boundaryStr, self.randomIDStr];
    [strM appendString:@"Content-Disposition: form-data; name=\"submit\"\n\n"];
    [strM appendString:@"Submit\n"];
    [strM appendFormat:@"%@%@--\n", self.boundaryStr, self.randomIDStr];
    
    NSLog(@"%@", strM);
    return [strM copy];
}

@end
