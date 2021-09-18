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
    
    func testAppendGeneratesAFullCopyWhenNotUniquelyReferenced() {
        let linkedList: LinkedList = ["one", "two"]
        var linkedListCopy = linkedList
        
        linkedListCopy.append("three")
        
        XCTAssertEqual(linkedList.head, "two")
        XCTAssertEqual(linkedListCopy.head, "three")
    }
    
    func testRemoveLeavesTheCopyListConnected() {
        let linkedList: LinkedList = [1, 2, 3, 4, 5]
        var linkedListCopy = linkedList
        
        linkedListCopy.remove(value: 3)
        
        XCTAssertEqual(linkedList.count, 5)
        XCTAssertEqual(linkedListCopy.count, 4)
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
    
    // MARK: - CoW
    
//    func testCopyOnWriteOnAppend() {
//        let linkedList: LinkedList = ["a", "b", "c"]
//        var linkedListCopy = linkedList
//
//        linkedListCopy.append("d")
//
//        XCTAssertEqual(linkedList.head, "c")
//        XCTAssertEqual(linkedListCopy.head, "d")
//    }
//
//    func testCopyOnWriteOnSubscript() {
//        let linkedList: LinkedList = ["a", "b", "c"]
//        var linkedListCopy = linkedList
//
//        linkedListCopy[2] = "d"
//
//        XCTAssertEqual(linkedList.head, "c")
//        XCTAssertEqual(linkedListCopy.head, "d")
//    }

}
