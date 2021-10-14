//
//  NewsAppUITests.swift
//  NewsAppUITests
//
//  Created by VN01-MAC-0006 on 24/09/2021.
//

import XCTest

class NewsAppUITests: XCTestCase {
    
    var app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launchArguments = ["-uitesting"]
        app.launch()
        
        
    }
    
    func testAddNewsSuccess_showDialog_openDetailView()  {
        //
        let title = "Những ai được bổ sung nhận hỗ trợ từ gói 26.000 tỉ đồng?"
        let content = "TTO - Ngày 14-10, Bộ Lao động, thương binh và xã hội cho biết Phó Thủ tướng Lê Minh Khái vừa ký ban hành nghị quyết 126 sửa đổi, bổ sung nghị quyết số 68 (gói 26.000 tỉ đồng) để hỗ trợ người lao động và doanh nghiệp khó khăn."
        let link = "https://tuoitre.vn/nhung-ai-duoc-bo-sung-nhan-ho-tro-tu-goi-26-000-ti-dong-20211014153318476.htm"
        
        //start
        XCTAssertTrue(app.otherElements["listNewsView"].waitForExistence(timeout: 5))
        
        
        let addButton = app.navigationBars.children(matching: .button).firstMatch
        XCTAssert(addButton.exists)
        addButton.tap()
        // Make sure  details view
        XCTAssertTrue(app.otherElements["addNewsView"].waitForExistence(timeout: 5))
        //Fill text field
        app.textFields["titleTextField"].tap()
        XCTAssert(app.keyboards.count > 0, "The keyboard could not be found. Use keyboard shortcut COMMAND + SHIFT + K while simulator has focus on text input")
        app.textFields["titleTextField"].typeText(title)
        //content tap
        app.textFields["contentTextField"].tap()
        app.textFields["contentTextField"].typeText(content)
        //
        
        app.textFields["linkDetail"].tap()
        app.textFields["linkDetail"].typeText(link)
        
        
        let datePickers = XCUIApplication().datePickers
        datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "October")
        datePickers.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "9")
        datePickers.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2021")
        //get button nav bar
        let saveButton = app.navigationBars.buttons["saveButton"]
        saveButton.tap()
        //test show dialog
        
        let alertDialog = app.alerts["Success"]
        XCTAssertTrue(alertDialog.waitForExistence(timeout: 5))
        
        alertDialog.buttons["Ok"].tap()
        
        //Move. to detail
        
        XCTAssertTrue( app.tables.cells.staticTexts[title].firstMatch.waitForExistence(timeout: 5))
        app.tables.cells.staticTexts[title].firstMatch.tap()
        XCTAssertTrue(app.otherElements["detailView"].waitForExistence(timeout: 5))
        sleep(5)
        app.webViews.firstMatch.swipeUp()
        
    }
    
    
    func testAddNewsCancel()  {
        //
        let title = "Những ai được bổ sung nhận hỗ trợ từ gói 26.000 tỉ đồng?"
        let content = "TTO - Ngày 14-10, Bộ Lao động, thương binh và xã hội cho biết Phó Thủ tướng Lê Minh Khái vừa ký ban hành nghị quyết 126 sửa đổi, bổ sung nghị quyết số 68 (gói 26.000 tỉ đồng) để hỗ trợ người lao động và doanh nghiệp khó khăn."
        let link = "https://tuoitre.vn/nhung-ai-duoc-bo-sung-nhan-ho-tro-tu-goi-26-000-ti-dong-20211014153318476.htm"
        
        //start
        XCTAssertTrue(app.otherElements["listNewsView"].waitForExistence(timeout: 5))
        
        
        let addButton = app.navigationBars.children(matching: .button).firstMatch
        XCTAssert(addButton.exists)
        addButton.tap()
        //        // Make sure  details view
        XCTAssertTrue(app.otherElements["addNewsView"].waitForExistence(timeout: 5))
        //Fill text field
        app.textFields["titleTextField"].tap()
        XCTAssert(app.keyboards.count > 0, "The keyboard could not be found. Use keyboard shortcut COMMAND + SHIFT + K while simulator has focus on text input")
        app.textFields["titleTextField"].typeText(title)
        //content tap
        app.textFields["contentTextField"].tap()
        app.textFields["contentTextField"].typeText(content)
        //
        
        app.textFields["linkDetail"].tap()
        app.textFields["linkDetail"].typeText(link)
        
        
        let datePickers = XCUIApplication().datePickers
        datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "October")
        datePickers.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "9")
        datePickers.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2021")
        //get button nav bar
        let saveButton = app.navigationBars.buttons["cancelButton"]
        saveButton.tap()
        
        //check whether back to listNews ?
        XCTAssertTrue(app.otherElements["listNewsView"].waitForExistence(timeout: 5))
        
        
    }
    

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
