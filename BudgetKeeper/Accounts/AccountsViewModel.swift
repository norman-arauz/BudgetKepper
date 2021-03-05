import SwiftUI

final class AccountsViewModel: ObservableObject {
  @Published private(set) var accounts: [Account] = []

  func create(account: String) {
    accounts.append(Account(name: account))
  }

  func delete(at offsets: IndexSet) {
    accounts.remove(atOffsets: offsets)
  }

  func updateBalance(at index: Int, by amount: Decimal) {
    accounts[index].updateBalance(by: amount)
  }
}
