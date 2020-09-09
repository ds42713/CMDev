//
//  PageThreeView.swift
//  CMWorkshop
//
//  Created by Codemobiles Golf on 29/7/2563 BE.
//
import SwiftUI

struct PageThreeOneView: View {
    @State private var selectedSegment: Int = 0
    
    var openWeb: URLRequest {
        let url = URL(string: "http://www.codemobiles.com/biz/training_consult.php")
        return URLRequest(url: url!)
    }
    
    var openPdf: URLRequest {
        let pdfPath = Bundle.main.path(forResource: "product.pdf", ofType: nil)
        let url = URL(fileURLWithPath: pdfPath!)
        return URLRequest(url: url)
    }
    
    var body: some View {
        VStack {
            Picker("Type", selection: self.$selectedSegment) {
                Text("WEB").tag(0)
                Text("PDF").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 200, alignment: .center)
            .padding(.top, 5)
            WebView(request: selectedSegment == 0 ? self.openWeb : self.openPdf)
        }
        .navigationBarTitle("WebKit Integration", displayMode: .inline)
    }
}

struct PageThreeOneView_Previews: PreviewProvider {
    static var previews: some View {
       PageThreeOneView()
    }
}
