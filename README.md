# Newsletter iOS
Supports: iOS 15.x and above

A simple app with a list of posts from  **[JSONPlaceholder API](https://jsonplaceholder.typicode.com)**.

![demo](/readme-files/demo.png)

## Getting Started

1. Clone the repo
```
git clone https://github.com/luiszarg96/newsletter-ios.git
```

2. Download dependencies. This project use third part libraries that are managed using **[Cocoapods](https://cocoapods.org/)**. After cloning this repo, you must run the following command:

```
pod install
```
3. CocoaPods is built with Ruby and is installable with the default Ruby available on macOS. We recommend you use the default ruby. If you don't have cocoapods installed yet, try run the following command and then retry step 2.

```
sudo gem install cocoapods
```


## Project structure:
MVVM Arquitecture

* Application Layer- AppDelegate for project
* Presentation Layer - contains app scenes  (UI + Code)
* Business Logic Layer - contains services and models
* Core Layer - contains resources, utilities, extensions and network classes
* Supporting Files - libs, common views, helpers

## Acknowledgments
* This project is for a challenge purpose, so the next approach is to improve the performance.
* Unit test are not included for this version.