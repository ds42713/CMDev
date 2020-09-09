//
//  ContentView.swift
//  CMWorkshop
//
//  Created by Pongsakorn Praditkanok on 27/7/2563 BE.
//  Copyright © 2563 Ds42713. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            MenuView()
                .navigationBarTitle("Codemobiles Workshop", displayMode: .inline)
       if UIDevice.current.userInterfaceIdiom == .pad {
           PageThreeView()
       }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
