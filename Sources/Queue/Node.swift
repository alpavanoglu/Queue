import Foundation

internal class Node<Value: Equatable>: Equatable, NSCopying {
    internal var value: Value
    internal var next: Node?
    
    internal init(_ value: Value) {
        self.value = value
    }
    
    internal static func == (lhs: Node<Value>, rhs: Node<Value>) -> Bool {
        return lhs.value == rhs.value
        && lhs.next === rhs.next
    }
    
    internal func copy(with zone: NSZone? = nil) -> Any {
        print("copy")
        let node = Node(value)
        if let nextCopy = next?.copy(with: zone) as? Node<Value> {
            node.next = nextCopy
        }
        return node
    }
}

