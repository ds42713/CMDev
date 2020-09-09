//
//  PageTwoView.swift
//  CMWorkshop
//
//  Created by Codemobiles Golf on 21/7/2563 BE.
//
import SwiftUI
import Alamofire

struct PageTwoView: View {
    @State private var isShowActionSheet: Bool = false
    @State private var image: Image? = Image("upload_image")
    @State private var data: Data?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showingImagePicker: Bool = false
    @State private var inputImage: UIImage?
    @State private var inputData: Data?
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var showingLoading: Bool = false
    var body: some View {
        LoadingView(isShowing: $showingLoading) {
            GeometryReader { geometry in
                VStack {
                    self.image?
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width / 1.5, height: geometry.size.width / 1.5)
                        .clipShape(Circle())
                        .padding(.bottom, 35)
                    HStack(spacing: 60) {
                        Button(action: {
                            self.isShowActionSheet = true
                        }) {
                            ImageButtonView(image: "camera_normal", geometry: geometry)
                        }
                        
                        Button(action: {
                            if self.image != Image("upload_image") {
                                self.uploadFile(data: self.data!)
                            }
                        }) {
                            ImageButtonView(image: "share_normal", geometry: geometry)
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .navigationBarTitle("Upload Image", displayMode: .inline)
        .actionSheet(isPresented: self.$isShowActionSheet) {
            ActionSheet(title: Text("Please Select"), message: Text("Source of Image"), buttons: [
                .default(Text("Camera"), action: {
                    self.sourceType = .camera
                    self.showingImagePicker = true
                }),
                .default(Text("Gallery"), action: {
                    self.sourceType = .photoLibrary
                    self.showingImagePicker = true
                }),
                .destructive(Text("Dismiss"))
            ])
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePickerVC(image: self.$inputImage, data: self.$inputData, sourceType: self.sourceType)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Response"), message: Text(alertMessage), dismissButton: .default(Text("Dismiss")))
        }
    }
    
    func loadImage() { //เพื่อเชคว่า ImagePickerVC(image: self.$inputImage, data: self.$inputData) ได้ค่าเป็นอะไร
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        guard let inputData = inputData else { return }
        data = inputData
    }
    
    func uploadFile(data: Data) {
        self.showingLoading = true
        let url = "http://192.168.0.131:3000/uploads"
        let params = ["username": "GOLF", "password": "1234"]
        AF.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(data, withName: "userfile", fileName: "product.jpg", mimeType: "image/jpg")
            for (key, value) in params {
                MultipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
        }, to: url, method: .post).responseString { response in
            switch response.result {
            case let .success(value):
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.showingLoading = false
                    self.image = Image("upload_image")
                    self.showingAlert = true
                    self.alertMessage = value
                }
//                print(value)
                break
            case let .failure(err):
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.showingLoading = false
                    self.showingAlert = true
                    self.alertMessage = err.errorDescription ?? "Undefined error"
                }
//                print(err.errorDescription ?? "Undefined error")
            }
        }
        
    }
}

struct PageTwoView_Previews: PreviewProvider {
    static var previews: some View {
        PageTwoView()
    }
}

struct ImageButtonView: View {
    let image: String
    let geometry: GeometryProxy
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: geometry.size.width / 3.5)
    }
}
