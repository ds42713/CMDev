//
//  MenuView.swift
//  CMWorkshop
//
//  Created by Codemobiles Golf on 21/7/2563 BE.
//
import SwiftUI

struct MenuList: Identifiable {
    let id = UUID()
    let icon, title: String
    let page: AnyView
    var items: [MenuList]?
}
 extension MenuList {
        static let pageOne = MenuList(icon: "ic_feed", title: "JSON RESTFul", page: AnyView(PageOneView()))
        static let pageTwo = MenuList(icon: "ic_upload", title: "Upload Image", page: AnyView(PageTwoView()))
        static let pageThree = MenuList(icon: "ic_webkit", title: "WebKit Integration", page: AnyView(PageThreeView()))
    static let pageThreeOne = MenuList(icon: "ic_webkit", title: "WebKit Integration Two", page: AnyView(PageThreeOneView()))
    }


struct MenuView: View {
    let items: [MenuList] = [.pageOne, .pageTwo, .pageThree, .pageThreeOne]
    var body: some View {
        List {
            Section(header:
                        Image("ios_training_header")
                        .resizable()
                        .aspectRatio(1.15, contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .listRowInsets(EdgeInsets())
            ) {
                ForEach(items) { item in
                    NavigationLink(destination: item.page) {
                        HStack {
                            Image(item.icon)
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text(item.title)
                        }
                    }
                }
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
