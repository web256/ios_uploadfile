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

CgBIP ,�wf
IHDR���X��(iTXtXML:com.adobe.xmp<x:xmpmeta xmlns:x="adobe:ns:meta/" x:xmptk="XMP Core 5.1.2">
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about=""
xmlns:xmp="http://ns.adobe.com/xap/1.0/">
<xmp:ModifyDate>2013-07-12T11:07:78</xmp:ModifyDate>
<xmp:CreatorTool>Pixelmator 2.2</xmp:CreatorTool>
</rdf:Description>
<rdf:Description rdf:about=""
xmlns:tiff="http://ns.adobe.com/tiff/1.0/">
<tiff:Orientation>1</tiff:Orientation>
<tiff:YResolution>72</tiff:YResolution>
<tiff:Compression>5</tiff:Compression>
<tiff:ResolutionUnit>1</tiff:ResolutionUnit>
<tiff:XResolution>72</tiff:XResolution>
</rdf:Description>
<rdf:Description rdf:about=""
xmlns:exif="http://ns.adobe.com/exif/1.0/">
<exif:PixelXDimension>200</exif:PixelXDimension>
<exif:ColorSpace>65535</exif:ColorSpace>
<exif:PixelYDimension>200</exif:PixelYDimension>
</rdf:Description>
</rdf:RDF>
</x:xmpmeta>
,�=2	pHYs��iDOTd(dd�E��s��IDAT��e|d�u���bKj3S��V���=3���Bv�p�ĐĎ'fL���f�i5��*�>/νWW�՝��#�$ݺUu�ٴ�ښ��(�K1&�L,%_�3���b���1�Z�ra9ƅ�5..F]�1���R�ɕ�KQ�VbL,�_�_I0��`l1ʥ�5F�b\����U�t/��R�K�Q&��\�_e)	�fn��� ۜ6����p��u���dQnΤ�m�%�QVg�G{�K{�K[N���~Z�^�C�D�^ZCٴ�ܴ�ܴJ�����t��i{i

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
