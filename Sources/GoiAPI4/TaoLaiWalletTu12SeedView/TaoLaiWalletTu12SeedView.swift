
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers


public struct TaoLaiWalletTu12SeedView: View {
   
    @Binding var string12SeedText:String
   
    @State var addressWallet:String = ""
   
    @State var isStillLoadingWallet = true
    
    @Binding var userPassRecoveryWalletby12Seed:Bool
    
    //===INIT==//
    public init(string12SeedText:Binding<String>, userPassRecoveryWalletby12Seed:Binding<Bool>) {
        self._string12SeedText = string12SeedText
        self._userPassRecoveryWalletby12Seed = userPassRecoveryWalletby12Seed
    }
    
    //==BODY==//
    public var body: some View{
            VStack(alignment: .center){
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
                    //Choose View
                    VStack(alignment: .center) {
                        Text("THIS IS YOUR WALLET").font(.title)
                        QRCodeMakerView(walletAddress: $addressWallet,width: 300,height: 300)
                        
                        //nut next để user pass khỏi quá trình này
                        Button {
                            userPassRecoveryWalletby12Seed = true
                        } label: {
                            Text("NEXT!")
                                .font(.body)
                               
                        }
                       
                    }
                    
                }
                
            }
       
          
    }//end body
    
    
    
    
}//end struct


