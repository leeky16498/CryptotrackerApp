//
//  CryptotrackerAppApp.swift
//  CryptotrackerApp
//
//  Created by Kyungyun Lee on 06/04/2022.
//

import SwiftUI

@main
struct CryptotrackerAppApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
