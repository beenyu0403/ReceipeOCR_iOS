//
//  SignInView1.swift
//  receiptOCR
//
//  Created by user on 11/1/23.
//

import SwiftUI

struct SignInView1: View {
    @State var userEmail: String = ""
    @State var userPw: String = ""
    @State var isActivePw = false
    @State var isPresented = false
    @State var isActiveLogin = false
    @EnvironmentObject var EmailviewModel: EmailViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    enum Field: Hashable {
        case userEmail, userPw
      }
    @FocusState private var focusField: Field?
    var backButton : some View {  // <--커스텀 버튼
            Button{
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Image(systemName: "chevron.left") // 화살표 Image
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.white)
                    Text("로그인")
                        .foregroundColor(Color.white)
                }
            }
        }
    
    var body: some View {
        ZStack{
            Color(red: 92 / 255, green: 65 / 255, blue: 89 / 255).ignoresSafeArea()
                
            
            VStack {
                Image("RLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 270, height: 180)
                    .padding(.bottom, 25.0)

                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 300, height: 45)
                        .foregroundColor(.pink1)
                        .shadow(color: .pink1, radius: 10, x: 0, y: 7).opacity(0.4)
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 302, height: 47)
                        .foregroundColor(checkEmailCondition() ? .clear : Color.red)
 
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 300, height: 45)
                        .foregroundColor(.white)
                    
                    PlaceHolderField("아이디(이메일)을 입력하세요.", font: .custom("", fixedSize: 11), color: .gray, text: $userEmail)
                    //TextField("아이디(이메일)을 입력하세요.", text: $userEmail)
                        .onChange(of: userEmail){ _ in

                        }
                        .focused($focusField, equals: .userEmail)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .padding(.leading, 81)
                        .foregroundColor(.black)
                        .font(.system(size: 13, weight: .thin))
                        
 
                    Text("이메일 형식을 확인해주세요.")
                        .font(.system(size: 11, weight: .regular))
                        .padding(.top, 80)
                        .frame(width: 250, height: 30, alignment: .leading)
                        .foregroundColor(checkEmailCondition() ? .clear : Color.red)
                    
                }.padding(.bottom, 30.0)
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 300, height: 45)
                        .foregroundColor(.pink1)
                        .shadow(color: .pink1, radius: 10, x: 0, y: 7).opacity(0.4)
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 302, height: 47)
                        .foregroundColor(checkPwCondition() ? .clear : Color.red)
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 300, height: 45)
                        .foregroundColor(.white)
                    
                    if isActivePw{
                        PlaceHolderField("비밀번호 입력 (8자리 이상, 영어+숫자)", font: .custom("", fixedSize: 11), color: .gray, text: $userPw)
                        //TextField("비밀번호 입력 (8자리 이상, 영어+숫자)", text: $userPw)
                            .focused($focusField, equals: .userPw)
                            .disableAutocorrection(true) //자동 수정 비활성화
                            .textInputAutocapitalization(.never)
                            .keyboardType(.alphabet)
                            .padding(.leading, 81)
                            .foregroundColor(.black)
                            .font(.system(size: 13, weight: .thin))

                    }
                    else{
                        PlaceHolderField2("비밀번호 입력 (8자리 이상, 영어+숫자)", font: .custom("", fixedSize: 11), color: .gray, text: $userPw)
                        //SecureField("비밀번호 입력 (8자리 이상, 영어+숫자)", text: $userPw)
                            .focused($focusField, equals: .userPw)
                            .disableAutocorrection(true) //자동 수정 비활성화
                            .textInputAutocapitalization(.never)
                            .keyboardType(.alphabet)
                            .padding(.leading, 81)
                            .foregroundColor(.black)
                            .font(.system(size: 13, weight: .thin))
                    }
                    
                    Button(action: {
                        self.isActivePw.toggle()
                        
                    }){
                        if isActivePw {
                            Image("pinkeye")
                        }else {
                            Image("grayeye")
                        }
                        
                    }.padding(.leading, 250)
                    
                    Text("비밀번호 형식을 확인해주세요. (8자리 이상, 영어+숫자)")
                        .font(.system(size: 11, weight: .regular))
                        .padding(.top, 80)
                        .frame(width: 250, height: 30, alignment: .leading)
                        .foregroundColor(checkPwCondition() ? .clear : Color.red)
                    
                    
                }.padding(.bottom, 120.0)
                    .onAppear (perform: UIApplication.shared.hideKeyboard)
                
                
                
                if nextButtonCondition ()  {
                    Button(action: {
                        if isActiveLogin {
                            self.isPresented.toggle()
                        }else {
                            print("로그인 실패")
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
                            Text("로그인").lineLimit(1)
                                .font(.system(size: 17, weight: .medium))
                                .frame(width: 320, height: 50, alignment: .center)
                                .foregroundColor(Color.white)
                        }
                    }.fullScreenCover(isPresented: $isPresented){
                        HomeView()
                    }
                }else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 320, height: 50)
                            .foregroundColor(.pink2)
                            .shadow(color: .pink2, radius: 10, x: 0, y: 7).opacity(0.4)
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 320, height: 50)
                            .foregroundColor(.pink2)
                        Text("로그인").lineLimit(1)
                            .font(.system(size: 17, weight: .medium))
                            .frame(width: 320, height: 50, alignment: .center)
                            .foregroundColor(Color.white)
                    }
                }
    
               
                
            }
            
            
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
        
        
    }
    //MARK: - 함수 구현 공간
    // 이메일 형식 검사
    func checkEmailCondition () -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let isValidEmail = emailTest.evaluate(with: userEmail)
        if isValidEmail || userEmail.isEmpty {
            return true
        }
        return false
    }

    func checkPwCondition () -> Bool {
        let passwordRegEx = "^[a-zA-Z0-9]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        let isValidPassword = passwordTest.evaluate(with: userPw)
        if isValidPassword || userPw.isEmpty {
            return true
        }
        return false
    }
    
    func nextButtonCondition () -> Bool {
        if checkPwCondition () && checkEmailCondition () && !userPw.isEmpty && !userEmail.isEmpty  {
            
            print("로그인 가능 상태")
            
            //로그인 구현
            let userDB = db.collection("USER")
            userDB.document(userEmail).addSnapshotListener { (qs, err) in
                    guard let document = qs else {
                        print("Error: \(err!)")
                        return
                    }
                    let message = document.get("password") as? String ?? ""
                    if message == userPw {
                        print("비밀번호가 일치합니다.")
                        EmailviewModel.emailAuthSignIn(email: userEmail, password: userPw)
                        //currentUserName = EmailviewModel.nameState()
                        isActiveLogin = true
                        if isActiveLogin {
                            currentUserName = EmailviewModel.nameState(currentemail: userEmail)
                        }
                    }else{
                        print("비밀번호가 다릅니다.")
                        isActiveLogin = false
                }
               
            }
            //
            
            return true
        }
        return false
    }
}

#Preview {
    SignInView1()
}
