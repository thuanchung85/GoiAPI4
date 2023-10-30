
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
    
    //===INIT==//
    public init(string12SeedText:Binding<String>, isPassOldWalletView:Binding<Bool>,wallNewName:Binding<String>) {
        self._string12SeedText = string12SeedText
        self._isPassOldWalletView = isPassOldWalletView
        self._wallNewName = wallNewName
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
                            //Choose View
                            VStack(alignment: .center) {
                               
                                HStack(alignment: .center){
                                    Text("THIS IS YOUR WALLET").font(.title)
                                        .padding(.horizontal)
                                }.padding(.bottom,30)
                               
                                Spacer()
                            }
                            
                        }
                    
                }
                //nếu generate ví xong thì show ra mã QR
                else{
                    if(self.addressWallet == "no data"){
                        Text("YOUR 12 SEED WORDS IS NOT CORRECT, PLEASE TRY AGAIN!").font(.title)
                            .padding(.horizontal)
                        //nut next để user pass khỏi quá trình này
                        Button {
                            isPassOldWalletView = false
                        } label: {
                            Text("TRY AGAIN")
                                .font(.body)
                            
                        }
                    }
                    else{
                        ScrollView{
                            //Choose View
                            VStack(alignment: .center) {
                                Text("THIS IS YOUR WALLET").font(.title)
                                
                                TextField("Enter new name", text: $wallNewName)
                                    .font(.body)
                                    .textFieldStyle(.roundedBorder)
                                    .padding(5)
                                QRCodeMakerView( walletAddress: $addressWallet,width: 300,height: 300)
                                
                                //nut next để user pass khỏi quá trình này
                                Button {
                                    isPassOldWalletView = true
                                } label: {
                                    Text("NEXT!")
                                        .font(.body)
                                    
                                }
                                
                            }
                        }
                    }
                }
                
            
       
          
    }//end body
    
    
    
    
}//end struct


