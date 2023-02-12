//
//  SheetModel.swift
//  Natega
//
//  Created by Daniel Kamel on 12/02/2023.
//

import SwiftUI

struct SheetModel: View {
    
    @State var showSheet: Bool? = nil
    
    var body: some View {
        Button(action: {
            
            showSheet = true
            
        }, label:{Text("Tap me to pull up sheet")})
        .halfSheet(showSheet: $showSheet) {
            
            ZStack {
                
                Color.white
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack {
                        
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .frame(width: 40, height: 5)
                            .foregroundColor(.black.opacity(0.3))
                            .padding(.top, 10)
                        
                        Text("Hello half sheet")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                            .padding(.bottom, 20)
                        
                        Button(action: { showSheet = false }) {
                            Text("Tap me to close sheet")
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        } onDismiss: {
            print("sheet dismissed")
        }
        
    }
}

struct SheetModel_Previews: PreviewProvider {
    static var previews: some View {
        SheetModel()
    }
}

extension View {
    //binding show bariable...
    func halfSheet<Content: View>(
        showSheet: Binding<Bool?>,
        @ViewBuilder content: @escaping () -> Content,
        onDismiss: @escaping () -> Void
    ) -> some View {
        return self
            .background(
                HalfSheetHelper(sheetView: content(), showSheet: showSheet, onDismiss: onDismiss)
            )
    }
}

// UIKit integration
struct HalfSheetHelper<Content: View>: UIViewControllerRepresentable {
    
    var sheetView: Content
    let controller: UIViewController = UIViewController()
    @Binding var showSheet: Bool?
    var onDismiss: () -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if let showSheet: Bool = showSheet {
            if showSheet {
                let sheetController = CustomHostingController(rootView: sheetView)
                sheetController.presentationController?.delegate = context.coordinator
                uiViewController.present(sheetController, animated: true)
            } else {
                uiViewController.dismiss(animated: true, completion: onDismiss)
            }
        }
    }
    
    //on dismiss...
    final class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        
        var parent: HalfSheetHelper
        
        init(parent: HalfSheetHelper) {
            self.parent = parent
        }
        
        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            parent.showSheet = false
        }
    }
}

// Custom UIHostingController for halfSheet...
final class CustomHostingController<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        view.backgroundColor = .clear
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
                .large()
            ]
            
            //MARK: - sheet grabber visbility:
            presentationController.prefersGrabberVisible = false
            
            // i added the code below so that you can scroll when you have medium view
            // here is good article for customising sheet in UIKit - https://sarunw.com/posts/bottom-sheet-in-ios-15-with-uisheetpresentationcontroller/#scrolling
            presentationController.prefersScrollingExpandsWhenScrolledToEdge = false
            
            //MARK: - sheet corner radius:
            presentationController.preferredCornerRadius = 30
        }
    }
}

public struct LazyView<Content: View>: View {
    private let build: () -> Content
    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    public var body: Content {
        build()
    }
}
