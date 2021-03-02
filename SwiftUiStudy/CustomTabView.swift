//
//  CustomTabView.swift
//  SwiftUiStudy
//
//  Created by 김학철 on 2021/03/02.
//

import SwiftUI
struct CustomTabView: View {
    init() {
        UITabBar.appearance().barTintColor = .systemBackground
        UINavigationBar.appearance().barTintColor = .systemBackground
    }
    @State var selectedIndex = 0
    @State var shouldShowModal = false
    let tabBarImageNames = ["person", "gear", "plus.app.fill", "pencil", "lasso"]
    
    var body: some View {
        VStack {
            ZStack {
                Spacer()
                    .fullScreenCover(isPresented: $shouldShowModal, content: {
                        Button(action: {
                            shouldShowModal.toggle()
                        }, label: {
                            Text("Fullscreen cover")
                        })
                    })
                
                switch selectedIndex {
                case 0:
                    ScrollView {
                        ForEach(0..<100) { num in
                            Text("\(num)")
                        }
                    }.navigationTitle("Fist Tabs")
                case 1:
                    ScrollView {
                        Text("scrollview Test")
                            .navigationTitle("ScrollView Test")
                    }
                default:
                    ScrollView {
                        Text("Remaining tabs")
                    }
                }
            }
//            Spacer()
            Divider().padding(.bottom, 12)
            HStack {
                ForEach(0..<5) { num in
                    Button(action: {
                        if num == 2 {
                            shouldShowModal.toggle()
                            return
                        }
                        selectedIndex = num
                    }, label: {
                        Spacer()
                        if num == 2 {
                            Image(systemName: tabBarImageNames[num])
                                .font(.system(size: 44, weight: .bold))
                                .foregroundColor(.red)
                        }
                        else {
                            Image(systemName: tabBarImageNames[num])
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(selectedIndex == num ? Color(.black) : .init(white: 0.8))
                        }
                        
                        Spacer()
                    })
                }
            }
        }
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}
