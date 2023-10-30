
import SwiftUI


public struct PasscodeView_ConfirmPIN : View {
    
    @Binding var isUserPass_PIN_making:Bool
    
    @Binding var walletName:String
    @State var password:String = ""
    @State var passwordBuoc1:String = ""

    @State var isShowConFirmPassCodeView:Bool = false
    
    var textAskUserDo:String
    
    public init(textAskUserDo:String,walletName: Binding<String>, isUserPass_PIN_making:Binding<Bool>) {
        self._walletName = walletName
        self.textAskUserDo = textAskUserDo
        self._isUserPass_PIN_making = isUserPass_PIN_making
    }
    
    public var body: some View{
        //Bước 1: hiện page cho user nhập mã PIN trước
        if (isShowConFirmPassCodeView == false){
            VStack{
                
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.top,20)
                
                Text(textAskUserDo)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .padding(.top,20)
                
                HStack(spacing: 22){
                    
                    // Password Circle View...
                    
                    ForEach(0..<6,id: \.self){index in
                        
                        PasswordView2(index: index, password: $password)
                    }
                }
                // for smaller size iphones...
                .padding(.top,10)
                
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3),spacing: UIScreen.main.bounds.width < 750 ? 5 : 15){
                    
                    // Password Button ....
                    
                    ForEach(1...9,id: \.self){value in
                        
                        PasswordButton2(value: "\(value)",password: $password, passwordBuoc1: $passwordBuoc1, isShowConFirmPassCodeView: $isShowConFirmPassCodeView)
                    }
                    
                    PasswordButton2(value: "delete.fill",password: $password, passwordBuoc1: $passwordBuoc1, isShowConFirmPassCodeView: $isShowConFirmPassCodeView)
                    
                    PasswordButton2(value: "0", password: $password, passwordBuoc1: $passwordBuoc1, isShowConFirmPassCodeView: $isShowConFirmPassCodeView)
                }
                .padding(.bottom)
                
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        
        //Bước 2: hiện page cho user confirm mã PIN sau khi bước 1 ok
        else{
            VStack{
                
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.top,20)
                
                Text("Please Confirm your PIN number")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .padding(.top,20)
                    .foregroundColor(.red)
                
                HStack(spacing: 22){
                    
                    // Password Circle View...
                    
                    ForEach(0..<6,id: \.self){index in
                        
                        PasswordView3(index: index, password: $password)
                    }
                }
                // for smaller size iphones...
                .padding(.top,10)
                
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3),spacing: UIScreen.main.bounds.width < 750 ? 5 : 15){
                    
                    // Password Button ....
                    
                    ForEach(1...9,id: \.self){value in
                        
                        PasswordButton3(value: "\(value)",password: $password, passwordBuoc1: $passwordBuoc1, walletName: $walletName, isUserPass_PIN_making: $isUserPass_PIN_making)
                    }
                    
                    PasswordButton3(value: "delete.fill",password: $password, passwordBuoc1: $passwordBuoc1, walletName: $walletName, isUserPass_PIN_making: $isUserPass_PIN_making)
                    
                    PasswordButton3(value: "0", password: $password, passwordBuoc1: $passwordBuoc1, walletName: $walletName, isUserPass_PIN_making: $isUserPass_PIN_making)
                }
                .padding(.bottom)
                
                
                //Reset lại Pin nếu user quên mất lần nhập ở bước 1
                Button {
                    print("Reset your Passcode! return lại bước 1")
                    isShowConFirmPassCodeView = false
                    password.removeAll()
                } label: {
                    Text("Reset your Passcode!")
                        .font(.body)
                       
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

//================//////////

struct PasswordView2 : View {
    
    var index : Int
    @Binding var password : String
    
    var body: some View{
        
        ZStack{
            
            Circle()
                .stroke(Color.blue,lineWidth: 2)
                .frame(width: 30, height: 30)
            
            // checking whether it is typed...
            
            if password.count > index{
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 30, height: 30)
            }
        }
    }
}


//================//////////

struct PasswordView3 : View {
    
    var index : Int
    @Binding var password : String
    
    
    var body: some View{
        
        ZStack{
            
            Circle()
                .stroke(Color.red,lineWidth: 2)
                .frame(width: 30, height: 30)
            
            // checking whether it is typed...
            
            if password.count > index{
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 30, height: 30)
            }
        }
    }
}


///////////////========================////////////
struct PasswordButton2 : View {
    
    var value : String
    @Binding var password : String
    @Binding var passwordBuoc1 : String
    @Binding var isShowConFirmPassCodeView:Bool
    
    var body: some View{
        
        Button(action: setPassword, label: {
            
            VStack{
                
                if value.count > 1{
                    
                    // Image...
                    
                    Image(systemName: "delete.left")
                        .font(.system(size: 24))
                        .foregroundColor(.blue)
                }
                else{
                    
                    Text(value)
                        .font(.title)
                        .foregroundColor(.blue)
                }
            }
            .padding()

        })
    }
    
    func setPassword(){
        
        // checking if backspace pressed...
        
        withAnimation{
            
            if value.count > 1{
                
                if password.count != 0{
                    
                    password.removeLast()
                }
            }
            else{
                
                if password.count != 6{
                    
                    password.append(value)
                    
                    // Delay Animation...
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        
                        withAnimation{
                            
                            if password.count == 6{
                                
                                print(password)
                               //gọi tiếp view confirm passcode
                                self.isShowConFirmPassCodeView = true
                                //bắn password ra cho bên view bên trên
                                self.passwordBuoc1 = password
                                //reset lại password để cho view sau trống trơn
                                password.removeAll()
                            }
                        }
                    }
                }
            }
        }
    }
}




////==============================
struct PasswordButton3 : View {
    
    var value : String
    @Binding var password : String
    @Binding var passwordBuoc1 : String
    @Binding var walletName: String
    @Binding var isUserPass_PIN_making:Bool
    var body: some View{
        
        Button(action: setPassword, label: {
            
            VStack{
                
                if value.count > 1{
                    
                    // Image...
                    
                    Image(systemName: "delete.left")
                        .font(.system(size: 24))
                        .foregroundColor(.red)
                }
                else{
                    
                    Text(value)
                        .font(.title)
                        .foregroundColor(.red)
                }
            }
            .padding()

        })
    }
    
    func setPassword(){
        
        // checking if backspace pressed...
        
        withAnimation{
            
            if value.count > 1{
                
                if password.count != 0{
                    
                    password.removeLast()
                }
            }
            else{
                
                if password.count != 6{
                    
                    password.append(value)
                    
                    // Delay Animation...
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        
                        withAnimation{
                            
                            if password.count == 6{
                                print("password trước đó: ", passwordBuoc1)
                                print("password confirm: ",password)
                               //check if hai pass trùng hay không
                                if (passwordBuoc1 == password)
                                {
                                    print("OK PASS")
                                    //save pass vào keychain
                                    print("tạo ví tên là: ", walletName)
                                    let data = Data(password.utf8)
                                    keychain_save(data, service: "PoolsWallet_KeyChain_PIN", account: walletName)
                                    print("save vao key chain xong ví: ", walletName)
                                    let d = keychain_read(service: "PoolsWallet_KeyChain_PIN", account: walletName)
                                    print("mã pin là: ",String(decoding: d ?? Data(), as: UTF8.self))
                                    
                                    //nếu đã ok bước tạo mã pin, 2 mã pin trùng khớp, ta sẽ tạo wallet với 12 ký tự -> thông báo ra bên ngoài package
                                    //ghi vào userdefault để chạy app lần sau không cần load view tao wallet nữa mà dùng mã pin login chạy vào app luôn
                                    self.isUserPass_PIN_making = true
                                }
                                else{
                                    print("PASS CODE FAIL!")
                                    password.removeAll()
                                }
                               
                            }
                        }
                    }
                }
            }
        }
    }
}

