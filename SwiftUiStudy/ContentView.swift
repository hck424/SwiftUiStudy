//
//  ContentView.swift
//  SwiftUiStudy
//
//  Created by 김학철 on 2021/03/02.
//

import SwiftUI
struct Example: Identifiable {
    var id: Int
    var name:String
}

let listData:[Example] = [
    Example(id: 1, name: "Custom tab menu view"),
    Example(id: 2, name: "Grides with json observable app")
]
struct ListRow: View {
    var item:Example
    var body: some View {
        HStack {
            Text("\(item.id).")
            Text(item.name)
//            Spacer()
        }
    }
}

struct ContentView: View {
    var data: [Example]
    var body: some View {
        NavigationView {
            List(data) { item in
                if item.id == 1 {
                    NavigationLink(
                        destination: CustomTabView(),
                    label: {
                        ListRow(item: item)
                    })
                }
                else if item.id == 2 {
                    NavigationLink(
                        destination: GridesWithJsonObsevableApp(),
                    label: {
                        ListRow(item: item)
                    })
                }
            }.navigationTitle("Swift UI Study")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(data: listData)
    }
}
