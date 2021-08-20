//
//  ContentView.swift
//  poc-snackbar
//
//  Created by Accounting on 19/08/21.
//

import SwiftUI

struct ContentView: View {
    @State var showToast = false
    @State var showSuccessToast = false
    var body: some View {
        VStack {
            Button(action: {
                showToast = true
            }, label: {
                Text("munculkan toast")
            })
        }
        .overlay(overlayView: toastView, show: $showToast)
        .overlay(overlayView: successToast, show: $showSuccessToast)
//        .overlay(overlayView: Toast(showToast: $showToast, content: {
//            toastView
//        }),
//                  show: $showToast)
        
    }
    var successToast : some View {
        Toast(
            showToast: $showSuccessToast,
            duration: 2,
            onViewSlides: {
                print("di slide nih")
            },
            onFinishAfterShown: {
                print("di diemin nih")
            },
            content: {
            VStack(alignment: .leading, spacing: 10) {
                Text("Sukses mengirim")
                    .font(.system(size: 14))
                HStack(spacing: 10) {
                    Spacer()
                    Button(action: {
                        print("kirim ulang pressed")
                        withAnimation{
                            showSuccessToast = false
                        }
                    }, label: {
                        Text("Kirim Ulang")
                            .bold()
                            .font(.system(size: 14))
                    })
                }
                
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(Color.black)
                .padding(16)
                .background(Color.blue)
                .cornerRadius(8)
        })
    }
    
    var toastView : some View {
        Toast(
            showToast: $showToast,
            duration: 10,
            onViewSlides: {
                print("di slide nih")
            },
            onFinishAfterShown: {
                print("di diemin nih")
            },
            content: {
            VStack(alignment: .leading, spacing: 10) {
                Text("Belum menerima email verifikasi? Ajukan kirim ulang tautan.")
                    .font(.system(size: 14))
                HStack(spacing: 10) {
                    Spacer()
                    Button(action: {
                        print("kirim ulang pressed")
                        withAnimation{
                            showToast = false
                            showSuccessToast = true
                        }
                    }, label: {
                        Text("Kirim Ulang")
                            .bold()
                            .font(.system(size: 14))
                    })
                }
                
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(Color.black)
                .padding(16)
                .background(Color(red: 1, green: 0.851, blue: 0.6, opacity: 1))
                .cornerRadius(8)
        })
    }
}
