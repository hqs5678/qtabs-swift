//
//  SwiftHashing.m
//  SwiftHashing
//
//  Created by Shaun Harrison.
//

#import "SwiftHashing.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

NSString* hmacHash(NSString* secret, NSString* string) {
	const char* _secret = [secret cStringUsingEncoding:NSASCIIStringEncoding];
	const char* _string = [string cStringUsingEncoding:NSASCIIStringEncoding];

	unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];

	CCHmac(kCCHmacAlgSHA256, _secret, strlen(_secret), _string, strlen(_string), cHMAC);

	NSData* hash = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
	return [hash base64EncodedStringWithOptions:0];
}

NSString* md5Hash(NSString* string) {
	const char* _string = [string UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(_string, (CC_LONG)strlen(_string), result);
	return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}
