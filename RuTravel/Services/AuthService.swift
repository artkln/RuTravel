//
//  AuthService.swift
//  RuTravel
//
//  Created by kalinin on 14.05.2022.
//

import FirebaseAuth
import FirebaseFirestore

final class AuthService {

    static let shared = AuthService()
    private init() {}

    func handleSignUp(name: String,
                      email: String,
                      password: String,
                      completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let result = result {
                completion(.success(result))
            }

            if let error = error {
                completion(.failure(error))
            }
        }
    }

    func setName(_ name: String,
                 completion: @escaping (Error?) -> Void) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name

        changeRequest?.commitChanges { error in
            guard let error = error else {
                completion(nil)
                return
            }
            completion(error)
        }
    }

    func setEmail(_ email: String,
                 completion: @escaping (Error?) -> Void) {
        Auth.auth().currentUser?.updateEmail(to: email) { error in
            guard let error = error else {
                completion(nil)
                return
            }
            completion(error)
        }
    }

    func handleSignIn(email: String,
                      password: String,
                      completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard let error = error else {
                completion(nil)
                return
            }
            completion(error)
        }
    }

}
