//
//  ListaObrasView.swift
//  SomativoSwiftUI
//
//  Created by user277041 on 5/22/25.
//

import SwiftUI

struct ListaObrasView: View {
    
    @Binding var path: [String]             // recebe o binding da pilha de navegação
    @EnvironmentObject var viewModel: ObrasViewModel  // acesso aos dados das obras
    
    // Layout adaptável: colunas que mudam de acordo com o espaço disponível
    let colunas = [
        GridItem(.adaptive(minimum: 150), spacing: 16)
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: colunas, spacing: 16) {
                    // Lista cada obra com um NavigationLink para a tela de detalhes
                    ForEach(viewModel.obras) { obra in
                        NavigationLink(destination: DetalhesObraView(obra: obra)) {
                            ObraItemView(obra: obra)  // visualização resumida da obra
                        }
                    }
                }
                .padding()
            }
            
            // Botão que adiciona "CreateObra" ao path para navegar para a tela de criação
            Button {
                path.append("CreateObra")   // empurra a rota na pilha
            } label: {
                VStack {
                    Text("Adicionar")
                    Text("uma Obra")
                }
                .padding()
                .background(Color(red: 0.8, green: 1.0, blue: 0.8))
                .foregroundColor(.black)
                .cornerRadius(8)
            }
        }
        .navigationTitle("Obras de Arte")  // título da navegação no topo
        
        // Mapeia as rotas do path para as telas correspondentes
        .navigationDestination(for: String.self) { value in
            if value == "CreateObra" {
                CreateObraView(path: $path)
                    .environmentObject(viewModel)  // passa o ViewModel para a tela de criação
            }
        }
    }
}
