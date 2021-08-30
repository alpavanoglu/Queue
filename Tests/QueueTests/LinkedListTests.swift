import XCTest
@testable import Queue

final class LinkedListTests: XCTestCase {
    
    // MARK: - `init:arrayLiteral`
    func testInitArrayLiteralWithMultipleElementsConstructsLinkedList() {
        var linkedList: LinkedList = [1, 3, 4, 5]
        XCTAssertEqual(linkedList.tail!.value, 1)
        XCTAssertEqual(linkedList.head!.value, 5)
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
    
    // MARK: - `append:value`
    func testAppendUpdatesHeadElement() {
        var linkedList = LinkedList<String>()
        
        linkedList.append("next")
        
        XCTAssertEqual(linkedList.head?.value, "next")
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

        XCTAssertEqual(linkedList.tail?.value, "tail")
        XCTAssertEqual(linkedList.head?.value, "head")
    }
    
    func testTailAndHeadAreTheSameWhenOnlyOneNode() {
        var linkedList = LinkedList<String>()
        
        linkedList.append("one")
        
        XCTAssertEqual(linkedList.tail, linkedList.head)
    }
    
//    func testAsd() {
//        let linkedList = LinkedList<String>()
//        linkedList.head?.next = Node(value: "smth")
//    }
    
    // MARK: - `remove:at`

}
