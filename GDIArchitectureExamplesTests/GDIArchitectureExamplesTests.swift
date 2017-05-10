//
//  GDIArchitectureExamplesTests.swift
//  GDIArchitectureExamplesTests
//
//  Created by Stephanie Guevara on 5/8/17.
//  Copyright © 2017 GirlDevelopIt. All rights reserved.
//

@testable import GDIArchitectureExamples
import XCTest
import Nimble

class MyTableViewPresenterTests: XCTestCase {
    //By writing modular code, we are able to isolate the buisiness logic in the presenter and test alone
    //Because the view is "dumb", we can pass in a fake view. This means we do not have to stub out its lifecycle events or import any UI dependencies
    var presenter: MyViewControllerPresenter!
    
    var fakeViewController: FakeMyViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //All of the logic for our table comes from the presenter. There is nothing to test in our UI!
        fakeViewController = FakeMyViewController()
        
        presenter = MyViewControllerPresenter(view:fakeViewController)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_didTapTableViewCell_whenRowIsEven_shouldChangeHeaderBackgroundColor() {
        presenter.didTapTableViewCell(at: 2)
        
        expect(self.fakeViewController.changeHeaderBackgroundColorSpyCount).to(equal(1))
    }
    
    func test_didTapTableViewCell_whenRowIsOddAndNot11_shouldChangeTextColor() {
        presenter.didTapTableViewCell(at: 1)
        
        expect(self.fakeViewController.changeHeaderTextColorSpyCount).to(equal(1))
    }
    func test_didTapTableViewCell_whenRowDividedBt3HasRemainderOf2AndGreaterThanOrEqualTo5_shouldShowAlert() {
        presenter.didTapTableViewCell(at: 11)
        
        expect(self.fakeViewController.showAlertSpyCount).to(equal(1))
        expect(self.fakeViewController.showAlertSpyTitleArg).to(equal("You're a winner!"))
        //Should we ever change the text of our alert, our test will remind us to fix it! Wohoo!
        expect(self.fakeViewController.showAlertSpyMessageArg).to(equal("You're awesome!"))
    }
}


//The use of protocols allows us to easily mock out our UI elements and stub out their return values
//Without having to import UIKit
class FakeMyViewController: MyViewControllerViewDelegate {
    var presenter: MyViewControllerPresentationDelegate!
    var tableArray: [String]!
    
    var changeHeaderBackgroundColorSpyCount = 0
    func changeHeaderBackgroundColor() {
        changeHeaderBackgroundColorSpyCount += 1
    }
    
    var changeHeaderTextColorSpyCount = 0
    func changeHeaderTextColor() {
        changeHeaderTextColorSpyCount += 1
    }
    
    var showAlertSpyTitleArg: String!
    var showAlertSpyMessageArg: String!
    var showAlertSpyActionTitleArg: String!
    var showAlertSpyCount = 0
    func showAlert(title: String, message: String, actionTitle: String) {
        showAlertSpyCount += 1
        showAlertSpyTitleArg = title
        showAlertSpyMessageArg = message
        showAlertSpyActionTitleArg = actionTitle
    }
}
