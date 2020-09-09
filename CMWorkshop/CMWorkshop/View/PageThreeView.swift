//
//  PageThreeView.swift
//  CMWorkshop
//
//  Created by Codemobiles Golf on 29/7/2563 BE.
//
import SwiftUI

struct PageThreeView: View {
    @State private var selectedSegment: Int = 0
    var body: some View {
        VStack {
            Picker("Type", selection: self.$selectedSegment) {
                Text("WEB").tag(0)
                Text("PDF").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 200, alignment: .center)
            .padding(.top, 5)
            WebView(request: selectedSegment == 0 ? self.openWeb() : self.openPdf())
        }.navigationBarTitle("WebKit Integration", displayMode: .inline)
    }
    
    func openWeb() -> URLRequest {
        let url = URL(string: "http://www.codemobiles.com/biz/training_consult.php") // ถ้าไม่ใช่ https ต้องไปขอสิทธิ
        return URLRequest(url: url!)
    }
    
    func openPdf() -> URLRequest {
        let pdfPath = Bundle.main.path(forResource: "product.pdf", ofType: nil)
        let url = URL(fileURLWithPath: pdfPath!)
        return URLRequest(url: url)
    }
}

struct PageThreeView_Previews: PreviewProvider {
    static var previews: some View {
        PageThreeView()
    }
}
