import SwiftUI

struct ContentView: View {
    
    @State private var listaPacoteViagem: [PacoteViagem] = [
        PacoteViagem(titulo: "Calor no Lençois Maranhenses", destino: "Maranhão, Brasil", qtdDiaria: 5, dataPartida: "01/01/1980", dataRetorno: "05/01/1980", info: "Aproveite as maravilhosas dunas maranhenses de Lençois", image: "Lencois-Maranhenses", preco: 5000, isFavorito: false),
        PacoteViagem(titulo: "Frio em Buenos Aires", destino: "Buenos Aires, Argentina", qtdDiaria: 8, dataPartida: "01/01/1980", dataRetorno: "05/01/1980", info: "Aproveite o melhor frio da América do Sul na Argentina", image: "buenos-aires", preco: 15000, isFavorito: true),
    ]
    
    var totalCurtidos: Int {
        listaPacoteViagem.filter {
            $0.isFavorito
        }.count
    }
    
    var body: some View {
        VStack {
            NavigationStack {
                List($listaPacoteViagem) { $pacote in
                    NavigationLink {
                        DetalhePacoteViagemView(itemPacoteViagem: $pacote)
                    } label: {
                        ItemListaPacotesViagemView(itemPacote: $pacote)

                    }
                }
                .navigationTitle("Explorar viagens")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing, content: {
                        NavigationLink {
                            PacoteViagemFavotitasView(listaPacoteViagem: $listaPacoteViagem)
                        } label: {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.red)
                            Text("\(totalCurtidos)")
                        }
                    })
                }
            }
        }
        
    }
}

struct PacoteViagemFavotitasView: View {
    
    @Binding var listaPacoteViagem: [PacoteViagem]
    
    var body: some View {
        List {
            ForEach($listaPacoteViagem) { $itemPacote in
                if itemPacote.isFavorito {
                    ItemListaPacotesViagemView(itemPacote: $itemPacote)
                }
            }
        }
        .navigationTitle("Meus favoritos")
        .overlay {
            if !listaPacoteViagem.contains(where: { $0.isFavorito }) {
                ContentUnavailableView(
                    "Nenhum favotito",
                    systemImage: "heart.slash",
                    description: Text("Suas viagens favoritadas vão aparecer aqui.")
                )
            }
        }
    }
}

struct DetalhePacoteViagemView: View {
    
    @Binding var itemPacoteViagem: PacoteViagem
    
    var body: some View {
        VStack {
            ZStack {
                Image(itemPacoteViagem.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill )
                    .frame(width: 280, height: 280)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button(action: {
                    itemPacoteViagem.isFavorito.toggle()
                }, label: {
                    Image(systemName: itemPacoteViagem.isFavorito ? "heart.fill" : "heart")
                        .font(.system(size: 28, weight: .regular))
                        .foregroundStyle(itemPacoteViagem.isFavorito ? .red : .black)
                        .frame(width: 70, height: 70)
                        .background(Color.white.opacity(0.6))
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1),radius: 5, x: 0, y: 2)
                })
            }
            VStack(alignment: .center) {
                Text(itemPacoteViagem.destino)
                    .font(.headline)
                    .foregroundStyle(.orange)
                
                Text(itemPacoteViagem.titulo)
                    .font(.title2)
                    .bold()
            }.padding(.bottom)
            
            // conteudo pacote
            VStack(spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Partida")
                            .foregroundStyle(.gray)
                            .font(.footnote)
                        Text(itemPacoteViagem.dataPartida)
                            .font(.body)
                            .bold()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .center, spacing: 4) {
                        Text("Duração")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                        
                        Text("\(String(itemPacoteViagem.qtdDiaria)) dias")
                            .font(.body)
                            .bold()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("Retorno")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                        
                        Text(itemPacoteViagem.dataRetorno)
                            .font(.body)
                            .bold()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                Divider()
            }
            .padding(.horizontal)
            
            // Hospedagem
            VStack(alignment: .leading, spacing: 16) {
                Text("Hospedagem")
                    .font(.headline)
                    .bold()
                Text(itemPacoteViagem.info)
                    .font(.headline)
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Spacer()
            NavigationLink {
                
            } label: {
                Text(String(format: "Reservar por R$ %.2f", itemPacoteViagem.preco))
                    .bold()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.black)
                    .padding()
                    .background(.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }

        }.padding()
        
                
    }
}

struct ItemListaPacotesViagemView: View {
    
    @Binding var itemPacote: PacoteViagem
    
    var body: some View {
        HStack {
            VStack{
                Image(itemPacote.image)
                    .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .cornerRadius(12)
            }.padding(.trailing)
            VStack(alignment: .leading) {
                Text(itemPacote.titulo)
                    .bold()
                    .font(.headline)
                
                Text(itemPacote.destino)
                    .font(.callout)
                    .foregroundStyle(.gray)
                Text(String(format: "\(itemPacote.qtdDiaria) diárias | R$ %.2f", itemPacote.preco))
                    .bold()
                    .font(.caption)
                    .foregroundStyle(.orange)
                
            }
            Spacer()
            VStack {
                Button(action: {
                    itemPacote.isFavorito.toggle()
                }, label: {
                    Image(systemName: itemPacote.isFavorito ? "heart.fill" : "heart")
                        .foregroundStyle(itemPacote.isFavorito ? .red : .gray)
                })
                .buttonStyle(.plain)
            }
                       
        }
    }
}

#Preview {
    ContentView()
}
