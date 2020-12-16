//
//  Day10.swift
//  AdventOfCode2020
//
//  Created by Jake Sawyer on 12/9/20.
//

import Foundation

struct Day10 {
    
    static let input = rawInput
        .split(whereSeparator: \.isNewline)
        .map { Int($0)! }
        .sorted()
    
    static func solvePart1() {
        /**
         Find a chain that uses all of your adapters to connect the charging outlet to your device's built-in adapter and count the joltage differences between the charging outlet, the adapters, and your device.
         What is the number of 1-jolt differences multiplied by the number of 3-jolt differences?
         */
        func construct(chain: [Int], remaining: [Int]) {
            // calculate possible options
            let latest = chain.last!
            if remaining.isEmpty {
                print("Mission complete, calculating results... (chain length: \(chain.count))")
                print(chain)
                var oneJoltDifferences = 0
                var threeJoltDifferences = 1 // last adapter to device is 3
                if chain.first! == 1 {
                    oneJoltDifferences += 1
                } else if chain.first! == 3 {
                    threeJoltDifferences += 1
                }
                
                for (previous, current) in zip(chain, chain.dropFirst()) {
                    if current - previous == 1 {
                        oneJoltDifferences += 1
                    } else if current - previous == 3 {
                        threeJoltDifferences += 1
                    }
                }
                print("Result: \(oneJoltDifferences * threeJoltDifferences)")
                return
            }
            let result = remaining.enumerated().first(where: { $0.element <= latest + 3})!
//            for index in 0 ..< remaining.count {
//                if remaining[index] <= latest + 3 {
                    var chainCopy = chain
//                    chainCopy.append(remaining[index])
                    chainCopy.append(result.element)
                    var remainingCopy = remaining
//                    remainingCopy.remove(at: index)
                    remainingCopy.remove(at: result.offset)
                    construct(chain: chainCopy, remaining: remainingCopy)
//                }
//            }
            // construct chains for each option
            // when we finally complete, return result
            // otherwise die
        }
        construct(chain: [input.first!], remaining: Array(input.dropFirst()))
    }
    
    static func solvePart2() {
        print("Calculating...")
        struct Chain {
            var joltage: Int
            var remaining: [Int]
        }
        
        func calculateChainPossibilities(chain: Chain, count: Int, multiplier: Int) -> Int {
            var count = count
            for index in 0 ..< chain.remaining.count {
                if chain.remaining[index] <= chain.joltage + 3 {
                    var chainCopy = chain
                    chainCopy.joltage = chain.remaining[index]
                    chainCopy.remaining.remove(at: index)
                    count += calculateChainPossibilities(chain: chainCopy, count: count, multiplier: multiplier + 1) * multiplier
                } else {
                    break
                }
            }
            print("Currently up to \(count)")
            return count
        }
        
        let result = calculateChainPossibilities(chain: Chain(joltage: 0, remaining: input), count: 0, multiplier: 1)
        print("Result: \(result)")
    }
}

extension Day10 {
    
    static let rawInput = """
38
23
31
16
141
2
124
25
37
147
86
150
99
75
81
121
93
120
96
55
48
58
108
22
132
62
107
54
69
51
7
134
143
122
28
60
123
82
95
14
6
106
41
131
109
90
112
1
103
44
127
9
83
59
117
8
140
151
89
35
148
76
100
114
130
19
72
36
133
12
34
46
15
45
87
144
80
13
142
149
88
94
61
154
24
66
113
5
73
79
74
65
137
47
"""
    
}
