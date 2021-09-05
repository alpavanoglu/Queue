public struct Queue<Value: Equatable> {
    private var linkedList: LinkedList<Value> = []
    
    public var front: Value? {
        return linkedList.tail
    }
    
    public var rear: Value? {
        return linkedList.head
    }
    
    public mutating func enqueue(value: Value) {
        linkedList.append(value)
    }
    
//    public func dequeue() -> Value {
//        
//    }
}
