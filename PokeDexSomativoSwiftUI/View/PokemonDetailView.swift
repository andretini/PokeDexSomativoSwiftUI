import SwiftUI

struct PokemonDetailView: View {
    let url: String
    let animation: Namespace.ID

    @EnvironmentObject var favViewModel: FavoritosViewModel
    @StateObject private var viewModel = PokemonDetailViewModel()

    var body: some View {
        VStack(spacing: AppSpacing.xlarge.rawValue) {
            if viewModel.isLoading {
                PulsingPokeballView()
            } else if let pokemon = viewModel.pokemon {
                Text(pokemon.name.capitalized)
                    .font(AppFont.largeTitle.font())

                if let spriteUrlString = pokemon.sprites.frontDefault,
                   let spriteUrl = URL(string: spriteUrlString) {
                    AsyncImage(url: spriteUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .matchedGeometryEffect(id: pokemon.name, in: animation)
                            .opacity(viewModel.isImageVisible ? 1 : 0)
                            .scaleEffect(viewModel.isImageVisible ? 1 : 0.5)
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

            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(AppColor.error.color)
            }
        }
        .padding()
        .task {
            await viewModel.fetchPokemon(from: url)
        }
        .navigationTitle(viewModel.pokemon?.name.capitalized ?? "Detalhes")
        .navigationBarTitleDisplayMode(.inline)
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
