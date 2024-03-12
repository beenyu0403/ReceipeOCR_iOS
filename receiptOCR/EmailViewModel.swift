//
//  EmailViewModel.swift
//  receiptOCR
//
//  Created by user on 11/1/23.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

//var currentuser = Auth.auth().currentUser
var currentUser: FirebaseAuth.User? = Auth.auth().currentUser
var currentUserName = ""

var firestore: Firestore!
let db = Firestore.firestore()

struct User {
    var name: String
    var email: String
    var password: String
}
var newUser : User = User(name: "", email: "", password: "")

class EmailViewModel: ObservableObject {
   // var currentUser: Firebase.User? = Auth.auth().currentUser
    
    
    func emailAuthSignUp(email: String, userName: String, password: String) {
       
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in

                if result != nil {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = userName
                    print("사용자 이메일: \(String(describing: result?.user.email))")
                    return
                }else{
                    if let error = error {
                        print("error: \(error.localizedDescription)")
                        return
                    }
                }
            }
        
       
        }
    
    func emailDuplicationState(email: String) -> Bool {
        var result = false
                
                let userDB = db.collection("USER")
                // 입력한 이메일이 있는지 확인 쿼리
                let query = userDB.whereField("email", isEqualTo: email)
                query.getDocuments() { (qs, err) in
                    
                    if qs!.documents.isEmpty {
                        //print("데이터 중복 안 됨 가입 진행 가능")
                        result = true
                    } else {
                        print("데이터 중복 됨 가입 진행 불가")
                        isEmailDuplication = false
                        result = false
                    }
                }
                
                return result

    }
    
    func emailAuthSignIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in

            guard let strongSelf = self else { return }
        }
    }
    
    func nameState(currentemail: String) -> String{
        let userDB = db.collection("USER")
       var message = ""
        //userDB.document(currentUser?.email ?? "").addSnapshotListener { (qs, err) in
        userDB.document(currentemail).addSnapshotListener { (qs, err) in
                guard let document = qs else {
                    print("Error: \(err!)")
                    return
                }
            currentUserName = document.get("name") as? String ?? ""
            message = document.get("name") as? String ?? ""
            print("유저이름" + currentUserName)
           
        }
        return message
    }
}
