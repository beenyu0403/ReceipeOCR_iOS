//
//  OCRImageView2.swift
//  receiptOCR
//
//  Created by user on 11/2/23.
//

import SwiftUI

var receiptisToggleOn:Bool = false
struct OCRImageView2: View {
    // MARK: - Properties
    @ObservedObject private var viewModel = OCRViewModel()
    var image: UIImage
    //@State var receiptisToggleOn:Bool = false
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        
            ZStack{
                Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255).ignoresSafeArea()
                
                imageView
                    .onAppear {
                        viewModel.recognaizeText(image: image)
                    }
                
            }
        
    }
    var imageView: some View {
        VStack() {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
            
            ScrollView {
                Text(viewModel.OCRString ?? "")
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
            }
            Button(action: {
                //self.tag2 = 1
                print(viewModel.OCRString ?? "")
                receiptisToggleOn = true
                self.presentationMode.wrappedValue.dismiss()
            }){
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 320, height: 50)
                        .foregroundColor(.buttonpink1)
                        .shadow(color: .buttonpink1, radius: 10, x: 0, y: 7).opacity(0.4)
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 320, height: 50)
                        .foregroundColor(.buttonpink1)
                    Text("영수증 기록하기").lineLimit(1)
                        .font(.system(size: 17, weight: .medium))
                        .frame(width: 320, height: 50, alignment: .center)
                        .foregroundColor(Color.white)
                }
            }.padding(.top, 20)
            
        }
    }
}
