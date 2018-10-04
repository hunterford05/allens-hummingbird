# Allen's Hummingbird

## Introduction

Allen's Hummingbird, named for the eponymous Californian
**[bird](https://en.wikipedia.org/wiki/Allen%27s_hummingbird)**, is 
an R&D project to build a light and flexible testing class for Swift
coding interviews and simple projects.

For example:

```swift

func hello(_ name: String = "Puffins")->String{
  return "Hello, \(name)!"
}

TestThat({ hello() })
  .returns("Hello, Puffins!", if: ()) // Test passes
  .returns("Hello, World!", if: ())   // Test fails: message printed

TestThat({ hello($0) })
  .returns("Hello, Puflavík!", if: "Puflavík")  // Test passes
  .returns("Hello, Puffins!", if: "Puflavík")   // Test fails: message
                                                //  printed

```

## Usage

### Initializing A Test

The `TestThat` initializer takes a single argument:

- **_**: `(Inputs)->Result` — A test to run.  `Inputs` and `Result` are
  generic types that will be inferred based on the closure passed in. 
  `Result` must be `Equatable`.

For example:

```swift
func helloPuffins()->String{
  return "Hello, Puffins!"  
}

let t = TestThat({ helloPuffins() })
```
The resulting `TestThat` instance will have a test that expects no 
input and returns a `String`.

On the other hand, consider:


```swift

func hello(_ name: String)->String{
  return "Hello, \(name)!"
}

let t = TestThat({ 
  input in
  return hello(input)
})
```
The resulting `TestThat` instance will have a test that expects input
of the type `String` and that returns an `String`.


### Running A Test Case

Use the `returns()` method to run a specific test case.  This method
takes the following arguments:

- **_**: `Result` — The correct (expected) result of running the test
  case.  `Result` is a generic type inferred from the test closure
  passed the `TestThat` initializer
- **if**: `Inputs` — The inputs to give to the test.  `Inputs` is a 
  generic type inferred from the test closure passed to the `TestThat`
  initializer.

For example:

```swift
func helloPuffins()->String{
  return "Hello, Puffins!"
}

let t = TestThat({ 
  helloPuffins() 
})

t.returns("Hello, Puffins!", if: ())  // Test passes: nothing printed
t.returns("Hi, Puffins!", if: ())     // Test fails: message printed

```

In this case, `Result` is inferred to be `String` and `Inputs` is
inferred to be `()`.

Here is another example with test inputs:

```swift
func hello(firstName: String, lastName: String)->String{
  return "Hello, \(firstName) \(lastName)!"
}

let t = TestThat({
  name in
  hello(firstName: name.first, lastName: name.last)
})

// Test passes: nothing printed
t.returns("Hello, Puflavík Lundason!", if: (first: "Puflavík", 
 last: "Lundason"))

// Test fails: message printed
t.returns("Hello, Puflavík Ford!", if: (first: "Puflavík",
 last: "Lundason"))
```
In this case, `Result` is inferred to be `String` and `Inputs` is
inferred to be `(first: String, last: String)`

### Syntactic Sugar

Allens Hummingbird supports method chaining to make tests fast and 
intuitive to write and understand.

For example:

```swift

func currentDate(month: String, day: Int)->String{
  return "Today is \(month) \(day)."
}

TestThat({ currentDate(month: $0.month, $0.day) })
 .returns("Today is March 11.", if: (month: "March", day: 11))
 .returns("Today is January 25.", if: (month: "January", day: 25))
```

`TT` may also be used as an abbreviation for `TestThat`:

```swift
TT({ $0.0 == $0.1 })
  .returns(true, if: (5,5))
  .returns(false, if: (3,11))
```
