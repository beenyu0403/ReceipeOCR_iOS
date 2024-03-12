//
//  SignUpView1.swift
//  receiptOCR
//
//  Created by user on 11/1/23.
//

import SwiftUI

var isEmailDuplication = true
struct SignUpView1: View {
    @State var userName: String = ""
    @State var userEmail: String = ""
    @State var isEmailDuplicationLabel = false
    @State var isEmailDuplicationButton = false
    @EnvironmentObject var EmailviewModel: EmailViewModel
    @State var userPw: String = ""
    @State var userPw2: String = ""
    @State var isActivePw = false
    @State var isActivePw2 = false
    @State var isPresented = false
    
    enum Field: Hashable {
        case userName, userEmail, userPw, userPw2
      }
    @FocusState private var focusField: Field?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // MARK: - 뒤로가기 구성
    var backButton : some View {  // <--커스텀 버튼
            Button{
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Image(systemName: "chevron.left") // 화살표 Image
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.white)
                    Text("회원가입")
                        .foregroundColor(Color.white)
                }
            }
        }
    // MARK: - 화면 구성
    var body: some View {
        ZStack{
            Color(red: 92 / 255, green: 65 / 255, blue: 89 / 255).ignoresSafeArea()
            
            
            VStack {
                Text("일상의 지출을")
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .semibold))
                    .frame(width: 280, height: 30, alignment: .leading)
                
                Text("하나로 기록하세요!")
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .semibold))
                    .frame(width: 280, height: 30, alignment: .leading)
                    .padding(.bottom, 40.0)
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 300, height: 45)
                        .foregroundColor(.pink1)
                        .shadow(color: .pink1, radius: 10, x: 0, y: 7).opacity(0.4)
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 300, height: 45)
                        .foregroundColor(.white)
                    PlaceHolderField("이름을 입력하세요.", font: .custom("", fixedSize: 11), color: .gray, text: $userName)
                    //TextField("이름을 입력하세요.", text: $userName)
                        .focused($focusField, equals: .userName)
                        .disableAutocorrection(true) //자동 수정 비활성화
                        .textInputAutocapitalization(.never) //대문자 비활성화
                        .padding(.leading, 81)
                        .foregroundColor(.black)
                        .font(.system(size: 13, weight: .thin))
                    
                }.padding(.vertical, 20.0)
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 300, height: 45)
                        .foregroundColor(.pink1)
                        .shadow(color: .pink1, radius: 10, x: 0, y: 7).opacity(0.4)
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 302, height: 47)
                        .foregroundColor(checkEmailCondition () ? .clear : Color.red)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 300, height: 45)
                        .foregroundColor(.white)
                    
                    PlaceHolderField("이메일을 입력하세요.", font: .custom("", fixedSize: 11), color: .gray, text: $userEmail)
                    //TextField("이메일을 입력하세요.", text: $userEmail)
                        .onChange(of: userEmail){ _ in
                            isEmailDuplicationLabel = false
                            isEmailDuplicationButton = false
                            if EmailviewModel.emailDuplicationState(email: userEmail) {
                                isEmailDuplication = false
                            }else{
                                isEmailDuplication = true
                                //print(isEmailDuplication)
                            }
                        }
                        .focused($focusField, equals: .userEmail)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .padding(.leading, 81)
                        .foregroundColor(.black)
                        .font(.system(size: 13, weight: .thin))
                    
                    
                    Button(action: {
                        self.isEmailDuplicationLabel = true
                        self.isEmailDuplicationButton=true
                        
                        print(isEmailDuplication)
                    }){
                        
                        if isEmailDuplication && isEmailDuplicationButton && !userEmail.isEmpty && checkEmailCondition() {
                            
                            Image("pinkcheck")
                        }else {
                            Image("graycheck")
                            
                        }
                        
                    }.padding(.leading, 250)
                    
                    Text("이메일 형식을 확인해주세요.")
                        .font(.system(size: 11, weight: .regular))
                        .padding(.top, 80)
                        .frame(width: 250, height: 30, alignment: .leading)
                        .foregroundColor(checkEmailCondition () ? .clear : Color.red)
                    
                    if checkEmailCondition() && !isEmailDuplicationButton && !userEmail.isEmpty {
                        Text("이메일 중복 여부를 확인해주세요.")
                            .font(.system(size: 11, weight: .regular))
                            .padding(.top, 80)
                            .frame(width: 250, height: 30, alignment: .leading)
                            .foregroundColor(Color.blue)
                    }
                    
                    if isEmailDuplicationLabel && !isEmailDuplication && !userEmail.isEmpty {
                        
                        Text("이미 가입된 이메일입니다.")
                            .font(.system(size: 11, weight: .regular))
                            .padding(.top, 80)
                            .frame(width: 250, height: 30, alignment: .leading)
                            .foregroundColor(Color.red)
                        
                    }
                }.padding(.vertical, 10.0)
                
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
                            .textContentType(.oneTimeCode)
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
                            .textContentType(.oneTimeCode)
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
                    
                    
                }.padding(.vertical, 20.0)
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 300, height: 45)
                        .foregroundColor(.pink1)
                        .shadow(color: .pink1, radius: 10, x: 0, y: 7).opacity(0.4)
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 302, height: 47)
                        .foregroundColor(checkPwSameCondition () ? .clear : Color.red)
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 300, height: 45)
                        .foregroundColor(.white)
                    if isActivePw2 {
                        PlaceHolderField("비밀번호를 다시 입력하세요.", font: .custom("", fixedSize: 11), color: .gray, text: $userPw2)
                        //TextField("비밀번호를 다시 입력하세요.", text: $userPw2)
                            .focused($focusField, equals: .userPw2)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .padding(.leading, 81)
                            .foregroundColor(.black)
                            .font(.system(size: 13, weight: .thin))
                    }else {
                        PlaceHolderField2("비밀번호를 다시 입력하세요.", font: .custom("", fixedSize: 11), color: .gray, text: $userPw2)
                        //SecureField("비밀번호를 다시 입력하세요.", text: $userPw2)
                            .focused($focusField, equals: .userPw2)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .padding(.leading, 81)
                            .foregroundColor(.black)
                            .font(.system(size: 13, weight: .thin))
                    }
                    
                    Button(action: {
                        self.isActivePw2.toggle()
                        
                    }){
                        if isActivePw2 {
                            Image("pinkeye")
                        }else {
                            Image("grayeye")
                        }
                        
                    }.padding(.leading, 250)
                    
                    Text("비밀번호가 일치하지 않습니다.")
                        .font(.system(size: 11, weight: .regular))
                        .padding(.top, 80)
                        .frame(width: 250, height: 30, alignment: .leading)
                        .foregroundColor(checkPwSameCondition () ? .clear : Color.red)
                }.padding(.vertical, 10.0)
                    .padding(.bottom, 90.0)
                
                ZStack{
                    
                    if checkButtonCondition () {
                        
                        Button(action: {
                            if checkButtonCondition () {
                                self.isPresented.toggle()
                                db.collection("USER").document(newUser.email).setData([
                                    "email": newUser.email,
                                    "name": newUser.name,
                                    "password": newUser.password
                                ]) { err in
                                    if let err = err {
                                        print("Error writing document: \(err)")
                                    } else {
                                        print("Document successfully written!")
                                    }
                                }
                                EmailviewModel.emailAuthSignUp(email: newUser.email, userName: newUser.name, password: newUser.password)
                            }else {
                                print("회원가입 실패")
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
                                Text("다음").lineLimit(1)
                                    .font(.system(size: 17, weight: .medium))
                                    .frame(width: 320, height: 50, alignment: .center)
                                    .foregroundColor(Color.white)
                            }
                        }.fullScreenCover(isPresented: $isPresented){
                            ContentView()
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
                            Text("다음").lineLimit(1)
                                .font(.system(size: 17, weight: .medium))
                                .frame(width: 320, height: 50, alignment: .center)
                                .foregroundColor(Color.white)
                        }
                    }
        
                   
                    
                }
                
            }.padding(.bottom, 60.0)
                .onAppear (perform: UIApplication.shared.hideKeyboard)
            
           
            
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    //MARK: - 함수 구현 공간
    // 이메일 형식 검사
    func isValidEmail(id: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: id)
    }
    func checkEmailCondition () -> Bool {
        if isValidEmail(id: userEmail) || userEmail.isEmpty {
            return true
        }
        return false
    }
    // 비밀번호 형식 검사
    func isValidPassword(pwd: String) -> Bool {
        let passwordRegEx = "^[a-zA-Z0-9]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: pwd)
    }
    
    func checkPwCondition () -> Bool {
        if isValidPassword(pwd: userPw) || userPw.isEmpty {
            return true
        }
        return false
    }
    
    func checkPwSameCondition () -> Bool {
        if userPw == userPw2 || userPw2.isEmpty {
            return true
        }
        return false
    }
        
    func checkButtonCondition () -> Bool {
        if !userName.isEmpty && !userEmail.isEmpty && isValidEmail(id: userEmail) && checkPwCondition() && checkPwSameCondition() && !userPw.isEmpty && !userPw2.isEmpty {
            if isEmailDuplication && isEmailDuplicationButton {
                newUser.name = userName
                newUser.email = userEmail
                newUser.password = userPw
                print("\(newUser.email)+생성 완료")
                print(newUser.password)
                
                
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
    func signUpUser() {
        db.collection("USER").document(newUser.email).setData([
            "email": newUser.email,
            "name": newUser.name,
            "password": newUser.password
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        EmailviewModel.emailAuthSignUp(email: newUser.email, userName: newUser.name, password: newUser.password)
    }
}

struct SwiftUpView1_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView1()
    }
}
