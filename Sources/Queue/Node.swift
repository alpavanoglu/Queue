import Foundation

public class Node<Value: Equatable>: NSCopying, Equatable {
    public let value: Value
    public var next: Node?
    
    public init(_ value: Value) {
        self.value = value
    }
    
    public static func == (lhs: Node<Value>, rhs: Node<Value>) -> Bool {
        return lhs.value == rhs.value
        && lhs.next === rhs.next
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = Node<Value>(value)
        copy.next = next
        return copy
    }
}

