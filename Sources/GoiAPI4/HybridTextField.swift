import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers
///Contains all the code for the Secure and regular TextFields
struct HybridTextField: View {
    @Binding var text: String
    @State var isSecure: Bool = true
    var titleKey: String
    var body: some View {
        
        
        if isSecure{
            SecureField(titleKey, text: $text)
                .multilineTextAlignment(.leading)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
                .foregroundColor(Color.white)
                .background(Color.gray)
                .cornerRadius(5)
        }else{
            TextField(titleKey, text: $text)
                .multilineTextAlignment(.leading)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
                .foregroundColor(Color.white)
                .background(Color.gray)
                .cornerRadius(5)
        }
        //Add any common modifiers here so they dont have to be repeated for each Field
        Button(action: {
            isSecure.toggle()
        }, label: {
            Image(systemName: !isSecure ? "eye.slash" : "eye" )
        })
        
    }
}


