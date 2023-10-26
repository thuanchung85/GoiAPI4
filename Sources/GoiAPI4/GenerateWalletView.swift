
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers


public struct GenerateWalletView: View {
   
  
   
    @State var addressWallet:String = ""
   
    @State var isStillLoadingWallet = true
    
    public init() {
        
    }
    
    public var body: some View{
        NavigationView {
            VStack{
                //nếu chưa load ví xong thì còn show hình mờ
                if(isStillLoadingWallet == true){
                        LoadingView(addressWallet: $addressWallet,
                                    isStillLoadingWallet: $isStillLoadingWallet, isShowing:  $isStillLoadingWallet)
                        {
                            //Choose View
                            VStack(alignment: .center) {
                                Spacer()
                                HStack(alignment: .center){
                                    Text("THIS IS YOUR WALLET").font(.title)
                                }.padding(.bottom,30)
                                Spacer()
                            }
                            
                        }
                    
                }
                //nếu load ví xong thì show ra
                else{
                    //Choose View
                    VStack(alignment: .center) {
                        Text("THIS IS YOUR WALLET").font(.title)
                        
                    }
                    
                }
                
            }
        }//end navigation view
          
    }//end body
    
    
    
    
}//end struct


