public struct LinkedList<Value> {
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init () {}

    public var isEmpty: Bool {
        return head == nil
    }
    
    public mutating func append(value: Value) {
        let newNode = Node(value: value)
        guard let head = head else {
            head = newNode
            tail = newNode
            return
        }
        
        head.next = newNode
        self.head = newNode
    }
}
