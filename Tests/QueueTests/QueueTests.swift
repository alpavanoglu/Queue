import XCTest
@testable import Queue

final class QueueTests: XCTestCase {
    
    // MARK: - `init:arrayLiteral`
    
    func testInitArrayLiteralFrontEqualToLastValue() {
        let queue: Queue = [1, 2, 4]
        XCTAssertEqual(queue.front, 4)
    }
    
    // MARK: - `enqueue:value`
    
    func testEnqueueAddsToTheBeginningOfTheList() {
        var queue = Queue<Int>()
        queue.enqueue(value: 1)
        queue.enqueue(value: 2)
        queue.enqueue(value: 3)
        XCTAssertEqual(queue.front, 1)
        XCTAssertEqual(queue.rear, 3)
    }
    
    func testEnqueueCoW() {
        let queue: Queue = [1, 2, 4]
        var queueCopy = queue
        queueCopy.enqueue(value: 0)
        
        XCTAssertEqual(queue.front, 4)
        XCTAssertEqual(queue.rear, 1)
        XCTAssertEqual(queueCopy.front, 4)
        XCTAssertEqual(queueCopy.rear, 0)
    }
    
    // MARK: - `dequeue`
    
    func testDequeueDecrementsTheCount() {
        var queue: Queue = ["and", "it", "makes", "me", "wonder"]
        queue.dequeue()
        XCTAssertEqual(queue.count, 4)
    }
    
    func testDequeueRemovesTheRearValue() {
        var queue: Queue = ["and", "it", "makes", "me", "wonder"]
        let dequeuedValue = queue.dequeue()
        
        XCTAssertEqual(dequeuedValue, "and")
    }
    
    // MARK: - `peek`
    
    func testPeekReturnsTrueForElementThatExists() {
        let queue: Queue = ["and", "it", "makes", "me", "wonder"]
        XCTAssertTrue(queue.peek("it"))
    }
    
    func testPeekReturnsFalseForElementThatDoesNotExist() {
        let queue: Queue = ["and", "it", "makes", "me", "wonder"]
        XCTAssertFalse(queue.peek("stairway"))
    }
}
