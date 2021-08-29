import XCTest
@testable import Queue

final class LinkedListTests: XCTestCase {
    
    // MARK: - `isEmpty`
    func testIsEmptyReturnsTrueWhenHeadIsNil() {
        let linkedList = LinkedList<String>()
        XCTAssert(linkedList.isEmpty)
    }
    
    func testIsEmptyReturnsFalseWhenHeadIsNotNil() {
        var linkedList = LinkedList<String>()
        linkedList.append(value: "node")
        XCTAssertFalse(linkedList.isEmpty)
    }
    
    func testAppendUpdatesHeadValue() {
        var linkedList = LinkedList<String>()
        
        linkedList.append(value: "next")
        
        XCTAssertEqual(linkedList.head?.value, "next")
    }

    func testAppendUpdatesHeadReference() {
        var linkedList = LinkedList<String>()
        let head = linkedList.head
        
        linkedList.append(value: "next")
        
        XCTAssertNotEqual(head, linkedList.head)
    }
    
    func testTailsIsFirstAppendedNodeAfterTwoAppends() {
        var linkedList = LinkedList<String>()

        linkedList.append(value: "tail")
        linkedList.append(value: "mid")
        linkedList.append(value: "head")

        XCTAssertEqual(linkedList.tail?.value, "tail")
        XCTAssertEqual(linkedList.head?.value, "head")
    }

}
