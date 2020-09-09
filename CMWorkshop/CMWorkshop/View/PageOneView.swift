//
//  PageOneView.swift
//  CMWorkshop
//
//  Created by Codemobiles Golf on 21/7/2563 BE.
//
import SwiftUI
 import Alamofire
 import struct Kingfisher.KFImage
 import SwiftUIRefresh

struct PageOneView: View {
    @State private var youtubeDataArray: [Youtube] = []
    @State private var isRefreshing: Bool = false
    
    var body: some View {
        List {
            ForEach(self.youtubeDataArray, id: \.id) { item in
                RowListView(item: item)
            }
        }
        .pullToRefresh(isShowing: $isRefreshing) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { //หน่วงเวลาโหลดหน้าใหม่
                self.feedData()
            }
        }
        .onAppear {
            self.feedData()
        }
        .navigationBarTitle("JSON RESTFul")
    }
    
    func feedData() {
       if UIDevice.current.userInterfaceIdiom == .phone {
            self.isRefreshing = true
        }        
        let params = ["username": "admin", "password": "password", "type": "foods"]
        let url = "http://codemobiles.com/adhoc/youtubes/index_new.php"
        AF.request(url, method: .post, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                print(response.value)
                do {
                    let result = try JSONDecoder().decode(YoutubeResponse.self, from: response.data!)
                    self.youtubeDataArray.removeAll()
                    self.youtubeDataArray = result.youtubes
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.isRefreshing = false
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let err):
                print(err.responseCode)
            }
        }
    }
}

struct PageOneView_Previews: PreviewProvider {
    static var previews: some View {
        PageOneView()
    }
}

struct RowListView: View {
    let item: Youtube
    
    var isiPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    KFImage(URL(string: self.item.avatarImage))
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 0.5))
                    
                    VStack(alignment: .leading) {
                        Text(self.item.title)
                            .lineLimit(1)
                        Text(self.item.subtitle)
                            .foregroundColor(.gray)
                            .lineLimit(2)
                    }
                }
                .padding(.top, 8)
                .padding(.horizontal, 8)
                KFImage(URL(string: self.item.youtubeImage))
                    .resizable()
                    .aspectRatio(1.7, contentMode: .fill)
                    .clipped()
                    .frame(width: geometry.size.width)
            }
        }
        .aspectRatio(self.isiPhone ? 1.2 : 1.5, contentMode: .fit)
        .listRowInsets(EdgeInsets())
        .padding(.bottom, 20)
        .onTapGesture {
            var youtube = URL(string: "youtube://\(self.item.id)")
            if !UIApplication.shared.canOpenURL(youtube!) {
                youtube = URL(string: "https://www.youtube.com/watch?v=\(self.item.id)")
            }
            UIApplication.shared.open(youtube!)
        }
    }
}
