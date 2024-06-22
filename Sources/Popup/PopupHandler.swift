//
//  PopupHandler.swift
//  Eucalypt
//
//  Created by Dave Coleman on 24/3/2024.
//

import Foundation
import SwiftUI

public protocol Popupable {
    func showPopup(title: String, message: String?, location: PopupLocation) async
}

public struct PopupLocation: Equatable {
    public var id: String
    
    public init(_ id: String) {
        self.id = id
    }
}

@MainActor
public struct PopupMessage {
    public var isLoading: Bool = false
    public var title: String
    public var message: String? = nil
    public var location: PopupLocation = PopupLocation("main")
}

@MainActor
public class PopupHandler: ObservableObject, Popupable {
    
    @Published var popupMessage: PopupMessage? = nil
    
    public init(
        message: PopupMessage? = nil,
        popupTask: Task<Void, Never>? = nil
    ) {
        self.popupMessage = message
        self.popupTask = popupTask
    }
    
    private var popupTask: Task<Void, Never>? = nil
    
    public func showPopup(
        title: String,
        message: String? = nil,
        location: PopupLocation = PopupLocation("main")
    ) {
        let popupMessage = PopupMessage(
            isLoading: false,
            title: title,
            message: message,
            location: location
        )
        Task {
            await showAndHidePopup(popupMessage: popupMessage)
        }
    }
    
    private func showAndHidePopup(popupMessage: PopupMessage) async {
        popupTask?.cancel()
        print("Popup triggered: \(popupMessage.title)")
        
        popupTask = Task { [weak self] in
            await self?.displayPopup(popupMessage: popupMessage)
            
            do {
                if #available(iOS 16.0, *) {
                    try await Task.sleep(for: .seconds(2.5))
                } else {
                    // Fallback on earlier versions
                }
            } catch {
                return
            }
            
            await self?.hidePopup()
        }
    } // END show hide popup
    
    private func displayPopup(popupMessage: PopupMessage) async {
        await MainActor.run {
            withAnimation(.easeOut(duration: 0.1)) {
                self.popupMessage = popupMessage
            }
        }
    }
    
    private func hidePopup() async {
        await MainActor.run {
            withAnimation(.easeInOut(duration: 0.6)) {
                self.popupMessage = nil
            }
        }
    }
}
