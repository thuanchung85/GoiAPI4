import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers
///Contains all the code for the Secure and regular TextFields
struct HybridTextField: View {
    @Binding var text: String
    
    
    
    @State var textHide: String
    @State var bkt:String
    
    @State var isSecure: Bool = false
    
    //biến ngăn user bấm nút eye khi mới lần đầu load page này để không cho user lần đầu vào đã vào hide text
    @State var ActiveEyeicon = false
    
    
    var titleKey: String
    var body: some View {
        HStack{
            Group{
                ZStack{
                    
                    //nếu isSecure == false hiện đen
                    TextEditor(text: $text)
                        .onChange(of: text) { newValue in
                            bkt = newValue
                            //print("đen: bkt", bkt)
                            textHide = bkt
                            ActiveEyeicon = true
                            }
                        .background(Color.gray)
                        .frame(width: 300, height: 200)
                        .border(Color.black, width: 1)
                        .opacity(isSecure ? 0:1)
                    
                    //nếu isSecure == true hiện red
                    TextEditor(text: $textHide)
                        .onChange(of: textHide) { newValue in
                            textHide = bkt.map({ Character in
                                return "*"
                            }).joined()
                           
                            //print("đỏ : bkt", bkt)
                            }
                        .foregroundColor(.red)
                        .background(Color.red)
                        .frame(width: 300, height: 200)
                        .border(Color.red, width: 1)
                        .opacity(isSecure ? 1:0)
                }
                
            }.textFieldStyle(.roundedBorder)
                .animation(.easeInOut(duration: 0.2), value: isSecure)
           
            //nút này chỉ được kick hoạt khi user đã nhập cai gì đó vào text
            if(ActiveEyeicon == true){
                Button(action: {
                    isSecure.toggle()
                    //nếu bấm isSecure == true
                    if (isSecure == true)
                    {
                        textHide = text
                    }
                    //nếu bấm isSecure == false
                    else
                    {
                        text = bkt
                    }
                    
                    
                    
                }, label: {
                    Image(systemName: !isSecure ? "eye.slash" : "eye" )
                })
            }
        }//Add any modifiers shared by the Button and the Fields here
    }
}



