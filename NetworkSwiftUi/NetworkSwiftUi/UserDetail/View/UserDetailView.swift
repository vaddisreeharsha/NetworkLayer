//
//  UserDetailView.swift
//  NetworkSwiftUi
//
//  Created by Sree Harsha Vaddi on 08/06/22.
//

import SwiftUI

/// User detail View
struct UserDetailView: View {
    /// View model
    @ObservedObject var viewModel: UserDetailVM

    /// Initializer
    init(user: User) {
        viewModel = UserDetailVM(user: user)
    }

    var body: some View {
        if viewModel.isLoading {
            /// showing progress view until we get Api response
            ProgressView()
        } else if viewModel.errorMessage == nil {
            listOfPosts
        } else {
            /// If response is not valid then shows the error message
            Text(viewModel.errorMessage ?? "")
        }
    }

    /// List of posts
    private var listOfPosts: some View {
        List {
            Section {
                ForEach(viewModel.listOfPosts) { post in
                    PostCellView(post: post)
                }
            } header: {
                Text("Posts")
                    .font(.headline)
            }
        }
        .listStyle(.plain)
        .navigationTitle("\(viewModel.user.name ?? "")")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// Post cell view
struct PostCellView: View {
    /// post data
    let post: Post
    /// When user tap on cell then it will expand based on post body content. By default we are showing only 2 lines
    @State var isExpand: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(post.title)
                .font(.headline)
            Text(post.body ?? "")
                .foregroundColor(.gray)
                .font(.subheadline)
                .lineLimit(isExpand ? nil : 2)
        }
        .onTapGesture {
            self.isExpand.toggle()
        }
    }
}
