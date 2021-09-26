# Swift Queue 
[![Swift](https://img.shields.io/badge/Swift-100%25-orange?logo=swift&style=flat)](https://swift.org/) [![SwiftPM](https://img.shields.io/badge/SwiftPM-Compatible-red)](https://swift.org/package-manager/) [![Platforms](https://img.shields.io/badge/Platforms-macOS%20iOS%20watchOS%20tvOS-ec83b8)](https://developer.apple.com/discover/) [![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)


A Queue implementation in Swift with constant (O(1)) time `enqueue` and `dequeue` operations that adopts Value Semantics. 

## Overview
`Queue` and `LinkedList` are both value types (structs). `LinkedList` is composed of `Node`s to refer to the next node.  

Queue adopts Value Semantics while also maintaining the constant time operations.
The copying only takes place on write (mutating) operations when the list's tail is referenced more than once. Copying operates in linear **(O(n))** time as it copies the whole list recursively. This is an innate tradeoff we have to make when we want to adopt Value Semantics. However, it only applies when the struct is copied AND mutated. 

If it is modified via those functions or only shared and read, there is no copying that takes place. Thus, leaving `queue:value` and `enqueue:value` of `Queue` and `append:value`, `prepend:value`, `removeFirst` functions of `LinkedList` to operate in constant time **(O(1))**.

## Installation
Add it to your Package list:  
Xcode -> File -> Add Packages -> Paste the Repo URL to Search { https://github.com/alpavanoglu/Queue }

Or you can simply copy over the `Queue.swift` along with `LinkedList.swift`.

## Usage
Construct with an empty initializer:
```Swift
let queue: Queue<Int> = []
```
Or an Array:
```Swift
let queue: Queue = ["one", "two", "three"]
```
Access the front and rear of the Queue as:
```Swift
let queue: Queue = ["one", "two", "three"]
queue.front // "three"
queue.rear // "one"
```
Enqueue:
```Swift
queue.enqueue("zero") // ["zero", "one", "two", "three"]
```
And dequeue:
```Swift
queue.enqueue("dequeue") // ["zero", "one", "two",]
```
