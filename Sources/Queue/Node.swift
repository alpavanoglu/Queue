import Foundation

internal class Node<Value: Equatable>: Equatable {
    internal let value: Value
    internal var next: Node?
    
    internal init(_ value: Value) {
        self.value = value
    }
    
    internal static func == (lhs: Node<Value>, rhs: Node<Value>) -> Bool {
        return lhs.value == rhs.value
        && lhs.next === rhs.next
    }
}

