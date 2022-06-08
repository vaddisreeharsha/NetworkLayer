//
//  UserListVMtest.swift
//  NetworkSwiftUiTests
//
//  Created by Sree Harsha Vaddi on 08/06/22.
//

@testable import NetworkSwiftUi
import XCTest

class UserListVMtest: XCTestCase {
    var viewModel: UserListVM?
    private func configureMockService(withError showError: Bool = false) {
        let mockservice = MockUserSevice(showError: showError)
        viewModel = UserListVM(userService: mockservice)
    }

    func testFetchUsersSuccessResponse() throws {
        configureMockService()
        let exp = expectation(description: "SUCCESS")
        viewModel?.fetchUsers()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        let listOfUsers = try XCTUnwrap(viewModel?.listOfUsers)
        XCTAssertEqual(listOfUsers.count, 3)
        let user1 = try XCTUnwrap(listOfUsers.first)
        XCTAssertEqual(user1.name, "Leanne Graham")
        XCTAssertNotNil(user1.company)
        XCTAssertNil(viewModel?.errorMessage)
    }
    
    func testFetchUsersFailureResponse() throws {
        configureMockService(withError: true)
        let exp = expectation(description: "SUCCESS")
        viewModel?.fetchUsers()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        let listOfUsers = try XCTUnwrap(viewModel?.listOfUsers)
        let errorMessage  = try XCTUnwrap(viewModel?.errorMessage)
        XCTAssertEqual(listOfUsers.count, 0)
        XCTAssertNotNil(errorMessage)
    }
}
