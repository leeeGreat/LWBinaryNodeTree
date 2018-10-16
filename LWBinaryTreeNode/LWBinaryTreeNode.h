//
//  LWBinaryTreeNode.h
//  LWBinaryTreeNode
//
//  Created by xinglw on 2018/10/16.
//  Copyright © 2018年 xinglw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWBinaryTreeNode : NSObject

@property (assign,nonatomic) NSInteger value;

@property (nonatomic,strong) LWBinaryTreeNode *leftNode;

@property (nonatomic,strong) LWBinaryTreeNode *rightNode;

@end
