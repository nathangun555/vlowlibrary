//
//  LoginView.swift
//  VlowLibraryApp
//
//  Created by Nathan Gunawan on 09/01/26.
////


import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    @EnvironmentObject var auth: AuthViewModel

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "book.closed")
                .font(.system(size: 80))
                .foregroundStyle(.blue)

            Text("Vlow Library App")
                .font(.largeTitle.bold())
                .padding(.bottom)

            VStack(spacing: 16) {
                TextField("Username", text: $viewModel.username)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
            .padding(.horizontal)

            Button("Masuk") {
                Task {
                    await viewModel.signIn()
                    if let user = viewModel.signedInUser {
                        auth.login(user: user)   // ✅ trigger RootContentView
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.username.isEmpty || viewModel.isLoading)

            if viewModel.isLoading {
                ProgressView("Signing in...")
            }

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
            }
        }
        .padding()
    }
}
