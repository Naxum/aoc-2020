//
//  Utils.swift
//  AdventOfCode2020
//
//  Created by Jake Sawyer on 12/6/20.
//

import Foundation

extension String {
    func splitDoubleNewlines() -> [Substring] {
        var result = [Substring]()
        var previousCharacterWasNewline = false
        var currentLowerBound = startIndex
        for index in indices {
            if self[index].isNewline || index == self.index(before: endIndex) {
                if previousCharacterWasNewline || index == self.index(before: endIndex) {
                    previousCharacterWasNewline = false
                    result.append(self[currentLowerBound ... index])
                    if index != endIndex {
                        currentLowerBound = self.index(after: index)
                    }
                } else {
                    previousCharacterWasNewline = true
                }
            } else {
                previousCharacterWasNewline = false
            }
        }
        return result
    }
}
