import Foundation

/// Shorthand for `TestThat` 
public typealias TT = TestThat

/// A minimalist testing tool with a focus on flexibility and intuitive
///  syntax.
public class TestThat<Inputs,Result: Equatable>{

  /// A `Test` is a closure that takes in generic `Inputs` and returns
  ///  a generic (but `Equatable`) `Result` 
  public typealias Test = (Inputs)->Result
  
  /// Test case to run
  var test: Test 
  /// Test counter — useful for showing which test(s) fail
  var counter: Int = 0

  /**
    Initializes a `TestThat` testing tool with the provided test case and
     subject name.

    - Parameters:
      - when: The `Test` to run

    - Returns: A shiny new `TestThat` testing tool instance
  */
  public init(_ test: @escaping Test){
    self.test = test
  }
  
  /**
    Run a test.

    Run the test with the given inputs: if the result is incorrect,
     print an error message identifying the failing test as well as the 
     expected and actual outputs.

    - Parameters:
      - _: The expected result
      - if: The input

    - Returns: This `TestThat` instance
  */
  @discardableResult public func returns(_ expected: 
   Result, if inputs: Inputs)->TestThat<Inputs,Result>{
    counter += 1
    let result = self.test(inputs)
    if result != expected {
      print("FAILED test #\(counter): " + 
       "expected: '\(expected)', but got '\(result)'.")
    }
    return self
  }
}

