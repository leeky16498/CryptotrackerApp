//
//  LocalFileManager.swift
//  CryptotrackerApp
//
//  Created by Kyungyun Lee on 07/04/2022.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    private init() {}
    
    func saveImage(image : UIImage, folderName : String, imageName : String) {
        
        createFolderIfNeeded(folderName: folderName) // 폴더를 만들고
        
        //이미지 저장경로를 정하고
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName) else {return}
       
        //이미지를 저장해준다.
        do {
            try data.write(to: url)
        } catch let error {
            print("error to save images \(error)")
        }
    }
    
    private func createFolderIfNeeded(folderName : String) {
        guard let url = getURLForFolder(folderName: folderName) else {return}
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("error to creating directory = \(error)")
            }
        }
    }
    
    func getImage(imageName : String, folderName : String) -> UIImage? {
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {return nil}
        return UIImage(contentsOfFile: url.path)
    }
    
    private func getURLForFolder(folderName : String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
        
        return url.appendingPathComponent(folderName)
    } // 이미지 파일이 저장될 폴더의 경로를 지정해주었다.
    
    private func getURLForImage(imageName : String, folderName : String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {return nil}
        return folderURL.appendingPathComponent(imageName + ".png")
    } // 폴더의 경로에 이미지를 저장할 경로를 지정해주었다.
    
}
