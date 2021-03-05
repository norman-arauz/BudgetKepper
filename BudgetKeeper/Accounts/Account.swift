import Foundation

struct Account {
  let name: String
  var balance: Decimal = 0.0

  mutating func updateBalance(by amount: Decimal) {
    balance += amount
  }
}
