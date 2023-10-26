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
        HStack{
            Group{
                if isSecure{
                    SecureField(titleKey, text: $text)
                    
                }else{
                    TextEditor(text: $text)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
            .foregroundColor(Color.white)
            .background(Color.gray)
            .cornerRadius(5)
            .textFieldStyle(.roundedBorder)
                .animation(.easeInOut(duration: 0.2), value: isSecure)
            //Add any common modifiers here so they dont have to be repeated for each Field
            Button(action: {
                isSecure.toggle()
            }, label: {
                Image(systemName: !isSecure ? "eye.slash" : "eye" )
            })
        }//Add any modifiers shared by the Button and the Fields here
    }
}


