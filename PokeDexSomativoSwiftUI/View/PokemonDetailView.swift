import SwiftUI

struct PokemonDetailView: View {
    let url: String
    let animation: Namespace.ID

    @EnvironmentObject var favViewModel: FavoritosViewModel
    @StateObject private var viewModel = PokemonDetailViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.large.rawValue) {
                if viewModel.isLoading {
                    PulsingPokeballView()
                } else if let pokemon = viewModel.pokemon {
                    // Seção do Cabeçalho (Nome, Imagem, Favorito)
                    VStack {
                        Text(pokemon.name.capitalized)
                            .font(AppFont.largeTitle.font())
                            .padding(.top)

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
                                    .frame(width: 150, height: 150)
                            }
                        }

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
                        .padding(.bottom, AppSpacing.medium.rawValue)
                    }

                    
                    InfoCardView(title: "Detalhes") {
                        InfoRow(label: "Altura", value: "\(pokemon.height)")
                        InfoRow(label: "Peso", value: "\(pokemon.weight)")
                        InfoRow(label: "XP Base", value: "\(pokemon.baseExperience)")
                    }

                    InfoCardView(title: "Habilidades") {
                        ForEach(pokemon.abilities, id: \.ability.name) { ability in
                            Text(ability.ability.name.capitalized)
                                .font(AppFont.body.font())
                        }
                    }

                    InfoCardView(title: "Movimentos") {
                        
                        ForEach(pokemon.moves.prefix(4), id: \.move.name) { move in
                            Text(move.move.name.capitalized)
                                .font(AppFont.body.font())
                        }
                    }

                } else if let error = viewModel.errorMessage {
                    Text("Erro: \(error)")
                        .foregroundColor(AppColor.error.color)
                        .padding()
                }
            }
            .padding(.horizontal) // Adiciona padding horizontal à VStack principal
        }
        .task {
            await viewModel.fetchPokemon(from: url)
        }
        .navigationTitle(viewModel.pokemon?.name.capitalized ?? "Detalhes")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct InfoCardView<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(spacing: AppSpacing.medium.rawValue) {
            Text(title)
                .font(AppFont.title.font())
                .frame(maxWidth: .infinity, alignment: .center) // Centraliza o título

            VStack(spacing: AppSpacing.small.rawValue) {
                content
            }
            .frame(maxWidth: .infinity, alignment: .center) // Centraliza o conteúdo
        }
        .padding()
        .frame(maxWidth: .infinity) 
        .background(AppColor.surface.color)
        .cornerRadius(AppCornerRadius.medium.rawValue)
        .modifier(AppShadow(radius: 4))
    }
}

struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(AppFont.body.font())
                .foregroundColor(AppColor.textPrimary.color)
            Spacer()
            Text(value)
                .font(AppFont.body.font().bold())
                .foregroundColor(AppColor.secondaryAction.color)
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
