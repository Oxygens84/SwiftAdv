//
//  SelfiExtension.swift
//  SwiftAdv
//
//  Created by Oxana Lobysheva on 31/08/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

import UIKit
import AVFoundation

extension AuthViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true) { [weak self] in
            guard let image = self?.extractImage(from: info) else { return }
            let fm = AvatarManager()
            fm.saveAvatar(image)
        }
        performSegue(withIdentifier: SeguesId.goToSelfie.rawValue, sender: nil)
    }
    
    private func extractImage(from info: [UIImagePickerController.InfoKey: Any]) -> UIImage? {
        if let image = info[.editedImage] as? UIImage {
            return image
        } else if let image = info[.originalImage] as? UIImage {
            return image
        } else {
            return nil
        }
    }
   
}
