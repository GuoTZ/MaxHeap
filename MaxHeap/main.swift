//
//  main.swift
//  MaxHeap
//
//  Created by DingYD on 2019/5/14.
//  Copyright © 2019 GuoTZ. All rights reserved.
//

import Foundation

print("Hello, World!")




var data = MaxHeap<Int>()
for i in 0...100 {
    if i % 3 == 0 {
        
        data.add(e: i)
    }
}
print(data)
print(data.extractMax() ?? 0)
print(data.extractMax() ?? 0)
print(data.extractMax() ?? 0)
print(data.extractMax() ?? 0)
print(data)


