// Views/PokemonDetailView.swift
import SwiftUI

struct PokemonDetailView: View {
    let url: String
    let animation: Namespace.ID

    @EnvironmentObject var favViewModel: FavoritosViewModel
    @State private var pokemon: Pokemon?
    @State private var isLoading = true
    @State private var errorMessage: String?
    @State private var isImageVisible = false

    var body: some View {
        VStack(spacing: AppSpacing.xlarge.rawValue) {
            if isLoading {
                PulsingPokeballView() // Ótimo, usando a view customizada!
            } else if let pokemon = pokemon {
                Text(pokemon.name.capitalized)
                    .font(AppFont.largeTitle.font())

                if let spriteUrlString = pokemon.sprites.frontDefault,
                   let spriteUrl = URL(string: spriteUrlString) {
                    AsyncImage(url: spriteUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            // Animações na imagem
                            .matchedGeometryEffect(id: pokemon.name, in: animation)
                            .opacity(isImageVisible ? 1 : 0)
                            .scaleEffect(isImageVisible ? 1 : 0.5)
                    } placeholder: {
                        ProgressView()
                    }
                }

                Text("Height: \(pokemon.height)")
                Text("Weight: \(pokemon.weight)")
                Text("Base XP: \(pokemon.baseExperience)")
                
                let idString = String(pokemon.id)
                let isFavorito = favViewModel.ehFavorito(id: idString)

                Button(action: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                        if isFavorito {
                            favViewModel.removerFavorito(id: idString)
                        } else {
                            favViewModel.adicionarFavorito(
                                id: idString,
                                nome: pokemon.name,
                                imagemURL: pokemon.sprites.frontDefault ?? "",
                                pokemonURL: url
                            )
                        }
                    }
                }) {
                    Image(systemName: isFavorito ? "star.fill" : "star")
                        .font(.largeTitle)
                        .foregroundColor(isFavorito ? .yellow : .gray)
                        .scaleEffect(isFavorito ? 1.25 : 1.0)
                        .rotationEffect(.degrees(isFavorito ? 360 : 0))
                }
                .padding(.top, AppSpacing.medium.rawValue)

            } else if let error = errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(AppColor.error.color)
            }
        }
        .padding()
        .task {
            // 👈 O .task agora apenas chama a função, que tem a lógica completa.
            await fetchPokemon()
        }
        .navigationTitle(pokemon?.name.capitalized ?? "Detalhes")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // 👇 A função fetchPokemon() foi reescrita para controlar a animação corretamente.
    func fetchPokemon() async {
        // 1. Reinicia o estado da animação e ativa o loading
        isImageVisible = false
        isLoading = true
        errorMessage = nil

        guard let url = URL(string: url) else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(Pokemon.self, from: data)
            
            // 2. Define o pokemon e desativa o loading
            pokemon = decoded
            isLoading = false
            
            // 3. Ativa a animação da imagem APÓS os dados terem sido carregados
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                isImageVisible = true
            }
            
        } catch {
            errorMessage = "Failed to load Pokémon details: \(error.localizedDescription)"
            isLoading = false
        }
    }
}


struct PulsingPokeballView: View {
    @State private var isAnimating = false

    var body: some View {
        Image("poke")
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .scaleEffect(isAnimating ? 1.2 : 1.0)
            .opacity(isAnimating ? 0.5 : 1.0)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                    isAnimating = true
                }
            }
    }
}
