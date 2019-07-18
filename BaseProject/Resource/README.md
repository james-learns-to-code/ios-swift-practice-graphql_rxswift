# ios-swift-mvvm-project
Example of MVVM with iOS, Swift Project

## Purpose
Demonstrate MVVM Architected project for iOS, Swift and improve continously.

## API
For demonstrate use of api, i use swapi(https://swapi.co)

## ViewController
For demonstrate diverse use case of ViewController, i create diverse ViewController

## Library
Minimize use of Third-party library.

## View & ViewController
I prefer separate view setup code to view-class side. It can archive by using view switching.

    override func loadView() {
        super.loadView()
        view = customView
    }

When ViewController's loadView() is called, implant custom view to ViewController's view. Then you can put the view-setup code to view-class.
