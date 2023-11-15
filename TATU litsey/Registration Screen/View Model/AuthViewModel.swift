//
//  AuthViewModel.swift
//  TATU litsey
//
//  Created by Abdulloh on 25/09/23.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol AuthenticationFromProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var errorTitle: String?
    @Published var errorMessage: String?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            switch error.localizedDescription {
            case "The email address is badly formatted.":
                errorTitle = "Noto'g'ri elektron pochta"
                errorMessage = "Elektron pochtangiz xato terilgan"
            case "An internal error has occurred, print and inspect the error details for more information.":
                errorTitle = "Foydalanuvchi topilmadi"
                errorMessage = "Bunday foydalanuvchi topilmadi. Elektron pochtangiz yoki parolingiz xato terilgan"
            case "Network error (such as timeout, interrupted connection or unreachable host) has occurred.":
                errorTitle = "Internet bilan muammo"
                errorMessage = "Internetga ulanib bo‘lmadi. Internetga ulaning"
            default:
                errorTitle = nil
                print(error.localizedDescription)
            }
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String, group: String, subgroup: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email, group: group, subgroup: subgroup)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
            await fetchUser()
        } catch {
            switch error.localizedDescription {
            case "The email address is badly formatted.":
                errorTitle = "Noto'g'ri elektron pochta"
                errorMessage = "Elektron pochta xato terilgan"
            case "Network error (such as timeout, interrupted connection or unreachable host) has occurred.":
                errorTitle = "Internet bilan muammo"
                errorMessage = "Internetga ulanib bo‘lmadi. Internetga ulaning"
            default:
                errorTitle = nil
                print(error.localizedDescription)
            }
        }
    }
    
    func changeUserGroupTo(_ group: String) async throws {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            try await Firestore.firestore().collection("users").document(uid).updateData(["group": group])
            
            await fetchUser()
        } catch {
            print("DEBUG: failed to change user group \(error.localizedDescription)")
        }
    }
    
    func changeUserSubgroupTo(_ subgroup: String) async throws {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            try await Firestore.firestore().collection("users").document(uid).updateData(["subgroup": subgroup])
            
            await fetchUser()
        } catch {
            print("DEBUG: failed to change user subgroup \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() async {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            try await Firestore.firestore().collection("users").document(uid).delete()
            try await Auth.auth().currentUser?.delete()
            
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        
        if self.currentUser == nil {
            userSession = nil
        } else {
            //alertError = "We could not find this user"
        }
    }
}
