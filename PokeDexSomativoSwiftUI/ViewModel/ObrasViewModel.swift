//
//  ObrasViewModel.swift
//  SomativoSwiftUI
//
//  Created by user277041 on 5/22/25.
//

import Foundation
import Combine

class ObrasViewModel: ObservableObject {
    // Lista de obras que, quando modificada, dispara a UI para atualizar
    @Published var obras: [ObraDeArte] = [] {
        didSet {
            saveToDisk()  // salva automaticamente ao mudar a lista
        }
    }
    
    // Caminho do arquivo onde os dados são salvos no dispositivo
    private let savePath = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)[0]
        .appendingPathComponent("obras.json")
    
    init() {
        loadFromDisk() // carrega dados ao iniciar
    }
    
    func addObra(_ obra: ObraDeArte) {
        obras.append(obra) // adiciona uma obra e dispara o didSet
    }
    
    private func saveToDisk() {
        do {
            let data = try JSONEncoder().encode(obras)  // transforma em JSON
            try data.write(to: savePath)                 // escreve no arquivo
        } catch {
            print("Erro ao salvar dados: \(error)")     // debug simples
        }
    }

    private func loadFromDisk() {
        do {
            let data = try Data(contentsOf: savePath)                   // lê o arquivo
            obras = try JSONDecoder().decode([ObraDeArte].self, from: data)  // decodifica JSON
        } catch {
            print("Nenhuma obra salva ou erro ao carregar: \(error)")   // se não achar arquivo, ignora
        }
    }
    
    // Dados estáticos para pré-visualização no Xcode
    static var preview: ObrasViewModel {
        let vm = ObrasViewModel()
        vm.obras = [
            ObraDeArte(id: UUID(), titulo: "A Noite Estrelada", artista: "Vincent van Gogh", ano: 1889, estilo: "Pós-Impressionismo", imagemNome: "paintpalette", descricao: "Uma das obras mais famosas de Van Gogh."),
            ObraDeArte(id: UUID(), titulo: "Guernica", artista: "Pablo Picasso", ano: 1937, estilo: "Cubismo", imagemNome: "photo", descricao: "Representa o bombardeio de Guernica durante a Guerra Civil Espanhola.")
        ]
        return vm
    }
}
