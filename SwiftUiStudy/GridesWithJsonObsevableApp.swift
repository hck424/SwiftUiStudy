//
//  GridesWithJsonObsevableApp.swift
//  SwiftUiStudy
//
//  Created by 김학철 on 2021/03/02.
//

import SwiftUI
import Kingfisher

struct RSS: Decodable {
    let feed: Feed
}
struct Feed: Decodable {
    let results: [Result]
    
}
struct Result: Decodable, Hashable {
    let artistName, id, releaseDate, name, kind, copyright, artistId, artistUrl, artworkUrl100, url: String
}

class GridViewModel: ObservableObject {
    @Published var items = 0..<5
    @Published var results = [Result]()
    
    init() {
        
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/ca/ios-apps/new-apps-we-love/all/100/explicit.json") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, resp, error) in
            guard let data = data else {
                return
            }
            do {
                let res = try JSONDecoder().decode(RSS.self, from: data)
                print(res)
                DispatchQueue.main.async {
                    self.results = res.feed.results
                }
            } catch {
                print("Failed json decodable: \(error)")
            }
        }.resume()
    }
}

struct AppInfo: View {
    let app: Result
    var body: some View {
        VStack(alignment: .leading) {
            KFImage(URL(string: app.artworkUrl100))
                .resizable()
                .scaledToFit()
                .cornerRadius(22)
                .clipped()

            Text(app.artistName)
                .font(.system(size: 10, weight: .semibold))
                .padding(.top, 4)
            Text(app.releaseDate)
                .font(.system(size: 9, weight: .regular))
            Text(app.copyright).font(.system(size: 9, weight: .regular)).foregroundColor(.gray)
            
            Spacer()
        }
    }
}

struct GridesWithJsonObsevableApp: View {
    @ObservedObject var vm = GridViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(minimum: 50, maximum: 200), spacing: 16, alignment: .top),
                GridItem(.flexible(minimum: 50, maximum: 200), spacing: 16, alignment: .top),
                GridItem(.flexible(minimum: 50, maximum: 200), alignment: .top)
            ],
            content: {
                ForEach(vm.results, id: \.self) { app in
                    AppInfo(app: app)
                }
            }).padding(.horizontal, 16)
        }
        .navigationTitle("Grid Search LBATA")
    }
}
struct GridesWithJsonObsevableApp_Previews: PreviewProvider {
    static var previews: some View {
        GridesWithJsonObsevableApp()
    }
}
