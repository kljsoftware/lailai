//
//  String+Extension.swift
//  GC
//
//  Created by hzg on 2018/2/3.
//  Copyright © 2018年 demo. All rights reserved.
//

import UIKit

extension String {
    
    /// [start, end] 从0开始
    func subString(start:Int, end:Int) -> String {
        let startIndex = index(self.startIndex, offsetBy: start)
        let endIndex   = end <= 0 ? index(self.endIndex, offsetBy: end) : index(self.startIndex, offsetBy: end)
        return String(self[startIndex..<endIndex])
    }
    
    /// 测量单行字符串
    func sizeWithFont(_ font:UIFont) -> CGSize {
        let attrs = [NSFontAttributeName:font]
        let string:NSString = self as NSString
        return string.size(attributes: attrs)
    }
    
    /// 测量多行字符串宽高
    func getTextRectSize(_ font:UIFont, maxWidth:CGFloat, maxHeight:CGFloat) -> CGSize {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let size = CGSize(width: maxWidth, height: maxHeight)
        let rect:CGRect = self.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect.size;
    }
    
    // 判断是否全是空白
    func isBlank() -> Bool {
        return trimmingCharacters(in: CharacterSet.whitespaces) == ""
    }
    
    /// 检查手机号是否合法
    func checkTelephone() -> Bool {
        let telNumber = "^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$"
        let tel = NSPredicate(format: "SELF MATCHES %@", telNumber)
        return tel.evaluate(with: self)
    }
}


// MARK: - 加密  HMAC_SHA1/MD5/SHA1/SHA224......
/**  需在桥接文件导入头文件 ，因为C语言的库
 *   #import <CommonCrypto/CommonDigest.h>
 *   #import <CommonCrypto/CommonHMAC.h>
 */
enum CryptoAlgorithm {
    
    /// 加密的枚举选项
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
    
    var HMACAlgorithm: CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .MD5:      result = kCCHmacAlgMD5
        case .SHA1:     result = kCCHmacAlgSHA1
        case .SHA224:   result = kCCHmacAlgSHA224
        case .SHA256:   result = kCCHmacAlgSHA256
        case .SHA384:   result = kCCHmacAlgSHA384
        case .SHA512:   result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }
    
    var digestLength: Int {
        var result: Int32 = 0
        switch self {
        case .MD5:      result = CC_MD5_DIGEST_LENGTH
        case .SHA1:     result = CC_SHA1_DIGEST_LENGTH
        case .SHA224:   result = CC_SHA224_DIGEST_LENGTH
        case .SHA256:   result = CC_SHA256_DIGEST_LENGTH
        case .SHA384:   result = CC_SHA384_DIGEST_LENGTH
        case .SHA512:   result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}

extension String {
    
    /*
     *   func：加密方法
     *   参数1：加密方式； 参数2：加密的key
     */
    func hmac(algorithm: CryptoAlgorithm, key: String) -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = Int(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = key.cString(using: String.Encoding.utf8)
        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))
        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)
        let digest = stringFromResult(result:  result, length: digestLen)
        result.deallocate(capacity: digestLen)
        return digest
    }
    
    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash)
    }
    
}
