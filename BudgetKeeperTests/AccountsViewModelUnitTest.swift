import XCTest
@testable import BudgetKeeper

class AccountsViewModelUnitTest: XCTestCase {
  func testAccountsListEmpty() {
    let viewModel = AccountsViewModel()

    XCTAssertTrue(viewModel.accounts.isEmpty)
  }

  func testAddNewAccount() {
    let viewModel = AccountsViewModel()

    viewModel.create(account: "Debit card")

    XCTAssertEqual(viewModel.accounts.count, 1)
    XCTAssertEqual(viewModel.accounts.first?.name, "Debit card")
    XCTAssertEqual(viewModel.accounts.first?.balance, 0)
  }

  func testDeleteAccount() {
    let viewModel = AccountsViewModel()
    viewModel.create(account: "Salary")

    viewModel.delete(at: IndexSet(arrayLiteral: 0))

    XCTAssertTrue(viewModel.accounts.isEmpty)
  }

  func testUpdateBalance() {
    let viewModel = AccountsViewModel()
    viewModel.create(account: "Savings")

    viewModel.updateBalance(at: 0, by: -300)

    XCTAssertEqual(viewModel.accounts.first?.balance, -300)

    viewModel.updateBalance(at: 0, by: 450)

    XCTAssertEqual(viewModel.accounts.first?.balance, 150)
  }

  func testMultipleAccounts() {
    let viewModel = AccountsViewModel()

    viewModel.create(account: "Salary")
    viewModel.create(account: "Credit card")
    viewModel.create(account: "Savings")

    viewModel.delete(at: IndexSet(arrayLiteral: 1))
    viewModel.updateBalance(at: 1, by: 150)

    XCTAssertEqual(viewModel.accounts.count, 2)
    XCTAssertEqual(viewModel.accounts.map { $0.name }, ["Salary", "Savings"])
    XCTAssertEqual(viewModel.accounts[0].balance, 0)
    XCTAssertEqual(viewModel.accounts[1].balance, 150)
  }
}
