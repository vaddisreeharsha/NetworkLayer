//
//  UserDetailVMTests.swift
//  NetworkSwiftUiTests
//
//  Created by Sree Harsha Vaddi on 08/06/22.
//

@testable import NetworkSwiftUi
import XCTest

class UserDetailVMTests: XCTestCase {
    var viewModel: UserDetailVM?
    let user = User(
        id: 1,
        name: "Leanne Graham",
        username: "Bret",
        email: "Sincere@april.biz",
        company: nil
    )
    private func configureMockService(withError showError: Bool = false) {
        let mockservice = MockPostService(showError: showError)

        viewModel = UserDetailVM(user: user, postService: mockservice)
    }

    // MARK: - Api test case methods

    func testFetchPostsSuccessResponse() throws {
        configureMockService()
        let exp = expectation(description: "SUCCESS")
        viewModel?.fetchPosts(userId: user.id)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        let listOfPosts = try XCTUnwrap(viewModel?.listOfPosts)
        XCTAssertEqual(listOfPosts.count, 4)
        let post1 = try XCTUnwrap(listOfPosts.first)
        XCTAssertEqual(viewModel?.user.name, "Leanne Graham")
        XCTAssertEqual(post1.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        XCTAssertNil(viewModel?.errorMessage)
    }

    func testFetchUsersFailureResponse() throws {
        configureMockService(withError: true)
        let exp = expectation(description: "Failure")
        viewModel?.fetchPosts(userId: user.id)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        let listOfPosts = try XCTUnwrap(viewModel?.listOfPosts)
        let errorMessage = try XCTUnwrap(viewModel?.errorMessage)
        XCTAssertEqual(listOfPosts.count, 0)
        XCTAssertNotNil(errorMessage)
    }

    // MARK: - URL test case methods

    func testInvalidUrl() {
        let apiService = ApiService()
        let url = URL(string: "/badUrl")
        let exp = expectation(description: "bad url")
        var urlError: ApiError?
        var listOfUsers: [User]?
        apiService.fetchData([User].self, url: url) { result in
            switch result {
            case .failure(let error):
                urlError = error
            case .success(let users):
                listOfUsers = users
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        XCTAssertNil(listOfUsers)
        XCTAssertNotNil(urlError)
        XCTAssertEqual(urlError?.localizedDescription, "unsupported URL")
    }

    func testInvalidResponse() throws {
        let apiService = ApiService()
        let url = URL(string: ApiEndPoints.users.path + "/badUrl")
        let exp = expectation(description: "Invalid Response")
        var responseError: ApiError?
        var listOfUsers: [User]?
        apiService.fetchData([User].self, url: url) { result in
            switch result {
            case .failure(let error):
                responseError = error
            case .success(let users):
                listOfUsers = users
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        XCTAssertNil(listOfUsers)
        XCTAssertNotNil(responseError)
        let response = try XCTUnwrap(responseError)
        XCTAssertTrue(response.description.contains("bad response"))
    }
}
