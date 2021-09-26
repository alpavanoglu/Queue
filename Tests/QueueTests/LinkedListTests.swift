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
    
    // MARK: - `peek`
    
    func testPeekReturnsTrueForValueExistsInList() {
        let linkedList: LinkedList = [2, 17, 3, 99]
        XCTAssert(linkedList.peek(99))
    }
    
    func testPeekReturnsFalseForValueDoesNotExistInList() {
        let linkedList: LinkedList = [2, 17, 3, 99]
        XCTAssertFalse(linkedList.peek(34))
    }
    
    func testPeekReturnsFalseForEmptyList() {
        let linkedList: LinkedList<String> = []
        XCTAssertFalse(linkedList.peek("asd"))
    }
    
    // MARK: - `append:value`
    
    func testAppendUpdatesHeadElement() {
        var linkedList = LinkedList<String>()
        
        linkedList.append("next")
        
        XCTAssertEqual(linkedList.head, "next")
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
    
    // MARK: - `prepend:value`
    
    func testPrependUpdatesTailElement() {
        var linkedList = LinkedList<String>()
        
        linkedList.append("first")
        XCTAssertEqual(linkedList.tail, "first")
        
        linkedList.prepend("next")
        
        XCTAssertEqual(linkedList.head, "first")
        XCTAssertEqual(linkedList.tail, "next")
    }

    func testTailIsLastPrependedNodeAfter3Prepends() {
        var linkedList = LinkedList<String>()

        linkedList.prepend("head")
        linkedList.prepend("mid")
        linkedList.prepend("tail")

        XCTAssertEqual(linkedList.tail, "tail")
        XCTAssertEqual(linkedList.head, "head")
    }

    func testTailAndHeadAreTheSameAfterPrependWhenOnlyOneNode() {
        var linkedList = LinkedList<String>()

        linkedList.prepend("one")

        XCTAssertEqual(linkedList.tail, linkedList.head)
    }

    func testPrependAddsDuplicateValues() {
        var linkedList = LinkedList<String>()
        linkedList.append("one")
        linkedList.append("two")
        linkedList.append("one")
        XCTAssertEqual(linkedList.tail, linkedList.head)
    }
    
    // MARK: - `prepend:value` CoW
    
    func testPrependOnCopyOnlyUpdatesCopy() {
        let linkedList: LinkedList = ["one", "two"]
        var linkedListCopy = linkedList
        
        linkedListCopy.prepend("zero")
        
        XCTAssertEqual(linkedListCopy._tail?.value, "zero")
        XCTAssertEqual(linkedListCopy._tail?.next?.value, "one")
        XCTAssertEqual(linkedListCopy._tail?.next?.next?.value, "two")
        XCTAssertEqual(linkedListCopy._head?.value, "two")
        XCTAssertNil(linkedListCopy._head?.next)
    }
    
    func testPrependOnCopyLeavesOriginalListUnchanged() {
        let linkedList: LinkedList = ["one", "two"]
        var linkedListCopy = linkedList
        
        linkedListCopy.prepend("zero")
        
        XCTAssertEqual(linkedList._tail?.value, "one")
        XCTAssertEqual(linkedList._tail?.next?.value, "two")
        XCTAssertNil(linkedList._tail?.next?.next)
        XCTAssertEqual(linkedList._head?.value, "two")
    }
    
    func testPrependOnCopyGeneratesANewListWithNewTailHeadReference() {
        let linkedList: LinkedList = ["one", "two"]
        var linkedListCopy = linkedList
        
        linkedListCopy.prepend("zero")
        
        XCTAssertFalse(linkedList._tail === linkedListCopy._tail)
        XCTAssertFalse(linkedList._head === linkedListCopy._head)
    }
    
    func testPrependOnEmptyCopyOnlyAppendsToCopy() {
        let linkedList: LinkedList<String> = []
        var linkedListCopy = linkedList
        
        linkedListCopy.prepend("Gollum")
        
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
        
        let removedValue = linkedList.removeFirst()
        XCTAssertEqual(removedValue, 1)
        XCTAssertEqual(linkedList._tail?.value, 2)
        XCTAssertEqual(linkedList.count, 4)
    }
    
    func testRemoveFirstWhenSingleElementNullifiesTailAndHead() {
        var linkedList: LinkedList = [1]
        
        let removedValue = linkedList.removeFirst()
        XCTAssertEqual(removedValue, 1)
        XCTAssertNil(linkedList._head)
        XCTAssertNil(linkedList._tail)
    }
    
    func testRemoveFirstReturnsFalseWhenListIsEmpty() {
        var linkedList: LinkedList<Int> = []
        
        let removedValue = linkedList.removeFirst()
        XCTAssertNil(removedValue)
    }
    
    // MARK: - `removeFirst` CoW
    
    func testRemoveFirstGeneratesNewListWhenMultipleReference() {
        let linkedList: LinkedList = [3, 5]
        var linkedListCopy = linkedList
        
        let removedValue = linkedListCopy.removeFirst()
        XCTAssertEqual(removedValue, 3)
        XCTAssertNotEqual(linkedList._tail, linkedListCopy._tail)
        XCTAssertNotEqual(linkedList._head, linkedListCopy._head)
    }
}
