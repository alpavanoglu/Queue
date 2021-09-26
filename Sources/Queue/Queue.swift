public struct Queue<Value: Equatable>: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Value
    
    private var linkedList: LinkedList<Value> = []
    
    public var front: Value? {
        return linkedList.head
    }
    
    public var rear: Value? {
        return linkedList.tail
    }
    
    public var count: Int {
        return linkedList.count
    }
    
    public init () {}
    
    public init(arrayLiteral elements: Value...) {
        // Workaround due to splatting not being supported.
        typealias Function = ([Value]) -> LinkedList<Value>
        let linkedList = unsafeBitCast(
            LinkedList<Value>.init(arrayLiteral:),
            to: Function.self
        )
        self.linkedList = linkedList(elements)
    }
    
    public mutating func enqueue(value: Value) {
        linkedList.prepend(value)
    }
    
    @discardableResult
    public mutating func dequeue() -> Value? {
        linkedList.removeFirst()
    }
}
