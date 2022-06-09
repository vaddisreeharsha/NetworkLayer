//
//  ContentView.swift
//  NetworkSwiftUi
//
//  Created by Sree Harsha Vaddi on 07/06/22.
//

import SwiftUI

/// User List View
struct UserListView: View {
    /// View model object
    @StateObject var viewModel = UserListVM()

    var body: some View {
        if viewModel.isLoading {
            /// showing progress view until we get Api response
            ProgressView()
        } else {
            NavigationView {
                /// If response is not valid then shows the error message other wise show the users list
                if viewModel.errorMessage != nil {
                    Text(viewModel.errorMessage ?? "")
                } else {
                    userList
                }
            }
            .navigationViewStyle(.stack)
        }
    }

    /// User list view
    private var userList: some View {
        List {
            ForEach(viewModel.listOfUsers) { user in
                NavigationLink {
                    /// On clicking the cell need to navigate to user detail view
                    UserDetailView(user: user)
                } label: {
                    /// shows User Cell
                    UserCellView(user: user)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Users")
    }
}

/// User cell view
struct UserCellView: View {
    /// User data
    let user: User

    var body: some View {
        VStack(alignment: .leading) {
            Text(user.name ?? "")
                .font(.headline)
            Text(user.email)
                .foregroundColor(.gray)
                .font(.subheadline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
