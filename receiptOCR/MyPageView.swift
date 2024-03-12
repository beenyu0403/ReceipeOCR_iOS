//
//  MyPageView.swift
//  receiptOCR
//
//  Created by user on 11/2/23.
//

import SwiftUI

struct MyPageView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.white)
                .frame(width: 355, height: 206)
                
            VStack{
                HStack{
                    Text("내 정보")
                        .padding(.trailing, 240)
                        
                }
                Text("마이페이지")
                    .bold()
                    .padding()
                    .multilineTextAlignment(.leading)
                Text(currentUser?.email ?? "비로그인")
                //Text(currentUserName + "님")
                Spacer().frame(height:50)
            }
        }.padding(.top, 50)
    }
}

#Preview {
    MyPageView()
}
