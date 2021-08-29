public class Node<Value>: Equatable {
    public let value: Value
    public var next: Node?
    
    public init(value: Value) {
        self.value = value
    }
    
    public static func == (lhs: Node<Value>, rhs: Node<Value>) -> Bool {
        return lhs === rhs
    }
}

