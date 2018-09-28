# Allen's Hummingbird

## Introduction

Allen's Hummingbird, named for the eponymous Californian
**[bird](https://en.wikipedia.org/wiki/Allen%27s_hummingbird)**, is 
an R&D project to build a light and flexible testing class for Swift
coding interviews and simple projects.

## Usage

```
// Passing tests
// Nothing printed
TestThat("==")
  .returns(true, when: { 5 == 5 })
  .returns(false, when: { 5 == 7})
``` 

``` 
// Failing test
// Prints: "'==' FAILED test #1: expected 'false', but got 'true'."
TestThat("==")
  .returns(false, when: { 5 == 5})

```

