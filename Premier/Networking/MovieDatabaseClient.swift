//
//  MovieDatabaseClient.swift
//  Premier
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import Alamofire
import ObjectMapper
#if DEBUG
import Reqres
#endif

enum MovieDatabaseClientError: Error {
    case connectionError(Error)
    case corruptedData
    case mappingFailed
}

class MovieDatabaseClient {
    
    static var shared = MovieDatabaseClient()
    
    private let manager: SessionManager
    
    init() {
        #if DEBUG
            let configuration = Reqres.defaultSessionConfiguration()
            manager = SessionManager(configuration: configuration)
        #else
            manager = SessionManager()
        #endif
    }
    
    @discardableResult func execute<T>(
        _ request: URLRequestConvertible,
        handler: @escaping (_ response: Response<T>) -> Void) -> URLSessionTask? {
        let dataRequest = manager.request(request)
        dataRequest.responseJSON { (dataResponse: DataResponse<Any>) in
            let result: Result<T>
            switch dataResponse.result {
            case .success(let value):
                if let JSON = value as? [String: Any] {
                    if let object = T(JSON: JSON) {
                        result = .success(object)
                    } else {
                        result = .failure(MovieDatabaseClientError.mappingFailed)
                    }
                } else {
                    result = .failure(MovieDatabaseClientError.corruptedData)
                }
            case .failure(let error):
                result = .failure(MovieDatabaseClientError.connectionError(error))
            }
            handler(Response<T>(
                request: dataResponse.request,
                response: dataResponse.response,
                data: dataResponse.data,
                result: result
            ))
        }
        return dataRequest.task
    }
    
}
