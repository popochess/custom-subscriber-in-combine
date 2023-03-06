# custom-subscriber-in-combine
Here's an example of how to create a custom subscriber in Combine


<img width="750" alt="custom_subscriber_process" src="https://user-images.githubusercontent.com/236130/223006660-864b919b-214b-4294-b3f8-8b650d2023f8.png">


# SegmentSink

In this project, you could replace the term `sink` with `segmentSink` to see how it affects the user interface.

```
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
```

### Using `publisher.sink`
![default-sink](https://user-images.githubusercontent.com/236130/223008278-d98a6590-71c2-4144-8055-f2a4379e4cfb.gif)

### Using `publisher.segmentSink`
![segment-sink](https://user-images.githubusercontent.com/236130/223008632-3328f6a1-cd44-4590-a0cf-69d56cf12f3a.gif)
