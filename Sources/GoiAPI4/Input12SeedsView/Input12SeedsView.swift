import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

///Contains all the code for the Secure and regular TextFields
struct Input12SeedsView: View {
    @Binding var isPassInput12Seed: Bool
    @Binding var text: String
   
    @State var isShow_ScanQRcodeView = false
    @State var isShow_NextButton = false
    
    @State var textHide: String
    @State var bkt:String
    
    @State var isSecure: Bool = false
    
    //biến ngăn user bấm nút eye khi mới lần đầu load page này để không cho user lần đầu vào đã vào hide text
    @State var ActiveEyeicon = false
    
    @Binding var isBack:Bool
    @Binding var isBack2:Bool
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    @State var data12Words = (1...12).map { "\($0):..." }
   
   
    var titleKey: String
    

                 
                
                
    public init(isPassInput12Seed: Binding<Bool>,text: Binding<String>,
                textHide:String, bkt: String, titleKey: String, isBack:Binding<Bool>, isBack2:Binding<Bool>) {
        self._isPassInput12Seed = isPassInput12Seed
        self._text = text
        self.textHide = textHide
        self.bkt = bkt
        self.titleKey = titleKey
        self._isBack = isBack
        self._isBack2 = isBack2
    }
    
    //=====BODY====//
    var body: some View {
        
        
        //nếu user bấm nút scan qr code thi show ScanQRcodeView ra
        if(self.isShow_ScanQRcodeView == true)
        {
            
            QR_ScannerView(scannerCode: $text, isShow_ScanQRcodeView: $isShow_ScanQRcodeView,
                           isShow_NextButton:$isShow_NextButton)
            
        }//end if
        
        //mới vô show view nhập 12 từ cho người dùng nhập tay hay paste
        if(self.isShow_ScanQRcodeView == false)
        {
            ScrollView{
                VStack{
                    HStack{
                        ZStack{
                            HStack{
                                Button(action: {
                                    self.isBack2 = false
                                    self.isBack = false
                                }) {
                                    Image(systemName: "chevron.backward")
                                        .foregroundColor(Color.green)
                                }
                                Spacer()
                            }
                            HStack{
                                Spacer()
                                Text("Recovery Wallet")
                                    .font(.custom("Arial ", size: 20))
                                    .padding(.top,10)
                                Spacer()
                            }
                        }
                    }
                    Text(titleKey)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.top,10)
                    
                    
                    //===chổ nhập 12 từ====///
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
                                        
                                        //kich hoạt truyền ra ngoài user pass 12 từ khi đã nhập đủ
                                        if(traRaChuoi(data12Words: data12Words, text: text).count == 12){
                                            isShow_NextButton = true
                                        }
                                        else{
                                            isShow_NextButton = false
                                        }
                                    }
                                    .frame(width: 350, height: 100)
                                    .opacity(isSecure ? 0:1)
                                
                                //nếu isSecure == true hiện red
                                TextEditor(text: $textHide)
                                    .onChange(of: textHide) { newValue in
                                        textHide = bkt.map({ Character in
                                            return "*"
                                        }).joined()
                                    }
                                    
                                    .frame(width: 350, height: 100)
                                    .opacity(isSecure ? 1:0)
                                    .disabled(true)
                            }
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.green, lineWidth: 1)
                            )
                            
                        }.textFieldStyle(.roundedBorder)
                            .animation(.easeInOut(duration: 0.2), value: isSecure)
                        
                        
                    }
                    
                    //===nut show hide từ và //nut gọi QR scan==//
                    HStack{
                        //nut đi tới màn hình scan QR
                        Button {
                            self.isShow_ScanQRcodeView = true
                        } label: {
                            Text("Scan QR code")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                
                        }
                        
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
                                    .foregroundColor(.green)
                                    .padding(.top,10)
                            })
                        }
                    }
                    
                    
                    
                    //==Khung 12 từ===//
                    //12 từ trong khung bên dưới khi user nhập chuổi ở trên thì auto load vào dưa theo khoảng cách trong chuoi text
                    if(traRaChuoi(data12Words: data12Words, text: text).contains("You input over 12 words, please check again!") == true){
                        Text("You entered more than 12 words, please check again!")
                            .frame(width: 300)
                            .font(.custom("Arial ", size: 15))
                            .foregroundColor(.red)
                            .padding()
                            .scaledToFit()
                            .minimumScaleFactor(0.01)
                    }
                    else{
                        LazyVGrid(columns: columns,alignment: .center, spacing: 10) {
                            ForEach(traRaChuoi(data12Words: data12Words, text: text, isSecure: isSecure), id: \.self) { item in
                                
                                Text(item)
                                    .frame(width: 130)
                                    .font(.custom("Arial ", size: 20))
                                    .foregroundColor(.black)
                                    .padding()
                                    .lineLimit(1)
                                    .scaledToFit()
                                    .minimumScaleFactor(0.01)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                                                       .foregroundColor(Color(UIColor.green))
                                        
                                    )
                            }
                        }
                        .padding(.horizontal)
                    }
                    //===nút đi tới OldWalletView , nut này cần kick hoat bang QR hay nhap đủ 12 từ===//
                    if(self.isShow_NextButton == true){
                        Button(action: {
                            self.isPassInput12Seed = true
                        }) {
                          
                                Text("Get Wallet")
                                .frame(width: 120)
                                .padding()
                                .foregroundColor(.white)
                           
                        }
                        .background(Color.green)
                        .cornerRadius(30)
                        .padding(.bottom,10)
                    }
                }//end vstack
                
            }//end scrollView
        }//end if
        
        
    }//end body
}





//==hàm trả ra chuỗi khi người dùng nhập, ta xữ lý cắt ghép để bỏ vào khung 12 từ==//
func traRaChuoi(data12Words:[String], text:String, isSecure:Bool? = false)->[String]
{
    var arrT  = text.components(separatedBy: " ")
    if(arrT.last == "") {arrT.removeLast()}
    if(arrT.count<=12){
        let  combin2Array = Array(zip(data12Words, arrT))
        let arrRWithIndex = combin2Array.enumerated()
        let arrX = arrRWithIndex.map({ eO in
            if(isSecure! == true){
                return "\(eO.offset + 1). " +  String(eO.element.1.map{_ in "*"})
            }
            else{
                return "\(eO.offset + 1). " + eO.element.1
            }
           
        })
        
        return arrX
    }
   
    return ["You input over 12 words, please check again!"]
}



