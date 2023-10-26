import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers
///Contains all the code for the Secure and regular TextFields
struct HybridTextField: View {
    @Binding var text: String
    
    @State var bkt:String
    
    @State var isSecure: Bool = false
    var titleKey: String
    var body: some View {
        HStack{
            Group{
                ZStack{
                    TextEditor(text: $text)
                        .onChange(of: text) { newValue in
                            bkt = newValue
                                            
                            }
                        .background(Color.gray)
                        .frame(width: 300, height: 200)
                        .border(Color.black, width: 1)
                                       
                }
                
            }.textFieldStyle(.roundedBorder)
                .animation(.easeInOut(duration: 0.2), value: isSecure)
            //Add any common modifiers here so they dont have to be repeated for each Field
            Button(action: {
                isSecure.toggle()
                if(isSecure == true) {
                    //thay chuoi nhap = *
                    text = text.map({ Character in
                        return "*"
                    }).joined()
                }
                else
                {
                    text = bkt
                }
            }, label: {
                Image(systemName: !isSecure ? "eye.slash" : "eye" )
            })
        }//Add any modifiers shared by the Button and the Fields here
    }
}



