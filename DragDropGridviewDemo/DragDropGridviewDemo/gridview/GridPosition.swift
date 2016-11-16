//
//  GridPosition.swift
//  mdx-audio
//
//  Created by ifels on 2016/11/14.
//  Copyright © 2016年 ifels. All rights reserved.
//

import Foundation

func == (lhs: GridPosition, rhs: GridPosition) -> Bool {
    return (lhs.x == rhs.x && lhs.y == rhs.y)
}

struct GridPosition: Equatable {
    var x: Int?
    var y: Int?
    
    func col () -> Int {
        return x!
    }
    
    func row () -> Int {
        return y!
    }
    
    
    func arrayIndex (_ colsInRow: Int) -> Int {
        let index = row()*colsInRow + col()
        return index
    }
    
    
    func up () -> GridPosition? {
        if y! <= 0 {
            return nil
        } else {
            return GridPosition(x: x!, y: y!-1)
        }
    }
    
    func down () -> GridPosition {
        return GridPosition(x: x!, y: y!+1)
    }
    
    func left () -> GridPosition? {
        if x! <= 0 {
            return nil
        } else {
            return GridPosition (x: x!-1, y: y!)
        }
    }
    
    func right () -> GridPosition {
        return GridPosition (x: x!+1, y: y!)
    }
    
    
    func string () -> String {
        return "\(x!), \(y!)"
    }
    
    func detailedString () -> String {
        return "x: \(x!), y: \(y!)"
    }
}
