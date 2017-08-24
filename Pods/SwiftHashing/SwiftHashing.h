//
//  SwiftHashing.h
//  SwiftHashing
//
//  Created by Shaun Harrison.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NSString* hmacHash(NSString* secret, NSString* string);
NSString* md5Hash(NSString* string);

NS_ASSUME_NONNULL_END
