//
//  NetworkingManager.swift
//  CryptotrackerApp
//
//  Created by Kyungyun Lee on 07/04/2022.
//

import Foundation
import Combine

class NetworkingManager { // 네트워크에 대한 타입메서드를 모두 모아둔다.
    
    enum NetworkingEror : LocalizedError {
        case badURLResponse(url : URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return "[🔥] Bad response from URL \(url)"
            case .unknown:
                return "[⚠️] Unknown Error"
            }
        }
    }
    
    static func download(url : URL) -> AnyPublisher<Data, Error> {
        
        return
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background)) // 백그라운드에서 작업하고
            .tryMap { try handleURLResponse(output: $0, url: url)}
            .receive(on: DispatchQueue.main) // 메인스레드로 불러온다.
            .eraseToAnyPublisher()
    }
    
    static func handleCompletion(completion : Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    static func handleURLResponse(output : URLSession.DataTaskPublisher.Output, url : URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingEror.badURLResponse(url: url)
        }
        return output.data
    }
    
}
