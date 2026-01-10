//
//  VlowLibraryTests.swift
//  VlowLibraryTests
//
//  Created by Nathan Gunawan on 11/01/26.
//
import Testing

@testable import VlowLibrary
@MainActor

struct VlowLibraryTests {

    @Test
    func initialState_isCorrect() async {
        let vm = LoginViewModel()

        #expect(vm.username == "")
        #expect(vm.isLoading == false)
        #expect(vm.errorMessage == nil)
        #expect(vm.signedInUser == nil)
    }

    @Test
    func login_withEmptyUsername_fails() async {
        let vm = LoginViewModel()
        vm.username = ""

        await vm.signIn()

        #expect(vm.signedInUser == nil)
        #expect(vm.errorMessage != nil)
    }
}
