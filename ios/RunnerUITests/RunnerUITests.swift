import XCTest

class RunnerUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }

    func testTakeScreenshots() throws {
        let mainScreen = app.navigationBars.firstMatch
        _ = mainScreen.waitForExistence(timeout: 5)
        snapshot("01_Movements")

        let settingsButton = app.buttons["settings_button"]
        if settingsButton.exists {
            settingsButton.tap()
            sleep(1)
            snapshot("02_Settings")
        }

        let backButton = app.navigationBars.buttons.firstMatch
        if backButton.exists { backButton.tap() }

        let addExpenseButton = app.buttons["add_expense_button"]
        if addExpenseButton.exists {
            addExpenseButton.tap()
            sleep(1)
            snapshot("03_AddExpense")

            let cancelButton = app.buttons["cancel_button"]
            if cancelButton.exists { cancelButton.tap() }
        }

        let addIncomeButton = app.buttons["add_income_button"]
        if addIncomeButton.exists {
            addIncomeButton.tap()
            sleep(1)
            snapshot("04_AddIncome")
        }
    }
}
