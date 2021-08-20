//
//  Toast.swift
//  Toast
//
//  Created by Accounting on 19/08/21.
//

import SwiftUI

struct Toast<Content: View>: View {
    let content: Content
    @Binding var show: Bool
    @State private var offset = CGSize.zero
    var duration : Int = 10
    var onViewSlides : () -> Void
    var onFinishAfterShown : () -> Void
    init(
        showToast : Binding<Bool>,
        duration : Int,
        onViewSlides : @escaping () -> Void,
        onFinishAfterShown : @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ){
        self.onViewSlides = onViewSlides
        self.onFinishAfterShown = onFinishAfterShown
        self.duration = duration
        _show = showToast
        self.content = content()
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                self.content
                    .offset(x: offset.width * 5, y: 0)
                    .opacity(2 - Double(abs(offset.width / 40)))
                    .gesture(
                        DragGesture()
                            .onChanged({ gesture in
                                self.offset = gesture.translation
                                print(offset.width)
                            })
                            .onEnded({ _ in
                                if abs(self.offset.width) > 50 {
                                    withAnimation{
                                        self.show = false
                                    }
                                    self.onViewSlides()
                                } else {
                                    self.offset = .zero
                                }
                            })
                    )
            }
        }
        .padding(.bottom, 30)
        .padding(.horizontal, 16)
        .animation(.easeInOut(duration: 1))
        .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now().advanced(by: DispatchTimeInterval.seconds(duration))) {
                if self.show {
                    withAnimation{
                        self.show = false
                    }
                    self.onFinishAfterShown()
                }
            }
        })
    }
}


struct Overlay<T: View>: ViewModifier {
    @Binding var show: Bool
    let overlayView: T
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if show {
                overlayView
            }
        }
    }
}

extension View {
    func overlay<T: View>(overlayView: T, show: Binding<Bool>) -> some View {
        self.modifier(Overlay.init(show: show, overlayView: overlayView))
    }
}
