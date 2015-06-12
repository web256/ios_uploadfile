# ios_uploadfile
iOS 上传二进制图片
POST二进制上传只要按照HTTP的格式拼好数据就OK

1、请求头信息，必须传
Content-Type: multipart/form-data; boundary=alltosun
Content-Length: 88685

2、标示符，类型，上传数据类型和表单名字 必须传
--alltosun
Content-Disposition: form-data; name="uploadfile"; filename="头像1.png"
Content-Type: image/png

3、图片数据二进制不可读
�PNG

4、二进制结束符
--alltosun
5、字符串表单数据，相当于input name，这里可以传递其他参数，比如：上传一张图片，顺便传用户token
Content-Disposition: form-data; name="_submit1"

6、input值
111Submit1
--alltosun
Content-Disposition: form-data; name="submit"

Submit
--alltosun--

总结：拼数据最难搞的是各种空格，换行，必须拼成一模一样的。多一个字节，少一个字节都不行。
