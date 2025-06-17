//
//  FavoritosViewModel.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/15/25.
//

import Foundation
import SwiftData

@MainActor
class FavoritosViewModel: ObservableObject {
    @Published var favoritos: [Favorito] = []

    private var service: FavoritoService
    private var emailUsuarioLogado: String

    init(context: ModelContext, usuarioEmail: String) {
        self.service = FavoritoService(context: context)
        self.emailUsuarioLogado = usuarioEmail
        loadFavoritos()
    }

    func loadFavoritos() {
        favoritos = service.carregarFavoritos(email: emailUsuarioLogado)
    }

    func adicionarFavorito(id: String, nome: String, imagemURL: String, pokemonURL: String) {
        service.adicionar(id: id, nome: nome, imagemURL: imagemURL, pokemonURL: pokemonURL, usuarioEmail: emailUsuarioLogado)
        loadFavoritos()
    }

    func removerFavorito(id: String) {
        service.remover(id: id, usuarioEmail: emailUsuarioLogado)
        loadFavoritos()
    }

    func ehFavorito(id: String) -> Bool {
        service.ehFavorito(id: id, usuarioEmail: emailUsuarioLogado)
    }
}
