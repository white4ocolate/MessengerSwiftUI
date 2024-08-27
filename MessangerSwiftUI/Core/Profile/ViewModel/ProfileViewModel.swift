//
//  ProfileViewModel.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 12.08.2024.
//

import SwiftUI
import PhotosUI

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            Task {
                try await loadImage()
            }
        }
    }
    
    @Published var profileImage: Image?
    
    func loadImage() async throws {
        guard let item = selectedItem else { return }
        guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
        ImageService.shared.uploadImage(imageData) { result in
            switch result {
            case .success(let url):
                print("Успешно загружено изображение, URL: \(url)")
            case .failure(let error):
                print("Ошибка загрузки изображения: \(error)")
            }
        }
        guard let uiImage = UIImage(data: imageData) else { return }
        self.profileImage = Image(uiImage: uiImage)
    }
}
