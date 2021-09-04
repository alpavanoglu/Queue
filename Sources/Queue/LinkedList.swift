public struct LinkedList<Value: Equatable>: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Value
    
    private(set) var head: Value?
    private(set) var tail: Value?

    private var _head: Node<Value>? {
        didSet {
            head = _head?.value
        }
    }
    private var _tail: Node<Value>? {
        didSet {
            tail = _tail?.value
        }
    }
    
    public var isEmpty: Bool {
        return _head == nil
    }

    public var count: Int = 0
    
    public init () {}
    
    public init(arrayLiteral elements: Value...) {
        guard let first = elements.first else {
            head = nil
            return
        }
        
        var node = Node(first)
        _tail = node
        tail = _tail?.value
        
        count += 1
        
        for value in elements[1..<elements.endIndex] {
            let next = Node(value)
            
            node.next = next
            node = next
            
            count += 1
        }
        _head = node
        head = _head?.value
    }
        
    public mutating func append(_ value: Value) {
        count += 1
        
        let newNode = Node(value)
        guard let _head = _head else {
            _head = newNode
            _tail = newNode
            return
        }
        
        _head.next = newNode
        self._head = newNode
    }
    
    public mutating func removeFirst(value: Value) {
        count -= 1
    }
}
