import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

///Contains all the code for the Secure and regular TextFields
struct TextEditorInput12SeedsView: View {
    @Binding var isPassInput12Seed: Bool
    @Binding var text: String
    
    
    
    @State var textHide: String
    @State var bkt:String
    
    @State var isSecure: Bool = false
    
    //biến ngăn user bấm nút eye khi mới lần đầu load page này để không cho user lần đầu vào đã vào hide text
    @State var ActiveEyeicon = false
    
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    @State var data12Words = (1...12).map { "\($0):..." }
   
    
    var titleKey: String
    
    //=====BODY====//
    var body: some View {
        VStack{
            
            
            //chổ nhập 12 từ
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
                                
                                //if(text.count >= 12){
                                    //isPassInput12Seed = true
                                //}
                                }
                            .background(Color.gray)
                            .frame(width: 350, height: 100)
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
                            .frame(width: 350, height: 100)
                            .border(Color.red, width: 1)
                            .opacity(isSecure ? 1:0)
                    }
                    
                }.textFieldStyle(.roundedBorder)
                    .animation(.easeInOut(duration: 0.2), value: isSecure)
               
                
            }
            
            //nut show hide từ
            HStack{
                Spacer()
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
            }
            
            
            //12 từ trong khung bên dưới khi user nhập chuổi ở trên thì auto load vào dưa theo khoảng cách trong chuoi text
           
                LazyVGrid(columns: columns,alignment: .center, spacing: 10) {
                    ForEach(traRaChuoi(data12Words: data12Words, text: text), id: \.self) { item in
                        if(item == "You input over 12 words, please check again!"){
                            Text(item)
                                .frame(width: 400)
                                .font(.body)
                                .foregroundColor(.red)
                                .padding()
                                .scaledToFit()
                                .minimumScaleFactor(0.01)
                        }
                        else{
                            Text(item)
                                .frame(width: 130)
                                .font(.body)
                                .foregroundColor(!isSecure ? .blue:.red)
                                .padding()
                                .border(!isSecure ? .blue:.red)
                                .cornerRadius(5)
                                .lineLimit(1)
                                .scaledToFit()
                                .minimumScaleFactor(0.01)
                        }
                    }
                }
                .padding(.horizontal)
           
        }//end vstack
       
    }//end body
}

func traRaChuoi(data12Words:[String], text:String)->[String]
{
    let arrT  = text.components(separatedBy: " ")
    if(arrT.count<=12){
        let  combin2Array = Array(zip(data12Words, arrT))
        let arrRWithIndex = combin2Array.enumerated()
        let arrX = arrRWithIndex.map({ eO in
            return "\(eO.offset + 1). " + eO.element.1
        })
        
        
        
        //{ (String1, String2) in
            //print("\(String1) +___+ \(String2)")
            //return String2
        //}
        
        return arrX
    }
    return ["You input over 12 words, please check again!"]
}



