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

    private var context: ModelContext
    private var emailUsuarioLogado: String

    init(context: ModelContext, usuarioEmail: String) {
        self.context = context
        self.emailUsuarioLogado = usuarioEmail
        loadFavoritos()
    }

    func loadFavoritos() {
        let descriptor = FetchDescriptor<Favorito>(
            predicate: #Predicate { $0.usuarioEmail == emailUsuarioLogado }
        )
        do {
            favoritos = try context.fetch(descriptor)
        } catch {
            print("Erro ao buscar favoritos: \(error)")
        }
    }

    func adicionarFavorito(id: String, nome: String, imagemURL: String, pokemonURL: String) {
        guard !favoritos.contains(where: { $0.id == id }) else { return }
        let novo = Favorito(id: id, nome: nome, imagemURL: imagemURL, pokemonURL: pokemonURL, usuarioEmail: emailUsuarioLogado)
        context.insert(novo)
        do {
            try context.save()
            loadFavoritos()
        } catch {
            print("Erro ao salvar favorito: \(error)")
        }
    }

    func removerFavorito(id: String) {
        guard let favorito = favoritos.first(where: { $0.id == id }) else { return }
        context.delete(favorito)
        do {
            try context.save()
            loadFavoritos()
        } catch {
            print("Erro ao remover favorito: \(error)")
        }
    }

    func ehFavorito(id: String) -> Bool {
        favoritos.contains(where: { $0.id == id })
    }
}
