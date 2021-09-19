# Swift Queue

A constant (O(1)) Queue implementation in Swift that favors Value Semantics. 

`Queue` and `LinkedList` are both value types (structs). `LinkedList` uses the reference type `Node`.
The copying only takes place on write operations `append:value`, `remove:value` and `removeFirst` when the list's tail is referenced more than once. Copying operates in linear **(O(n))** time as it copies the whole list recursively. This is an innate tradeoff we have to make when we want to favor Value Semantics. However, it only applies when the struct is copied AND mutated. If it is only modified via those functions or only shared and read, there is no copying that takes place. Thus, leaving `queue:value` and `enqueue:value` of `Queue` and `append:value`, `remove:value` and `removeFirst` functions of `LinkedList` to operate in constant time **(O(1))**.
