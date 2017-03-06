# UtilitiesInSwift

[![CI Status](http://img.shields.io/travis/steveaxelrod007/UtilitiesInSwift.svg?style=flat)](https://travis-ci.org/steveaxelrod007/UtilitiesInSwift)
[![Version](https://img.shields.io/cocoapods/v/UtilitiesInSwift.svg?style=flat)](http://cocoapods.org/pods/UtilitiesInSwift)
[![License](https://img.shields.io/cocoapods/l/UtilitiesInSwift.svg?style=flat)](http://cocoapods.org/pods/UtilitiesInSwift)
[![Platform](https://img.shields.io/cocoapods/p/UtilitiesInSwift.svg?style=flat)](http://cocoapods.org/pods/UtilitiesInSwift)

## Example
Utility functions for swift that have been created through the years.  Some converted from other languages.  
The utilities are broken down by type categories (I did what I thought was ok).

Queues --> I mainly created these so as Swift morphs, I can easily adjust the function bodies and not all over the code base, plus, I may want to add later functionality.

NumbersToWords --> Converts a number String "$1,234.56" to "one thousand two hundred thirty four dollars and 56/100"

      let words = NumbersToWords.convert(amount: "1.31") 
      print(words)
      One Dollar and 31/100
      
      let words = NumbersToWords.convert(amount: "9,304.67") 
      print(words)
      nine thousand three hundred four dollars and 67/100
      
      amount can be 0.01 ... 999,999.99  nine hundred ninety nine thousand nine hundred ninety nine dollars and 99/100



## Requirements

## Installation

UtilitiesInSwift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "UtilitiesInSwift"
```

## Author

steveaxelrod007, steve@axelrod.net

## License

UtilitiesInSwift is available under the MIT license. See the LICENSE file for more info.
