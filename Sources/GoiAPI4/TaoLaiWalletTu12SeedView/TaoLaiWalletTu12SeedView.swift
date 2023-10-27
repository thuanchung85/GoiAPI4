
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers


public struct TaoLaiWalletTu12SeedView: View {
   
    @Binding var string12SeedText:String
   
    @State var addressWallet:String = ""
   
    @State var isStillLoadingWallet = true
    
    
    //===INIT==//
    public init(string12SeedText:Binding<String>) {
        self._string12SeedText = string12SeedText
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
                        
                        //nut next để enter name mới và passcode
                        NavigationLink(destination:  FormEnterNewNameVaPassCode())
                        {
                            Text("NEXT")
                                .foregroundColor(.white)
                                .padding(12)
                            
                        }
                        .background(Color.black)
                        .cornerRadius(12)
                    }
                    
                }
                
            }
       
          
    }//end body
    
    
    
    
}//end struct


