// Views/PokemonListView.swift
import SwiftUI

struct PokemonListView: View {
    @Binding var path: [String]
    @EnvironmentObject var viewModel: PokemonListViewModel
    @EnvironmentObject var favViewModel: FavoritosViewModel
    
    @Namespace private var animation
    
    let columns = [
        GridItem(.adaptive(minimum: 150), spacing: AppSpacing.large.rawValue)
    ]
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/International_Pok%C3%A9mon_logo.svg/1200px-International_Pok%C3%A9mon_logo.svg.png")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.6)
                    .padding(.top, 30)
            } placeholder: {
                ProgressView()
            }
            ScrollView {
                LazyVGrid(columns: columns, spacing: AppSpacing.large.rawValue) {
                    ForEach(viewModel.pokemons.indices, id: \.self) { index in
                        let pokemon = viewModel.pokemons[index]
                        
                        NavigationLink(
                            destination: PokemonDetailView(url: pokemon.url, animation: animation).environmentObject(favViewModel)
                        ) {
                            PokemonCellView(imageUrl: nil, pokemon: pokemon, animation: animation)
                                .onAppear {
                                    if index == viewModel.pokemons.count - 1 {
                                        Task {
                                            await viewModel.fetchPokemons()
                                        }
                                    }
                                }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(AppSpacing.large.rawValue)
            }
            
            NavigationLink(destination: FavoritosListView(path: $path)
                .environmentObject(viewModel)
                .environmentObject(favViewModel)
            ) {
                Text("Ver Favoritos")
                    .font(AppFont.title.font())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(AppColor.primaryAction.color)
                    .foregroundColor(AppColor.textOnPrimary.color)
                    .cornerRadius(AppCornerRadius.medium.rawValue) 
                    .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .onAppear {
            if viewModel.pokemons.isEmpty {
                Task {
                    await viewModel.fetchPokemons()
                }
            }
        }
    }
}
