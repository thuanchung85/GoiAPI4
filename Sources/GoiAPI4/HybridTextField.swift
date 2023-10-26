import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers
///Contains all the code for the Secure and regular TextFields
struct HybridTextField: View {
    @Binding var text: String
    
    @State var bkt:String
    
    @State var isSecure: Bool = true
    var titleKey: String
    var body: some View {
        HStack{
            Group{
                ZStack{
                    TextEditor(text: $text)
                        .onChange(of: text) { newValue in
                            bkt = newValue
                                            
                            }
                     
                }
                
            }.textFieldStyle(.roundedBorder)
                .animation(.easeInOut(duration: 0.2), value: isSecure)
            //Add any common modifiers here so they dont have to be repeated for each Field
            Button(action: {
                isSecure.toggle()
                if(isSecure == true) {
                    text = hideStringbyCharacter(text: text, isHide: true)
                }
                else
                {
                    text = hideStringbyCharacter(text: text, isHide: false)
                }
            }, label: {
                Image(systemName: !isSecure ? "eye.slash" : "eye" )
            })
        }//Add any modifiers shared by the Button and the Fields here
    }
}

func hideStringbyCharacter(text:String, isHide:Bool) -> String
{
    if(isHide == true){
        let t = text.map { Character in
            return "*"
        }
        return t.joined()
    }
    else
    {
        return text
    }
    
}

