//
//  ViewController.m
//  LWLWBinaryTreeNode
//
//  Created by xinglw on 2018/10/16.
//  Copyright © 2018年 xinglw. All rights reserved.
//
#import "LWBinaryTreeNode.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //    NSArray *dataArr = [NSMutableArray arrayWithObjects:@(20), @(18), @(28), @(30), @(40), @(15), @(13), @(14), @(19), @(5), @(7), @(2), @(9), @(27), @(29), @(35), @(38), @(42), @(33), @(39), @(60), nil];
    //排序二叉树
    NSArray *dataArr = [NSMutableArray arrayWithObjects:@(8), @(3), @(10), @(1), @(6), @(14), @(4), @(7), @(13), nil];
    //1.创建二叉树
    LWBinaryTreeNode *rootNode = [self creatLWBinaryTreeNodeWithDataArray:dataArr];
    //2.按层遍历二叉树
    [self levalTraverseTree:rootNode handler:^(LWBinaryTreeNode *node) {
        NSLog(@"node.value---->%ld", node.value);
    }];
    /*
     8 3 10 1 6 14 4 7 13
     */
    
    //先序遍历二叉树
    [ViewController preOrderTraverseTree:rootNode handler:^(LWBinaryTreeNode *treeNode) {
        NSLog(@"preOrderT--node.value---->%ld", treeNode.value);
    }];
    // 8  3   1  6  4   7  10   14   13
    //中序遍历
    [ViewController inOrderTraverseTree:rootNode handler:^(LWBinaryTreeNode *treeNode) {
        NSLog(@"inOrderTraverseTree--node.value---->%ld", treeNode.value);
    }];
    //1  3  4  6  7  8  10  13  14
    //后序遍历
    [ViewController postOrderTraverseTree:rootNode handler:^(LWBinaryTreeNode *treeNode) {
        NSLog(@"postOrderTraverseTree--node.value---->%ld", treeNode.value);
    }];
    //1  4  7  6  3  13  14  10  8
    //翻转二叉树
    LWBinaryTreeNode *invertedNode = [self invertBinaryTree:rootNode];
    //2.按层遍历二叉树
    [self levalTraverseTree:invertedNode handler:^(LWBinaryTreeNode *node) {
        NSLog(@"invertd-node.value---->%ld", node.value);
    }];
    
}




#pragma mark - 创建二叉树
- (LWBinaryTreeNode *)creatLWBinaryTreeNodeWithDataArray:(NSArray *)array
{
    LWBinaryTreeNode *root = nil;
    for (NSNumber *num in array) {
        NSInteger value = [num integerValue];
        root = [self addTreeNode:root value:value];
    }
    NSLog(@"root.value--->%ld", root.value);
    return root;
}

- (LWBinaryTreeNode *)addTreeNode:(LWBinaryTreeNode *)root value:(NSInteger)value
{
    if (!root) {
        root = [[LWBinaryTreeNode alloc] init];
        root.value = value;
        //        NSLog(@"forin.rootNodeValue--->%ld", value);
    }else if (value <= root.value){
        //        [self addTreeNode:root.leftNode value:value];
        root.leftNode = [self addTreeNode:root.leftNode value:value];
    }else{
        root.rightNode = [self addTreeNode:root.rightNode value:value];
    }
    return root;
}

#pragma mark - 按层遍历二叉树(从上到下，从左到右)
- (void)levalTraverseTree:(LWBinaryTreeNode *)rootNode handler:(void(^)(LWBinaryTreeNode *node))handler
{
    if (!rootNode) {
        return;
    }
    NSMutableArray *queueArray = [NSMutableArray array];
    [queueArray addObject:rootNode];
    while (queueArray.count > 0) {
        LWBinaryTreeNode *node = [queueArray firstObject];
        if (handler) {
            handler(node);
        }
        [queueArray removeObjectAtIndex:0];
        if (node.leftNode) {
            [queueArray addObject:node.leftNode];
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode];
        }
    }
}

#pragma mark 先序遍历
/**
 *  先序遍历
 *  先访问根，再遍历左子树，再遍历右子树
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)preOrderTraverseTree:(LWBinaryTreeNode *)rootNode handler:(void(^)(LWBinaryTreeNode *treeNode))handler {
    if (rootNode) {
        
        if (handler) {
            handler(rootNode);
        }
        
        [self preOrderTraverseTree:rootNode.leftNode handler:handler];
        [self preOrderTraverseTree:rootNode.rightNode handler:handler];
    }
}

/**
 *  中序遍历
 *  先遍历左子树，再访问根，再遍历右子树
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)inOrderTraverseTree:(LWBinaryTreeNode *)rootNode handler:(void(^)(LWBinaryTreeNode *treeNode))handler {
    if (rootNode) {
        [self inOrderTraverseTree:rootNode.leftNode handler:handler];
        
        if (handler) {
            handler(rootNode);
        }
        
        [self inOrderTraverseTree:rootNode.rightNode handler:handler];
    }
}
/**
 *  后序遍历
 *  先遍历左子树，再遍历右子树，再访问根
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)postOrderTraverseTree:(LWBinaryTreeNode *)rootNode handler:(void(^)(LWBinaryTreeNode *treeNode))handler {
    if (rootNode) {
        [self postOrderTraverseTree:rootNode.leftNode handler:handler];
        [self postOrderTraverseTree:rootNode.rightNode handler:handler];
        
        if (handler) {
            handler(rootNode);
        }
    }
}

#pragma mark - 翻转二叉树
- (LWBinaryTreeNode *)invertBinaryTree:(LWBinaryTreeNode *)rootNode
{
    if (!rootNode) {
        return nil;
    }
    //叶子节点
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return rootNode;
    }
    
    [self invertBinaryTree:rootNode.leftNode];
    [self invertBinaryTree:rootNode.rightNode];
    
    LWBinaryTreeNode *tempNode = rootNode.leftNode;
//    rootNode.rightNode = rootNode.rightNode;
//    rootNode.leftNode = tempNode;
    rootNode.leftNode = rootNode.rightNode;
    rootNode.rightNode = tempNode;
    
    return rootNode;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
