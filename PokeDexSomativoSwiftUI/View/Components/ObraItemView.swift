import SwiftUI

struct ObraItemView: View {
    let obra: ObraDeArte  // Obra que será mostrada neste item da lista

    // Computed property para carregar a imagem da obra do disco
    var loadedImage: Image {
        // Pega o caminho do diretório de documentos e adiciona o nome da imagem
        let imageURL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(obra.imagemNome)

        // Tenta criar UIImage a partir do arquivo no caminho
        if let uiImage = UIImage(contentsOfFile: imageURL.path) {
            // Se conseguir, cria uma Image a partir da UIImage
            return Image(uiImage: uiImage)
        } else {
            // Se falhar, retorna uma imagem padrão do sistema (ícone de foto)
            return Image(systemName: "photo")
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            // Mostra a imagem carregada
            loadedImage
                .resizable()                      // Permite redimensionar a imagem
                .aspectRatio(1, contentMode: .fit)  // Mantém proporção 1:1 (quadrado)
                .frame(maxWidth: .infinity)       // Expande para a largura máxima possível
                .padding()                        // Espaço interno ao redor da imagem
                .background(Color.blue.opacity(0.1)) // Fundo azul claro com transparência
                .clipShape(RoundedRectangle(cornerRadius: 12)) // Cantos arredondados

            // Mostra o título da obra com fonte grande e cor principal
            Text(obra.titulo)
                .font(.headline)
                .foregroundColor(.primary)

            // Mostra o nome do artista com fonte menor e cor secundária
            Text(obra.artista)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()                  // Espaçamento interno para todo o VStack
        .background(Color(.systemBackground)) // Fundo padrão do sistema (claro ou escuro)
        .cornerRadius(12)           // Cantos arredondados para o card inteiro
        .shadow(radius: 2)          // Sombra leve para dar profundidade
    }
}
