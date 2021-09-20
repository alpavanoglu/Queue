# Swift Queue 
[![Swift](https://img.shields.io/badge/-Swift-fff?&logo=Swift)](https://swift.org/) [![SwiftPM](https://img.shields.io/badge/SwiftPM-Compatible-orange)](https://swift.org/package-manager/) [![Platforms](https://img.shields.io/badge/Platforms-macOS%20iOS%20watchOS%20tvOS-ec83b8)](https://developer.apple.com/discover/) [![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)


A Queue implementation in Swift with constant (O(1)) time `enqueue` and `dequeue` operations that favors Value Semantics. 

`Queue` and `LinkedList` are both value types (structs). `LinkedList` uses the reference type `Node`.
The copying only takes place on write operations `append:value`, `remove:value` and `removeFirst` when the list's tail is referenced more than once. Copying operates in linear **(O(n))** time as it copies the whole list recursively. This is an innate tradeoff we have to make when we want to favor Value Semantics. However, it only applies when the struct is copied AND mutated. If it is only modified via those functions or only shared and read, there is no copying that takes place. Thus, leaving `queue:value` and `enqueue:value` of `Queue` and `append:value` and `removeFirst` functions of `LinkedList` to operate in constant time **(O(1))**.
