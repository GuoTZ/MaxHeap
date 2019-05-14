//
//  MaxHeap.swift
//  MaxHeap
//
//  Created by DingYD on 2019/5/14.
//  Copyright © 2019 GuoTZ. All rights reserved.
//

import Cocoa


enum UserError:Error {
    case msg(String)
}


extension Array {
    /// 替换数组的两个索引对应的值
    ///
    /// - Parameters:
    ///   - i: i description
    ///   - j: j description
    /// - Returns: 返回true表示替换成功 f否则表示没有替换成功
    public mutating func swap(i:Int,j:Int) ->Bool {
        if i<0 && i>=self.count {
            return false
        }
        if j<0 && j>=self.count {
            return false
        }
        let temp = self[i]
        self[i] = self[j]
        self[j] = temp
        return true
    }
}


class MaxHeap<E>:CustomDebugStringConvertible where E:Comparable {

    var data:Array<E>
    init() {
        self.data = Array<E>()
    }
    ///回去节点个数
    func size() -> Int {
        return self.data.count
    }
    ///判断是否为空
    func isEmpty() -> Bool {
        return self.data.count == 0
    }
    
    /// 计算index的父节点的值
    ///
    /// - Parameter index: <#index description#>
    /// - Returns: return value description
    private func parent(index:Int)  -> Int {
        if index==0 {
            return 0
        }
        return (index-1) / 2
    }
    
    /// 返回完全二叉树的数组表示中，一个索引所表示的元素的左孩子节点的索引
    ///
    /// - Parameter index: index description
    /// - Returns: return value description
    private func leftChild(index:Int) -> Int {
        return index * 2 + 1
    }
    
    /// 返回完全二叉树的数组表示中，一个索引所表示的元素的右孩子节点的索引
    ///
    /// - Parameter index: index description
    /// - Returns: return value description
    private func rightChild(index:Int) -> Int {
        return index * 2 + 1
    }
    
    /// 添加节点
    /// 每次添加数据时添加到数据尾部
    /// 跟父节点比较大小 上浮节点
    /// - Parameter e: e description
    func add(e:E) {
        self.data.append(e)//添加到数组中
        siftUp(n: (self.size()-1))
    }
    
    /// 上浮节点
    ///
    /// - Parameter n: 节点的索引
    private func siftUp(n: Int) {
        var k = n
        while k > 0 && self.data[self.parent(index: k)] < self.data[k] {
            _ = self.data.swap(i: k, j: self.parent(index: k))
            k = self.parent(index: k)
        }
    }
    
    var debugDescription: String {
        var str = "["
        for item in self.data {
            str.append("\(item),")
        }
        str.append("]")
        return str
    }
    
    
    /// 查找堆得最大元素
    ///
    /// - Returns: 最大元素
    func findMax() -> E? {
        if self.size()==0 {
            return nil
        }
        return self.data.first
    }
    
    /// 从堆里面移除最大值
    ///
    /// - Returns: 最大元素
    func extractMax() -> E? {
        let data = self.findMax()
        
        _ = self.data.swap(i: 0, j: self.size()-1)//与s最后一位元素交换位置
        self.data.remove(at: self.size()-1) //从数组移除最大值
        self.siftDown(n: 0) //依次比较该元素与其左右孩子的大小
        
        
        return data
    }
    /// 下浮节点
    ///
    /// - Parameter n: 节点的索引
    private func siftDown(n:Int) {
        var k = n
        while self.leftChild(index: k) < self.size() {
            var leftC = self.leftChild(index: k)
            if leftC+1<self.size() && self.data[leftC+1] > self.data[leftC] {
                leftC += 1
            }
            if data[k] > self.data[leftC] {
                break
            }
            _ = self.data.swap(i: k, j: leftC)
            k = leftC
        }
    }
}
