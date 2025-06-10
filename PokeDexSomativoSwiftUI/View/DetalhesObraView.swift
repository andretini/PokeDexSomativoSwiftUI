import SwiftUI

struct DetalhesObraView: View {
    let obra: ObraDeArte  // obra passada para mostrar os detalhes

    // Carrega a imagem do arquivo local (Document Directory) usando o nome da obra
    var loadedImage: Image {
        let imageURL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(obra.imagemNome)

        if let uiImage = UIImage(contentsOfFile: imageURL.path) {
            return Image(uiImage: uiImage)   // converte UIImage para SwiftUI Image
        } else {
            return Image(systemName: "photo")  // imagem padrão se não encontrar arquivo
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            loadedImage                      // imagem da obra
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: .infinity)  // largura máxima possível
                .padding()
                .background(Color.blue.opacity(0.1)) // fundo azul clarinho
                .clipShape(RoundedRectangle(cornerRadius: 12)) // cantos arredondados

            Text(obra.titulo)  // título da obra
                .font(.headline)
                .foregroundColor(.primary)

            Text(obra.artista) // nome do artista
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))  // fundo padrão do sistema
        .cornerRadius(12)
        .shadow(radius: 2)  // sombra leve para dar profundidade
    }
}
