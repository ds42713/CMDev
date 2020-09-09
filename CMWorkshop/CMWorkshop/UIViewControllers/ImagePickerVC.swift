//
//  ImagePickerVC.swift
//  CMWorkshop
//
//  Created by Codemobiles Golf on 24/7/2563 BE.
//
import SwiftUI

struct ImagePickerVC: UIViewControllerRepresentable {
    @Binding var image: UIImage? //@Binding ผูกตัวแปรในหน้าที่จะส่งไป
    @Binding var data: Data?
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Environment(\.presentationMode) var presentationMode //คำสั่งปิด viewcontrollers ตัวนี้หลังเลือกรูปเสร็จแล้ว
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePickerVC
        
        init(_ parent: ImagePickerVC) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
                parent.data = uiImage.jpegData(compressionQuality: 1.0) // ทำให้ //compressionQuality = คุณภาพของรูปภาพ
            }
            parent.presentationMode.wrappedValue.dismiss() // ทำให้หน้านี้ผิดไปเมื่อเลือกเสร็จแล้ว
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
}
