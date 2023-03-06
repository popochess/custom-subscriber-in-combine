//
//  ViewController.swift
//  BenCombineExample
//
//  Created by Ben Lee on 2023/2/21.
//

import UIKit
import Combine

class ViewController: UIViewController {

    var cancellables: Set<AnyCancellable> = []
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var textLabel: UILabel!

    var cancelable: Cancellable?

    override func viewDidLoad() {
        super.viewDidLoad()

        // You can try replacing `sink` with `segmentSink` and observe the difference in the UI.
        (1...50000).publisher.sink(
            receiveCompletion: { completion in
                print("Completion: \(completion)")
                _ = self.cancellables.map { $0.cancel() }
            },
            receiveValue: { value in
                print("Receive value: \(value)")
                DispatchQueue.main.async {
                    self.textLabel.text = String(value)
                    self.progressBar.progress = Float(value)/50000.0
                }
            }
        ).store(in: &cancellables)
    }
}
