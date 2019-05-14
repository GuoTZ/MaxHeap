# MaxHeap
### 堆的性质
- 堆是一颗完全二叉树
- 堆的顶端一定是“最大”，最小”的，但是要注意一个点，这里的大和小并不是传统意义下的大和小，它是相对于优先级而言的，当然你也可以把优先级定为传统意义下的大小，但一定要牢记这一点，初学者容易把堆的“大小”直接定义为传统意义下的大小，某些题就不是按数字的大小为优先级来进行堆的操作的`（但是为了讲解方便，下文直接把堆的优先级定为传统意义下的大小，所以上面跟没讲有什么区别？）`
- 堆一般有两种样子，小根堆和大根堆，分别对应第二个性质中的“堆顶最大”“堆顶最小”，对于大根堆而言，任何一个非根节点，它的优先级都小于堆顶，对于小根堆而言，任何一个非根节点，它的优先级都大于堆顶（这里的根就是堆顶啦qwq）

#### 来一张图了解一下堆（这里是大根堆）（原谅丑陋无比的图）
![](https://www.guotzh.com/2019/05/14/%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84%E4%B9%8B%E4%BA%8C%E5%8F%89%E5%A0%86/erchadui.png)
<!-- more -->
#### 最大堆是一个完全二叉树，可用数组存放如下，满足以下条件


`不必须从索引1开始才可以 也可以从0开始`
#### 索引从1开始存放数据时
data| |80|73|71|68|58|48|40|3|13|7|8|17|43|25
-- | -| -| -| -| -| -| -| -| -| -| -| -| -| -|-|
index|0 | 1|2|3|4|5|6|7|8|9|10|11|12|13|14|
```swift
在下标为K的结点  
    它的左孩子为**2K**的下标结点    
    右孩子为**2K+1**结点     
    父亲为**K/2** (强制取整)
比如 下标为2的值为73   
    左孩子为2*2=4的下标值为68  
    右孩子为2*2+1=5的下标值为58    
    父亲为2/2=1的下标值为80
```
`不必须从索引1开始才可以 也可以从0开始`
#### 索引从0开始存放数据时
data| 80|73|71|68|58|48|40|3|13|7|8|17|43|25
-- | -| -| -| -| -| -| -| -| -| -| -| -| -| -|
index|0 | 1|2|3|4|5|6|7|8|9|10|11|12|13|
```swift
在下标为K的结点  
    它的左孩子为**2K+1**的下标结点    
    右孩子为**2K+2**结点     
    父亲为**(K-1)/2** (强制取整)
比如 下标为3的值为68   
    左孩子为3*2+1=7的下标值为3  
    右孩子为3*2+2=8的下标值为13    
    父亲为(2-1)/2=1的下标值为73
```

### 用数组实现最大堆

```swift
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
}

```
#### 使用
```swift
var data = MaxHeap<Int>()
for i in 0...100 {
    if i % 3 == 0 {
        
        data.add(e: i)
    }
}
print(data)

```
#### `打印结果`
```swift
[99,96,87,93,60,72,84,90,45,51,57,39,69,75,81,48,63,9,42,6,24,21,54,3,30,15,66,12,36,33,78,0,27,18,]
```
![](https://www.guotzh.com/2019/05/14/%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84%E4%B9%8B%E4%BA%8C%E5%8F%89%E5%A0%86/dayinjieguoyanzhengzuidadui.png)

### 扩展 
```swift
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
```
#### 使用
```swift
print(data.extractMax() ?? 0)
print(data.extractMax() ?? 0)
print(data.extractMax() ?? 0)
print(data.extractMax() ?? 0)
print(data)

```
#### `打印结果`
```swift
99
96
93
90
[87,63,84,48,60,72,81,27,45,51,57,39,69,75,78,0,18,9,42,6,24,21,54,3,30,15,66,12,36,33,]
```
![](https://www.guotzh.com/2019/05/14/%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84%E4%B9%8B%E4%BA%8C%E5%8F%89%E5%A0%86/yichuzuidazhidezuidadui.png)
