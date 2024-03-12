//
//  OCRImageView.swift
//  receiptOCR
//
//  Created by user on 11/2/23.
//

import SwiftUI

extension UIImage {
  var data: Data? {
    return self.pngData()
  };static func image(fromData data: Data) -> Image {
      return Image(uiImage: UIImage(data: data) ?? UIImage())
    }
}

struct OCRImageView: View {
    @State var tag:Int? = nil
    @State private var tag2 = false
    @State private var showingImagePicker = false
    @State private var finishImagePicker = false
    @State var pickedImage: Image?
    @State private var inputImage: UIImage?
    
    var body: some View {
        ZStack{
            Color(red: 92 / 255, green: 65 / 255, blue: 89 / 255).ignoresSafeArea()
            VStack{
                
                Text("영수증 사진 기록")
                    .padding(.bottom, 30.0)
                    .foregroundColor(.white)
                VStack{
                    Text("선택한 사진: ")
                        .foregroundColor(.white)
                        .padding(.bottom, 10.0)
                }.sheet(isPresented: $showingImagePicker) {
                                                SUImagePicker(image: self.$inputImage, sourceType: .photoLibrary) { (image) in
                                                    self.pickedImage = Image(uiImage: image)
                                                    finishImagePicker = true
                                                    inputImage = image
                    
                                                    print(image)
                                                    print(pickedImage!)
                                                }
                                            }
                                        pickedImage?.resizable()
                                            .scaledToFit()
                                            .frame(height:320)
    
                
                ZStack{
                    VStack{
                        Button(action: {
                            self.tag = 1
                            self.showingImagePicker.toggle()
                        }){
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(width: 320, height: 50)
                                    .foregroundColor(.pink1)
                                    .shadow(color: .pink1, radius: 10, x: 0, y: 7).opacity(0.4)
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(width: 320, height: 50)
                                    .foregroundColor(.pink1)
                                Text("사진 선택하기").lineLimit(1)
                                    .font(.system(size: 17, weight: .medium))
                                    .frame(width: 320, height: 50, alignment: .center)
                                    .foregroundColor(Color.white)
                            }
                        }
                            
                    }
                    
                    
                    Button(action: {
                        //self.tag2 = 1
                        if finishImagePicker {
                            self.tag2.toggle()
                        }
                        
                            
                    }){
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 320, height: 50)
                                .foregroundColor(.buttonpink1)
                                .shadow(color: .buttonpink1, radius: 10, x: 0, y: 7).opacity(0.4)
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 320, height: 50)
                                .foregroundColor(.buttonpink1)
                            Text("영수증 확인하기").lineLimit(1)
                                .font(.system(size: 17, weight: .medium))
                                .frame(width: 320, height: 50, alignment: .center)
                                .foregroundColor(Color.white)
                        }
                    }.padding(.top, 190)
                        .sheet(isPresented: $tag2 ) {
                            if let trimage = inputImage {
                                OCRImageView2(image: trimage)
                            }
                          }
                        
                    
                    
                }.padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    OCRImageView()
}
