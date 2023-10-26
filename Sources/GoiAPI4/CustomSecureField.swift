import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct CustomSecureField: View {
    
    @State var isPasswordVisible: Bool = false
    @Binding var password: String
    var placeholder = ""
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                if password.isEmpty {
                    HStack {
                        Text(placeholder)
                        Spacer()
                    }
                }
                
                ZStack {
                    TextEditor(text: $password)
                    .frame(maxHeight: .infinity)
                    .opacity(isPasswordVisible ? 1 : 0)
                    
                    SecureField("",
                                text: $password)
                    .frame(maxHeight: .infinity)
                    .opacity(isPasswordVisible ? 0 : 1)
                } .frame(height: 200)
                
            }
            .padding(.horizontal, 8)
            Button {
                isPasswordVisible.toggle()
            } label: {
                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
            }
            .padding(.trailing, 8)
        }
        .frame(height: 44)
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.4))
        .cornerRadius(5)
        .padding(.horizontal)
    }
}
