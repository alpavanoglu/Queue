public struct LinkedList<Value: Equatable>: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Value
    
    private(set) var head: Value?
    private(set) var tail: Value?

    var _head: Node<Value>? {
        didSet {
            head = _head?.value
        }
    }
    
    var _tail: Node<Value>? {
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
    
    public func peek(for value: Value) -> Bool {
        var tempNode = _tail
        while tempNode != nil {
            if tempNode?.value == value {
                return true
            }
            tempNode = tempNode?.next
        }
        
        return false
    }
        
    public mutating func append(_ value: Value) {
        count += 1
        
        let newNode = Node(value)
        guard let _head = _head else {
            _head = newNode
            _tail = newNode
            return
        }
        
        if isKnownUniquelyReferenced(&_tail) {
            _head.next = newNode
            self._head = newNode
        } else {
            // FIXME: Force unwrap
            _tail = _tail!.copy() as? Node<Value>
            append(value)
        }
        
    }
    
    @discardableResult
    public mutating func remove(value: Value) -> Bool {
        guard _tail != nil else {
            return false
        }
        
        // Check if the tail has a match.
        guard tail != value else {
            _tail = _tail?.next
            count -= 1
            return true
        }
        
        var tempNode = _tail
        var nextNode = tempNode?.next
        
        while nextNode != nil {
            if nextNode?.value == value {
                count  -= 1
                
                // Check if `nextNode` is `_head`.
                guard nextNode != _head else {
                    // Update `_head` and nullify `nextNode`
                    _head = tempNode
                    nextNode = nil
                    return true
                }
                
                tempNode?.next = nextNode?.next
                nextNode = nil
                return true
            } else {
                tempNode = nextNode
                nextNode = nextNode?.next
            }
        }
        return false
    }
    
//    public subscript(_ index: UInt) -> Value? {
//        get {
//            return findNode(at: index)?.value
//        } set {
//            guard let newValue = newValue else {
//                return
//            }
//            let node = findNode(at: index)
//            node?.value = newValue
//        }
//    }
//
//    private func findNode(at index: UInt) -> Node<Value>? {
//        var temp = _tail
//        for _ in 0..<index {
//            guard temp != nil else {
//                return nil
//            }
//
//            temp = temp?.next
//        }
//        return temp
//    }
}
