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
    @StateObject private var PokemonVM = PokemonListViewModel()
    @State private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            if let usuario = appState.usuarioLogado {
                if let favoritosVM = appState.favouriteVM {
                    NavigationStack(path: $path) {
                        PokemonListView(path: $path)
                            .environmentObject(PokemonVM)
                            .environmentObject(favoritosVM)
                    }
                    .environment(appState)
                }
                else {
                    Text("Carregando favoritos...")
                        .task {
                            appState.container = try! ModelContainer(for: Usuario.self, Favorito.self)
                            appState.favouriteVM = FavoritosViewModel(
                                context: appState.container!.mainContext,
                                usuarioEmail: usuario.email
                            )
                        }
                }
                
            } else {
                NavigationStack {
                    LoginView()
                }
                .environment(appState)
            }
        }
        .modelContainer(for: [Usuario.self, Favorito.self]) // inclui os dois modelos
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
    var container: ModelContainer? = nil
    var favouriteVM: FavoritosViewModel? = nil
}
