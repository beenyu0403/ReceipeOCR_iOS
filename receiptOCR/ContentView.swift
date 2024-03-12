//
//  ContentView.swift
//  receiptOCR
//
//  Created by user on 11/1/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack() {
            ZStack {
//                Color(red: 80 / 255, green: 4 / 255, blue: 62 / 255).ignoresSafeArea()
                Color(red: 92 / 255, green: 65 / 255, blue: 89 / 255).ignoresSafeArea()
            // MARK: - 로고
            VStack {
                Image("RLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .padding(.bottom, 90.0)
                    .frame(width: 350, height: 200)
                
                // MARK: - 버튼 구성
                NavigationLink(destination: SignUpView1()) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 320, height: 50)
                            .foregroundColor(.pink1)
                            .shadow(color: .pink1, radius: 10, x: 0, y: 7).opacity(0.4)
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 320, height: 50)
                            .foregroundColor(.pink1)
                        Text("회원가입 하기").lineLimit(1)
                            .font(.system(size: 17, weight: .medium))
                            .frame(width: 320, height: 50, alignment: .center)
                            .foregroundColor(Color.white)
                    }
                }.padding(.bottom, 30.0)
                
                
                
                NavigationLink(destination: SignInView1()) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 320, height: 50)
                            .foregroundColor(.buttonpink1)
                            .shadow(color: .buttonpink1, radius: 10, x: 0, y: 7).opacity(0.4)
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 320, height: 50)
                            .foregroundColor(.buttonpink1)
                        Text("로그인 하기")
                            .lineLimit(1)
                            .font(.system(size: 17, weight: .medium))
                            .frame(width: 320, height: 50, alignment: .center)
                            .foregroundColor(Color.white)
                        
                    }
                }
                
            }.navigationBarHidden(true)
            
                .padding()
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
