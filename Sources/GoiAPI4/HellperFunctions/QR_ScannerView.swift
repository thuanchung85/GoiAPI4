//
//  File.swift
//  
//
//  Created by SWEET HOME (^0^)!!! on 27/10/2023.
//

import Foundation
import SwiftUI
import AVKit

struct QR_ScannerView: View {
    
    @State  var session:AVCaptureSession = .init()
    @State var qrOutput:AVCaptureMetadataOutput = .init()
    
    @State var errorMessage: String = ""
    @State var showError:Bool = false
    
   
    //===BODY==//
    var body: some View {
        VStack(spacing: 8){
            Button{
                
            } label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundColor(Color.blue)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
                
            Text("Place the QR code inside the area")
                .font(.title3)
                .foregroundColor(.black.opacity(0.8))
                .padding(.top,20)
            
            Text("Scanning will start automatically")
                .font(.callout)
                .foregroundColor(.gray)
            
            //scanner
            GeometryReader{
                let size = $0.size
                ZStack{
                    CameraView(frameSize: size, session: $session)
                    
                    ForEach(0...4, id: \.self){ index in
                        let rotation = Double(index) * 90
                       
                        RoundedRectangle(cornerRadius: 2,style: .circular)
                            .trim(from: 0.61,to: 0.64)
                            .stroke(Color.blue,style: StrokeStyle(lineWidth: 5,lineCap: .round,lineJoin: .round))
                            .rotationEffect(.init(degrees: rotation))
                    }
                }
                .frame(width: size.width,height: size.width)
               
                .frame(maxWidth: .infinity,maxHeight: .infinity)
            }.padding(.horizontal,45)
            
            
            
            Spacer(minLength: 15)
            
            Button{
                
            } label: {
                Image(systemName: "qrcode.viewfinder")
            }
            
        }//end VStack
        .padding(15)
        .alert(isPresented: $showError) {
            Alert(title: Text("QR SCAN ERROR"))
        }
        .onAppear(perform:  checkCameraPermission)
    }//end body
    
}//end struct

//hàm check quyền truy câp camera
func checkCameraPermission(){
    if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
        //already authorized
        print("CAMERA already authorized")
    } else {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            if granted {
                //access allowed
                print("CAMERA access allowed")
            } else {
                //access denied
                print("CAMERA access denied")
            }
        })
    }
}
