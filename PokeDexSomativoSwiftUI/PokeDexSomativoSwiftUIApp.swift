//
//  PokeDexSomativoSwiftUIApp.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/10/25.
//

import SwiftUI
import SwiftData

@main
struct PokeDexSomativoSwiftUIApp: App {
    @State private var path: [String] = []
    @StateObject private var obrasVM = ObrasViewModel()
    var appState = AppState()

    var body: some Scene {
        WindowGroup {
            if let _ = appState.usuarioLogado {
                NavigationStack(path: $path) {
                    ListaObrasView(path: $path)
                        .environmentObject(obrasVM)
                }
                .environment(appState)
            } else {
                NavigationStack {
                    LoginView()
                }
                .environment(appState)
            }
        }
        .modelContainer(for: Usuario.self)
    }
}


#Preview {
    LoginView()
        .environment(AppState())
        .modelContainer(for: Usuario.self, inMemory: true)
}


import Foundation

@Observable
class AppState {
    var usuarioLogado: Usuario? = nil
}
