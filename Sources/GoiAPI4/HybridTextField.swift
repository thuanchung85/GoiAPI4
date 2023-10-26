import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers
///Contains all the code for the Secure and regular TextFields
struct HybridTextField: View {
    @Binding var text: String
    @State var backupText =  ""
    @State var isSecure: Bool = true
    var titleKey: String
    var body: some View {
        HStack{
            
                TextEditor(text: $text)
            
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
            .foregroundColor(Color.blue)
            .background(Color.gray)
            .cornerRadius(5)
           
            //Add any common modifiers here so they dont have to be repeated for each Field
            Button(action: {
                isSecure.toggle()
                if(isSecure == true){
                    backupText = text
                    self.text = String(text.map { char in
                        return "*"
                    })
                }
                else
                {
                    text = backupText
                }
            }, label: {
                Image(systemName: !isSecure ? "eye.slash" : "eye" )
            })
        }//Add any modifiers shared by the Button and the Fields here
    }
}


