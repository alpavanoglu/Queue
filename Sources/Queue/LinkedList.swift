public struct LinkedList<Value: Equatable>: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Value
    
    private var _head: Node<Value>?
    public var head: Node<Value>? {
        mutating get {
            if !isKnownUniquelyReferenced(&_head) {
                _head = _head?.copy() as? Node<Value>
            }
            return _head
        } set {
            _head = newValue
        }
    }
    
    private var _tail: Node<Value>?
    public var tail: Node<Value>? {
        mutating get {
            if !isKnownUniquelyReferenced(&_tail) {
                _tail = _tail?.copy() as? Node<Value>
            }
            return _tail
        } set {
            _tail = newValue
        }
    }
    
    
    public init () {}
    
    public init(arrayLiteral elements: Value...) {
        guard let first = elements.first else {
            head = nil
            return
        }
        
        var node = Node(first)
        tail = node
        for value in elements[1..<elements.endIndex] {
            let next = Node(value)
            
            node.next = next
            node = next
        }
        head = node
    }
    
    public var isEmpty: Bool {
        return _head == nil
    }
    
    public mutating func append(_ value: Value) {
        let newNode = Node(value)
        guard let _head = _head else {
            _head = newNode
            tail = newNode
            return
        }
        
        _head.next = newNode
        self._head = newNode
    }
    
    public mutating func remove(at index: Int) {
        
    }
}
