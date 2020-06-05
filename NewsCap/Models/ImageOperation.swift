//
//  ImageOperation.swift
//  NewsCap
//
//  Created by Chris on 24/05/2020.
//  Copyright © 2020 Chris78. All rights reserved.
//

import UIKit
import Alamofire

class ImageOperation: Operation {
    var url: String
    var destination: DownloadRequest.Destination
    var imageResponse: ArticlesModel.FetchImage.Response?

    private let lockQueue = DispatchQueue(label: "com.chris78.NewsCap", attributes: .concurrent)

    override var isAsynchronous: Bool {
        return true
    }

    private var _isExecuting: Bool = false
    override private(set) var isExecuting: Bool {
        get {
            return lockQueue.sync { () -> Bool in
                return _isExecuting
            }
        }
        set {
            willChangeValue(forKey: "isExecuting")
            lockQueue.sync(flags: [.barrier]) {
                _isExecuting = newValue
            }
            didChangeValue(forKey: "isExecuting")
        }
    }

    private var _isFinished: Bool = false
    override private(set) var isFinished: Bool {
        get {
            return lockQueue.sync { () -> Bool in
                return _isFinished
            }
        }
        set {
            willChangeValue(forKey: "isFinished")
            lockQueue.sync(flags: [.barrier]) {
                _isFinished = newValue
            }
            didChangeValue(forKey: "isFinished")
        }
    }

    override func start() {
        print("Starting \(url)")
        isFinished = false
        isExecuting = true
        main()
    }

    func finish() {
        isExecuting = false
        isFinished = true
    }

    init(url: String, path: URL) {
        self.url = url
        self.destination = { _, _ in
            return (path, [.removePreviousFile, .createIntermediateDirectories])
        }

        super.init()
    }

    override func main() {

        let requestImage = AF.download(url, to: destination)

        requestImage.responseData { response in
            switch response.result {
            case .success:
                self.imageResponse = ArticlesModel.FetchImage.Response(
                    imageUrl: self.url,
                    image: UIImage(data: response.value!),
                    isError: false)
                self.finish()
            case let .failure(error):
                print("ERROR")
                print(error.errorDescription.debugDescription)
                self.imageResponse = ArticlesModel.FetchImage.Response(
                    isError: true,
                    message: error.errorDescription)
                self.finish()
            }
        }
    }
}
