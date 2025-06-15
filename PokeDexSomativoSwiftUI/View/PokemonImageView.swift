import SwiftUI

struct PokemonImageView: View {
    let pokemonUrl: String
    let image: String?
    
    @State private var imageUrl: URL? = nil
    
    
    var body: some View {
        Group {
            if let imageUrl {
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 96, height: 96)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 96, height: 96)
                    case .failure:
                        Image(systemName: "questionmark.square")
                            .resizable()
                            .frame(width: 96, height: 96)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                ProgressView()
                    .frame(width: 96, height: 96)
            }
        }
        .task {
            if let image {
                imageUrl = URL(string: image)
            }
            else{
                await fetchImageUrl()
            }
        }
    }
    
    private func fetchImageUrl() async {
        guard let url = URL(string: pokemonUrl) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(Pokemon.self, from: data)
            	
            if let spriteUrlString = decoded.sprites.frontDefault{
                let spriteUrl = URL(string: spriteUrlString);
                imageUrl = spriteUrl;
            }
            
        } catch {
            
        }
    }
}
