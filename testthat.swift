import Foundation

public class TestThat{

  /// Name of this test subject
  let subjectName: String

  /// Current test count
  var testCounter: Int = 0
  
  /**
    Initializes a new `TestThat` object with the given test subject
    name.

    - Parameters:
      - testSubjectNameHere: The name of this test's subject
  */
  init(_ testSubjectNameHere: String){
    self.subjectName = testSubjectNameHere
  }

  /**
    Execute a block of code and compare the result with the expected
    one; if the result is not a match, print a helpful message.

    - Parameters:
      - expected: The expected result
      - test: The block of code to run

    - Returns: This `TestThat` instance (allows for chaining)

  */
  @discardableResult func returns<Result: Equatable>(_ expected: Result, 
   when test: ()->Result)->TestThat{
    self.testCounter += 1
    let result = test()
    if result != expected {
      print("'\(self.subjectName)' FAILED test #\(self.testCounter) " +
       "expected '\(expected)', but got '\(result)'.")
    }
    return self
  }
}

public class TT<Inputs>{

  public typealias TestCase = (Inputs)->Any

  var test: (Inputs)->Any
  let subjectName: String
  var testCounter: Int = 0

  public init(_ testSubjectNameHere: String, 
   when test: @escaping TestCase){
    self.test = test
    self.subjectName = testSubjectNameHere
  }

  @discardableResult public func it<Result: Equatable>(is expected: 
   Result, if inputs: Inputs)->TT{
    self.testCounter += 1
    let rawResult = self.test(inputs)
    guard let result = rawResult as? Result, 
     result == expected else {
      print("\(self.subjectName) FAILED test #\(self.testCounter): " + 
       "expected: '\(expected)', but got '\(rawResult)'.")
      return self
    }
    return self
  }

}


