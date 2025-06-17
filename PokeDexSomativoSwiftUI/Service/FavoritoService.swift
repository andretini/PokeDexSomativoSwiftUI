//
//  FavoritoService.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/16/25.
//

import Foundation
import SwiftData

struct FavoritoService {
    let context: ModelContext

    func carregarFavoritos(email: String) -> [Favorito] {
        let descriptor = FetchDescriptor<Favorito>(
            predicate: #Predicate { $0.usuarioEmail == email }
        )
        do {
            return try context.fetch(descriptor)
        } catch {
            print("Erro ao buscar favoritos: \(error)")
            return []
        }
    }

    func adicionar(id: String, nome: String, imagemURL: String, pokemonURL: String, usuarioEmail: String) {
        let favoritosAtuais = carregarFavoritos(email: usuarioEmail)
        guard !favoritosAtuais.contains(where: { $0.id == id }) else { return }

        let novo = Favorito(id: id, nome: nome, imagemURL: imagemURL, pokemonURL: pokemonURL, usuarioEmail: usuarioEmail)
        context.insert(novo)
        do {
            try context.save()
        } catch {
            print("Erro ao salvar favorito: \(error)")
        }
    }

    func remover(id: String, usuarioEmail: String) {
        let favoritosAtuais = carregarFavoritos(email: usuarioEmail)
        guard let favorito = favoritosAtuais.first(where: { $0.id == id }) else { return }

        context.delete(favorito)
        do {
            try context.save()
        } catch {
            print("Erro ao remover favorito: \(error)")
        }
    }

    func ehFavorito(id: String, usuarioEmail: String) -> Bool {
        carregarFavoritos(email: usuarioEmail).contains(where: { $0.id == id })
    }
}
