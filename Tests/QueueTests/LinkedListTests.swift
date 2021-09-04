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
    
//    func testAsd() {
//        let linkedList = LinkedList<String>()
//        linkedList.head?.next = Node(value: "smth")
//    }
    
    // MARK: - `remove:at`

}
