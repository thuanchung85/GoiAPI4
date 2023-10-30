
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers


public struct OldWalletView: View {
   
    @Binding var string12SeedText:String
   
    @State var addressWallet:String = ""
   
    @State var isStillLoadingWallet = true
    
    @Binding var isPassOldWalletView:Bool
    @Binding var wallNewName:String
    @Binding var isPassInput12Seed:Bool
    
    //===INIT==//
    public init(string12SeedText:Binding<String>, isPassOldWalletView:Binding<Bool>,wallNewName:Binding<String>, isPassInput12Seed:Binding<Bool>) {
        self._string12SeedText = string12SeedText
        self._isPassOldWalletView = isPassOldWalletView
        self._wallNewName = wallNewName
        self._isPassInput12Seed = isPassInput12Seed
    }
    
    //==BODY==//
    public var body: some View{
          
                //nếu chưa re generate  ví xong thì còn show hình mờ
                if(isStillLoadingWallet == true){
                        LoadingView(addressWallet: $addressWallet,
                                    isStillLoadingWallet: $isStillLoadingWallet,
                                    string12SeedText : string12SeedText,
                                    isShowing:  $isStillLoadingWallet)
                        {
                            //View giả bị che mờ , nó không có tác dụng gì, không tương tác
                               
                                    VStack(alignment: .center) {
                                        Text("YOUR WALLET SUCCESSFULLY RESTORED")
                                            .frame(width: 400)
                                            .font(.custom("Arial ", size: 18))
                                            .padding(.top,10)
                                            .padding(.horizontal,5)
                                        
                                        TextField("Re-enter your wallet name", text: $wallNewName)
                                            .font(.custom("Arial ", size: 15))
                                            .textFieldStyle(.roundedBorder)
                                            .padding(5)
                                        
                                        Spacer()
                                        
                                        //nut next để user pass khỏi quá trình này
                                        Button {
                                            isPassOldWalletView = true
                                        } label: {
                                            Text("NEXT")
                                                .frame(width: 120)
                                                .padding()
                                                .foregroundColor(.white)
                                        }
                                        .background(Color.green)
                                        .cornerRadius(30)
                                        .padding(.bottom,10)
                                        
                                    }
                                
                        }
                    
                }
                //nếu generate ví xong thì show ra mã QR
                else{
                    if(self.addressWallet == "no data"){
                        Text("Your 12 word backup phrase does not work, please try another!")
                            .font(.custom("Arial ", size: 20))
                            .multilineTextAlignment(.center)
                            .padding(20)
                        //nut next để user pass khỏi quá trình này
                        Button {
                            isPassInput12Seed = false
                            isPassOldWalletView = false
                            
                        } label: {
                            Text("TRY AGAIN")
                                .frame(width: 120)
                                .padding()
                                .foregroundColor(.white)
                        }
                        .background(Color.green)
                        .cornerRadius(30)
                        .padding(.bottom,10)
                    }
                    else{
                        ScrollView{
                            //Choose View
                            VStack(alignment: .center) {
                                Text("YOUR WALLET SUCCESSFULLY RESTORED")
                                    .frame(width: 400)
                                    .font(.custom("Arial ", size: 18))
                                    .padding(.top,10)
                                    .padding(.horizontal,5)
                                
                                TextField("Re-enter your wallet name", text: $wallNewName)
                                    .font(.custom("Arial ", size: 15))
                                    .textFieldStyle(.roundedBorder)
                                    .padding(5)
                                
                                QRCodeMakerView( walletAddress: $addressWallet,width: 300,height: 300)
                                
                                //nut next để user pass khỏi quá trình này
                                Button {
                                    isPassOldWalletView = true
                                } label: {
                                    Text("NEXT")
                                        .frame(width: 120)
                                        .padding()
                                        .foregroundColor(.white)
                                }
                                .background(Color.green)
                                .cornerRadius(30)
                                .padding(.bottom,10)
                                
                            }
                        }
                    }
                }
                
            
       
          
    }//end body
    
    
    
    
}//end struct


