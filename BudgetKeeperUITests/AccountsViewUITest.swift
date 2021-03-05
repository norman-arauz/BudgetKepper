import XCTest

class AccountsViewUITest: XCTestCase {
  let app = XCUIApplication()
  let currency = Locale.current.currencySymbol ?? "$"
  let separator = Locale.current.decimalSeparator ?? "."

  override func setUpWithError() throws {
    continueAfterFailure = false
    app.launch()
  }

  func testAddAccount() {
    app.buttons["add_account"].tap()

    XCTAssertEqual(app.navigationBars.staticTexts.firstMatch.label, localizedString("New Account"))

    app.textFields.firstMatch.tap()
    app.textFields.firstMatch.typeText("Savings")
    app.buttons["save"].tap()

    XCTAssertEqual(app.cells.count, 1)
    // since the cell content is wrapped into the navigation link, the element type is 'button'
    XCTAssertEqual(app.cells.buttons.firstMatch.label, "Savings\n\(currency)0\(separator)00")
  }

  func testDeleteAccount() {
    app.buttons["add_account"].tap()
    app.textFields.firstMatch.tap()
    app.textFields.firstMatch.typeText("Savings")
    app.buttons["save"].tap()

    let cell = app.cells.firstMatch
    cell.swipeLeft()
    cell.buttons.firstMatch.tap()

    XCTAssertEqual(app.cells.count, 0)
  }

  func testUpdateBalance() {
    app.buttons["add_account"].tap()
    app.textFields.firstMatch.tap()
    app.textFields.firstMatch.typeText("Savings")
    app.buttons["save"].tap()

    app.cells.firstMatch.tap()

    XCTAssertEqual(app.navigationBars.staticTexts.firstMatch.label, localizedString("Update Balance"))

    app.textFields.firstMatch.tap()
    app.textFields.firstMatch.typeText("-120")
    app.buttons["save"].tap()

    XCTAssertEqual(app.cells.buttons.firstMatch.label, "Savings\n-\(currency)120\(separator)00")

    app.cells.firstMatch.tap()
    app.textFields.firstMatch.tap()
    app.textFields.firstMatch.typeText("340")
    app.buttons["save"].tap()

    XCTAssertEqual(app.cells.buttons.firstMatch.label, "Savings\n\(currency)220\(separator)00")
  }

  func testMultipleAccounts() {
    app.buttons["add_account"].tap()
    app.textFields.firstMatch.tap()
    app.textFields.firstMatch.typeText("Savings")
    app.buttons["save"].tap()

    app.buttons["add_account"].tap()
    app.textFields.firstMatch.tap()
    app.textFields.firstMatch.typeText("Salary")
    app.buttons["save"].tap()

    app.cells.firstMatch.tap()
    app.textFields.firstMatch.tap()
    app.textFields.firstMatch.typeText("7620")
    app.buttons["save"].tap()

    app.cells.element(boundBy: 1).tap()
    app.textFields.firstMatch.tap()
    app.textFields.firstMatch.typeText("5455")
    app.buttons["save"].tap()

    XCTAssertEqual(app.cells.count, 2)
    XCTAssertEqual(app.cells.buttons.firstMatch.label, "Savings\n\(currency)7620\(separator)00")
    XCTAssertEqual(app.cells.element(boundBy: 1).buttons.firstMatch.label, "Salary\n\(currency)5455\(separator)00")
  }
}

func localizedString(_ key: String) -> String {
  let result = NSLocalizedString(key, bundle: Bundle(for: AccountsViewUITest.self), comment: "")
  return result
}
