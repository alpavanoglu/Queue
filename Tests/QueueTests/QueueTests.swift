import XCTest
@testable import Queue

final class QueueTests: XCTestCase {
    
    // MARK: - `enqueue:value`
    
    func testEnqueueAddsToTheBeginningOfTheList() {
        var queue = Queue<Int>()
        queue.enqueue(value: 1)
        queue.enqueue(value: 2)
        queue.enqueue(value: 3)
        XCTAssertEqual(queue.front, 1)
    }
    
}
