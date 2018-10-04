import Foundation

/// A minimalist testing tool with a focus on flexibility and intuitive
///  syntax.
public class TT<Inputs,Result: Equatable>{

  /// A `Test` is a closure that takes in generic `Inputs` and returns
  ///  a generic (but `Equatable`) `Result` 
  public typealias Test = (Inputs)->Result
  
  /// Test case to run
  var test: Test 
  /// Test counter — useful for showing which test(s) fail
  var counter: Int = 0
  /// Name of what is being tested (e.g. "foo()")
  let name: String

  /**
    Initializes a `TT` testing tool with the provided test case and
     subject name.

    - Parameters:
      - _: The name of whatever is being tested (e.g. "foo()")
      - when: The `Test` to run

    - Returns: A shiny new `TT` testing tool instance
  */
  public init(_ name: String, when test: @escaping Test){
    self.test = test
    self.name = name 
  }
  
  /**
    Run a test.

    Increments the test counter and performs the test with the given
     inputs: if the result is incorrect, print an error message 
     identifying the failing test as well as the expected and actual
     outputs.

    - Parameters:
      - is: The expected result
      - if: The input

    - Returns: This `TT` instance
  */
  @discardableResult public func it(is expected: 
   Result, if inputs: Inputs)->TT<Inputs,Result>{
    counter += 1
    let result = self.test(inputs)
    if result != expected {
      print("'\(name)' FAILED test #\(counter): " + 
       "expected: '\(expected)', but got '\(result)'.")
    }
    return self
  }
}
