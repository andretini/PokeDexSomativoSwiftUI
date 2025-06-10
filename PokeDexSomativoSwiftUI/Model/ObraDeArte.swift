//
//  ObraDeArte.swift
//  SomativoSwiftUI
//
//  Created by user277041 on 5/22/25.
//

import Foundation

// Modelo de dados que representa uma obra de arte
struct ObraDeArte: Identifiable, Codable {
    let id: UUID             // Identificador único para cada obra
    let titulo: String       // Título da obra
    let artista: String      // Nome do artista que criou a obra
    let ano: Int             // Ano de criação da obra
    let estilo: String       // Estilo artístico da obra (ex: impressionismo)
    let imagemNome: String   // Nome do arquivo da imagem associada à obra
    let descricao: String    // Descrição textual da obra
    
    // Inicializador personalizado com id opcional (gera um UUID automaticamente)
    init(id: UUID = UUID(),
         titulo: String,
         artista: String,
         ano: Int,
         estilo: String,
         imagemNome: String,
         descricao: String) {
        self.id = id
        self.titulo = titulo
        self.artista = artista
        self.ano = ano
        self.estilo = estilo
        self.imagemNome = imagemNome
        self.descricao = descricao
    }
}
