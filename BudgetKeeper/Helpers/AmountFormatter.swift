import Foundation

enum AmountFormatter {
  private static let amountFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter
  }()

  static func string(from decimal: Decimal) -> String? {
    return amountFormatter.string(from: decimal)
  }

  static func decimal(from string: String) -> Decimal? {
    return amountFormatter.number(from: string)?.decimalValue
  }
}

extension NumberFormatter {
  func string(from decimal: Decimal) -> String? {
    return self.string(from: decimal as NSDecimalNumber)
  }
}
