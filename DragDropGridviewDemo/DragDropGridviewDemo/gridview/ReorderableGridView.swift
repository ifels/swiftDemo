//
//  ReorderableGridView.swift
//  ReorderableGridView-Swift
//
//  Created by Cem Olcay on 19/11/14.
//  Copyright (c) 2014 Cem Olcay. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l <= r
    default:
        return !(rhs < lhs)
    }
}




protocol Reorderable {
    func didReorderStartedForView (_ view: ReorderableView)
    func didReorderedView (_ view: ReorderableView, pan: UIPanGestureRecognizer)
    func didReorderEndForView (_ view: ReorderableView, pan: UIPanGestureRecognizer)
}


protocol Draggable {
    func didDragStartedForView (_ ReorderableGridView: ReorderableGridView, view: ReorderableView)
    func didDraggedView (_ ReorderableGridView: ReorderableGridView, view: ReorderableView)
    func didDragEndForView (_ ReorderableGridView: ReorderableGridView, view: ReorderableView)
}




class ReorderableGridView: UIScrollView, Reorderable {
    let minHSpacing: CGFloat = 5.0
    let topPadding: CGFloat = 10.0
    let leftPadding: CGFloat = 15.0
    let rightPadding: CGFloat = 15.0
    let bottomPadding: CGFloat = 10.0
    
    // MARK: Properties
    var itemWidth: CGFloat?
    var verticalPadding: CGFloat?
    var horizontalPadding: CGFloat?
    var colsInRow: Int?
    var visibleRect: CGRect?
    var reorderable : Bool = true
    var draggable : Bool = true
    var draggableDelegate: Draggable?
    var reorderableViews : [ReorderableView] = []
    
    // MARK: Observers
    var currentCol: Int = 0 {
        didSet {
            if currentCol > colsInRow!-1 {
                currentCol = 0
                currentRow += 1
            } else if currentCol < 0 {
                currentCol = colsInRow!-1
                currentRow -= 1
            }
        }
    }
    
    var currentRow: Int = 0 {
        didSet {
            if currentRow < 0 {
                currentRow = 0
            }
        }
    }
    
    override var contentOffset: CGPoint {
        didSet {
            visibleRect? = CGRect (origin: contentOffset, size: frame.size)
            checkReusableViews()
        }
    }
    
    
    // MARK: Lifecycle
    init (frame: CGRect, itemWidth: CGFloat, verticalPadding: CGFloat = 10) {
        super.init(frame: frame)
        self.itemWidth = itemWidth
        self.verticalPadding = verticalPadding
        self.visibleRect = frame
        
        invalidateLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ScrollView
    func setContentHeight (_ height: CGFloat) {
        contentSize = CGSize (width: w, height: height)
    }
    
    func addContentHeight (_ height: CGFloat) {
        setContentHeight(contentSize.height + height)
    }
    
    func isViewInVisibleRect (_ view: ReorderableView) -> Bool {
        if let rect = visibleRect {
            return view.frame.intersects(rect)
        } else {
            return false
        }
    }
    
    func checkReusableViews () {
        for view in reorderableViews {
            if isViewInVisibleRect(view) {
                // is already added to view stack
                if let superView = view.superview {
                    if superView == self {
                        // already added
                        continue
                    } else {
                        // FIXME: another view is super !
                        continue
                    }
                } else {
                    if let gridPos = view.gridPosition {
                        // add
                        addSubview(view)
                        placeView(view, toGridPosition: gridPos)
                    } else {
                        // not initilized yet
                        continue
                    }
                }
            } else {
                // should removed
                if let superView = view.superview {
                    if superView == self {
                        // remove
                        view.removeFromSuperview()
                    } else {
                        // FIXME: another view is super !
                        continue
                    }
                } else {
                    // already removed
                    continue
                }
            }
        }
    }
    
    
    
    // MARK: Layout
    
    func invalidateLayout () {
        let contentWidth = self.w - self.leftPadding - self.rightPadding
        colsInRow = Int (contentWidth / (itemWidth! + minHSpacing))
        horizontalPadding = (contentWidth - (CGFloat(colsInRow!) * itemWidth!)) / (CGFloat(colsInRow!) - 1)
        
        contentSize.height = contentOffset.y + self.h + topPadding
        currentCol = 0
        currentRow = 0
        
        if reorderableViews.isEmpty {
            return
        }
        
        for i in 0...reorderableViews.count-1 {
            let y = currentRow
            let x = currentCol
            currentCol = currentCol + 1
            let gridPosition = GridPosition (x: x, y: y)
            placeView(reorderableViews[i], toGridPosition: gridPosition)
        }
    }
    
    func placeView (_ view: ReorderableView, toGridPosition: GridPosition) {
        view.gridPosition = toGridPosition
        view.delegate = self
        
        let pos = gridPositionToViewPosition(toGridPosition)
        view.setPosition(pos)
        
        let height = view.botttomWithOffset(verticalPadding!)
        if height > contentSize.height {
            setContentHeight(height)
        }
    }
    
    func insertViewAtPosition (_ view: ReorderableView, position: GridPosition) {
        if (view.gridPosition == position) {
            return
        }
        reorderableViews.remove(at: view.gridPosition!.arrayIndex(colsInRow!))
        reorderableViews.insert(view, at: position.arrayIndex(colsInRow!))
        invalidateLayout()
    }
    
    
    
    // MARK: Grid
    func gridPositionToViewPosition (_ gridPosition: GridPosition) -> CGPoint {
        let col = gridPosition.col()
        let x: CGFloat = CGFloat(col) * itemWidth! + CGFloat(col)*horizontalPadding! + leftPadding
        var y : CGFloat = topPadding
        
        if let up = gridPosition.up() {
            let upView = viewAtGridPosition(up)!
            print("upView.curScale = \(upView.curScale)")
            y = upView.bottom/upView.curScale + verticalPadding!
        }
        
        return CGPoint (x: x, y: y)
    }
    
    func viewAtGridPosition (_ gridPosition: GridPosition) -> ReorderableView? {
        let index = gridPosition.arrayIndex(colsInRow!)
        if (index < reorderableViews.count) {
            return reorderableViews[index]
        } else {
            return nil
        }
    }
    
    // MARK: Adding
    func addReorderableView (_ view: ReorderableView) {
        super.addSubview(view)
        reorderableViews.append(view)
        invalidateLayout()
    }
    
    func addReorderableView (_ view: ReorderableView, gridPosition: GridPosition) {
        super.addSubview(view)
        
        var addingIndex = gridPosition.arrayIndex(colsInRow!)
        if addingIndex >= reorderableViews.count {
            addingIndex = reorderableViews.count
        }
        reorderableViews.insert(view, at: addingIndex)
        invalidateLayout()
    }
    
    
    
    // MARK: Removing
    func removeReorderableViewAtGridPosition (_ gridPosition: GridPosition) {
        if let view = viewAtGridPosition(gridPosition) {
            reorderableViews.remove(at: gridPosition.arrayIndex(colsInRow!))
            
            view.removeFromSuperview()
            invalidateLayout()
        }
    }
    
    func removeReorderableView (_ view: ReorderableView) {
        if let pos = view.gridPosition {
            removeReorderableViewAtGridPosition(pos)
        } else {
            print ("view is not in grid hierarchy")
        }
    }
    
    // MARK: Reorderable
    func didReorderStartedForView (_ view: ReorderableView) {
        print("didReorderStartedForView..")
        draggableDelegate?.didDragStartedForView(self, view: view)
    }
    
    func didReorderedView (_ view: ReorderableView, pan: UIPanGestureRecognizer) {
        //print("didReorderedView..")
        if !draggable {
            return
        } else {
            draggableDelegate?.didDraggedView(self, view: view)
        }
        let location = pan.location(in: self)
        view.center = location
        
        if !reorderable {
            return
        }
        
        let col : Int = min(Int(location.x) / Int(itemWidth! + horizontalPadding!), colsInRow!-1)
        var rowCount : Int = (reorderableViews.count/colsInRow!)
        if (reorderableViews.count % colsInRow!) != 0 {
            rowCount = rowCount + 1
        }
        
        var gridPos = GridPosition (x: col, y: 0)
        for row in 0 ..< rowCount {
            gridPos.y = row
            
            if let otherView = viewAtGridPosition(gridPos) {
                if otherView == view {
                    continue
                }
                
                if otherView.frame.contains(location) {
                    print("im at \(col), \(row), im " + view.gridPosition!.string())
                    insertViewAtPosition(view, position: gridPos)
                }
            }
        }
    }
    
    func didReorderEndForView (_ view: ReorderableView, pan: UIPanGestureRecognizer) {
        print("didReorderEndForView..")
        if reorderable {
            invalidateLayout()
        }
        
        if draggable {
            draggableDelegate?.didDragEndForView(self, view: view)
        }
    }
}
