//
//  AkvcPathReadBiList.h
//  AkvcExtensionSample
//
//  Created by NOVO on 2018/10/22.
//  Copyright © 2018 NOVO. All rights reserved.
//  https://github.com/qddnovo/AkvcExtension
//

#import <Foundation/Foundation.h>

@class AkvcPathReadNode;


/**
 Binary linked list of match
 用于读取路径小节的二叉链表
 
 A --NO-> B --NO-> C...
 ⇣YES     ⇣YES
 A1       B1
 ⇣YES     ⇣
 A2       ...
 ⇣
 ...
 */
@interface AkvcPathReadBiList : NSObject

+ (AkvcPathReadBiList* _Nonnull)defaultList;

@property (nonatomic,strong,readonly) AkvcPathReadNode* rootNode;

@end

