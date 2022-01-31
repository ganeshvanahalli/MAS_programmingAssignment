//
//  SignIn.swift
//  NotesApp
//
//  Created by Somya Doshi on 1/30/22.
//

import AuthenticationServices
import SwiftUI
import Foundation


struct SignIn: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
//    @State var coord: SignInAppleCoordinator
    
    var body: some View {
        VStack {
            SignInApple()
                .frame(height: 60)
                .padding()
                .cornerRadius(10)
//                .onTapGesture {
//                    self.coord = SignInAppleCoordinator()
//                    if let coord = self.coord {
//                        coord.startSignInWithAppleFlow {
//                            self.presentationMode.wrappedValue.dismiss()
//                        }
//                    }
//                }
        }
    }
}

struct SignInApple: UIViewRepresentable {
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    }
}

//struct SignIn_Previews: PreviewProvider {
//    static var previews: some View {
//        SignIn()
//    }
//}
