import XCTest
@testable import Queue

final class LinkedListTests: XCTestCase {
    
    // MARK: - `init:arrayLiteral`
    
    func testInitArrayLiteralWithMultipleElementsConstructsLinkedList() {
        let linkedList: LinkedList = [1, 3, 4, 5]
        XCTAssertEqual(linkedList.tail, 1)
        XCTAssertEqual(linkedList.head, 5)
    }
    
    // MARK: - `isEmpty`
    
    func testIsEmptyReturnsTrueWhenHeadIsNil() {
        let linkedList = LinkedList<String>()
        XCTAssert(linkedList.isEmpty)
    }
    
    func testIsEmptyReturnsFalseWhenHeadIsNotNil() {
        var linkedList = LinkedList<String>()
        linkedList.append("node")
        XCTAssertFalse(linkedList.isEmpty)
    }
    
    // MARK: - `count`
    
    func testCountIsIncrementedAfterAppend() {
        var linkedList = LinkedList<Int>()
        XCTAssertEqual(linkedList.count, 0)
        linkedList.append(3)
        XCTAssertEqual(linkedList.count, 1)
    }
    
    func testCountIsEqualToItemCountAfterInitWithArray() {
        let linkedList: LinkedList = [2, 17, 3, 99]
        XCTAssertEqual(linkedList.count, 4)
    }
    
    // MARK: - `peek:for`
    
    func testPeekReturnsTrueForValueExistsInList() {
        let linkedList: LinkedList = [2, 17, 3, 99]
        XCTAssert(linkedList.peek(for: 99))
    }
    
    func testPeekReturnsFalseForValueDoesNotExistInList() {
        let linkedList: LinkedList = [2, 17, 3, 99]
        XCTAssertFalse(linkedList.peek(for: 34))
    }
    
    func testPeekReturnsFalseForEmptyList() {
        let linkedList: LinkedList<String> = []
        XCTAssertFalse(linkedList.peek(for: "asd"))
    }
    
    // MARK: - `append:value`
    
    func testAppendUpdatesHeadElement() {
        var linkedList = LinkedList<String>()
        
        linkedList.append("next")
        
        XCTAssertEqual(linkedList.head, "next")
    }

    func testAppendUpdatesHeadReference() {
        var linkedList = LinkedList<String>()
        let head = linkedList.head
        
        linkedList.append("next")
        
        XCTAssertNotEqual(head, linkedList.head)
    }
    
    func testTailIsFirstAppendedNodeAfter3Appends() {
        var linkedList = LinkedList<String>()

        linkedList.append("tail")
        linkedList.append("mid")
        linkedList.append("head")

        XCTAssertEqual(linkedList.tail, "tail")
        XCTAssertEqual(linkedList.head, "head")
    }
    
    func testTailAndHeadAreTheSameWhenOnlyOneNode() {
        var linkedList = LinkedList<String>()
        
        linkedList.append("one")
        
        XCTAssertEqual(linkedList.tail, linkedList.head)
    }
    
    func testAppendAddsDuplicateValues() {
        var linkedList = LinkedList<String>()
        linkedList.append("one")
        linkedList.append("two")
        linkedList.append("one")
        XCTAssertEqual(linkedList.tail, linkedList.head)
    }
    
    // MARK: - `append:value` CoW
    
    func testAppendOnCopyOnlyUpdatesCopy() {
        let linkedList: LinkedList = ["one", "two"]
        var linkedListCopy = linkedList
        
        linkedListCopy.append("three")
        
        XCTAssertEqual(linkedListCopy._tail?.value, "one")
        XCTAssertEqual(linkedListCopy._tail?.next?.value, "two")
        XCTAssertEqual(linkedListCopy._tail?.next?.next?.value, "three")
        XCTAssertEqual(linkedListCopy._head?.value, "three")
        XCTAssertNil(linkedListCopy._head?.next)
    }
    
    func testAppendOnCopyLeavesOriginalListUnchanged() {
        let linkedList: LinkedList = ["one", "two"]
        var linkedListCopy = linkedList
        
        linkedListCopy.append("three")
        
        XCTAssertEqual(linkedList._tail?.value, "one")
        XCTAssertEqual(linkedList._tail?.next?.value, "two")
        XCTAssertNil(linkedList._tail?.next?.next)
        XCTAssertEqual(linkedList._head?.value, "two")
    }
    
    func testAppendOnCopyGeneratesANewListWithNewTailHeadReference() {
        let linkedList: LinkedList = ["one", "two"]
        var linkedListCopy = linkedList
        
        linkedListCopy.append("three")
        
        XCTAssertFalse(linkedList._tail === linkedListCopy._tail)
        XCTAssertFalse(linkedList._head === linkedListCopy._head)
    }
    
    func testAppendOnEmptyCopyOnlyAppendsToCopy() {
        let linkedList: LinkedList<String> = []
        var linkedListCopy = linkedList
        
        linkedListCopy.append("Gollum")
        
        XCTAssertEqual(linkedListCopy._tail?.value, "Gollum")
        XCTAssertEqual(linkedListCopy._head?.value, "Gollum")
        XCTAssertNil(linkedList._head)
        XCTAssertNil(linkedList._tail)
    }
    
    // MARK: - `remove:value`
    
    func testRemoveValueReturnsTrueForValueThatExists() {
        var linkedList: LinkedList = [19, 44, 23, 1]
        XCTAssert(linkedList.remove(value: 44))
    }
    
    func testRemoveValueReturnsFalseForValueThatDoesNotExist() {
        var linkedList: LinkedList = [19, 44, 23, 1]
        XCTAssertFalse(linkedList.remove(value: 9999))
    }
    
    func testRemoveValueReturnsTrueAndTailIsNextValueWhenRemoveTheFirstElement() {
        var linkedList: LinkedList = [9.7, 10.1]
        XCTAssert(linkedList.remove(value: 9.7))
        XCTAssertEqual(linkedList.tail, 10.1)
    }
    
    func testHeadDoesNotChangeWhenRemoveIsInvokedOnAListWithMultipleElements() {
        var linkedList: LinkedList = [9.7, 10.1]
        linkedList.remove(value: 9.7)
        XCTAssertEqual(linkedList.head, 10.1)
    }
    
    func testRemoveMiddleElementRemovesTheElementInTheMiddle() {
        var linkedList: LinkedList = ["a", "b", "c"]
        let didRemove = linkedList.remove(value: "b")
        XCTAssert(didRemove)
        XCTAssertEqual(linkedList.tail, "a")
        XCTAssertEqual(linkedList.head, "c")
        XCTAssertEqual(linkedList.count, 2)
    }
    
    func testRemoveLastElementUpdatesHeadToBePreviousValue() {
        var linkedList: LinkedList = ["a", "b", "c"]
        let didRemove = linkedList.remove(value: "c")
        XCTAssert(didRemove)
        XCTAssertEqual(linkedList.tail, "a")
        XCTAssertEqual(linkedList.head, "b")
        XCTAssertEqual(linkedList.count, 2)
    }
    
    // MARK: - `remove:value` CoW
    
    func testRemoveSecondElementOfCopyLeavesTheCopyListConnected() {
        let linkedList: LinkedList = [1, 2, 3, 4, 5]
        var linkedListCopy = linkedList
        
        linkedListCopy.remove(value: 2)
        
        XCTAssertEqual(linkedListCopy._tail?.next?.value, 3)
        XCTAssertEqual(linkedListCopy.count, 4)
    }
    
    
    func testRemoveSecondElementOfCopyLeavesTheOriginalListConnected() {
        let linkedList: LinkedList = [1, 2, 3, 4, 5]
        var linkedListCopy = linkedList
        
        linkedListCopy.remove(value: 2)
        
        XCTAssertEqual(linkedList._tail?.next?.value, 2)
        XCTAssertEqual(linkedList.count, 5)
    }
    
    func testRemoveFirstElementOfCopyUpdatedCopyTail() {
        let linkedList: LinkedList = [1, 2, 3, 4, 5]
        var linkedListCopy = linkedList
        
        linkedListCopy.remove(value: 1)
        
        XCTAssertEqual(linkedListCopy._tail?.value, 2)
        XCTAssertEqual(linkedListCopy._tail?.next?.value, 3)
        XCTAssertEqual(linkedListCopy.count, 4)
    }
    
    
    func testRemoveFirstElementOfCopyDoesNotUpdateTail() {
        let linkedList: LinkedList = [1, 2, 3, 4, 5]
        var linkedListCopy = linkedList
        
        linkedListCopy.remove(value: 1)
        
        XCTAssertEqual(linkedList._tail?.next?.value, 2)
        XCTAssertEqual(linkedList.count, 5)
    }
    
    func testRemoveMiddleElementOnCopyGeneratesANewListWithNewTailHeadReference() {

        let linkedList: LinkedList = [1, 2, 3, 4, 5]
        var linkedListCopy = linkedList
        
        linkedListCopy.remove(value: 1)
        
        XCTAssertFalse(linkedList._tail === linkedListCopy._tail)
        XCTAssertFalse(linkedList._head === linkedListCopy._head)
    }
    
    // MARK: - `removeFirst`
    
    func testRemoveFirstUpdatesTail() {
        var linkedList: LinkedList = [1, 2, 3, 4, 5]
        
        let didRemove = linkedList.removeFirst()
        XCTAssertTrue(didRemove)
        XCTAssertEqual(linkedList._tail?.value, 2)
        XCTAssertEqual(linkedList.count, 4)
    }
    
    func testRemoveFirstWhenSingleElementNullifiesTailAndHead() {
        var linkedList: LinkedList = [1]
        
        let didRemove = linkedList.removeFirst()
        XCTAssertTrue(didRemove)
        XCTAssertNil(linkedList._head)
        XCTAssertNil(linkedList._tail)
    }
    
    func testRemoveFirstReturnsFalseWhenListIsEmpty() {
        var linkedList: LinkedList<Int> = []
        
        let didRemove = linkedList.removeFirst()
        XCTAssertFalse(didRemove)
    }
    
    // MARK: - `removeFirst` CoW
    
    func testRemoveFirstGeneratesNewListWhenMultipleReference() {
        let linkedList: LinkedList = [3, 5]
        var linkedListCopy = linkedList
        
        let didRemove = linkedListCopy.removeFirst()
        XCTAssertTrue(didRemove)
        XCTAssertNotEqual(linkedList._tail, linkedListCopy._tail)
        XCTAssertNotEqual(linkedList._head, linkedListCopy._head)
    }
}
