AmhiSevikari iOS

A devotional mobile application developed for Dagdusheth Datta Mandir, Pune, providing easy access to bhajan collections, devotional lyrics, and categorized spiritual content.

Overview

AmhiSevikari is a SwiftUI-based devotional application designed to help devotees browse and read bhajans dedicated to various Hindu deities.

The application uses Firebase Firestore as a cloud-based content source and provides a simple, intuitive experience for accessing devotional lyrics anytime.

Features

Bhajan Categories

* Ganpati Bhajans
* Datta Bhajans
* Vitthal Bhajans
* Devi Bhajans
* Other Devotional Categories

Lyrics Management

* Browse Bhajan Collections
* View Detailed Lyrics
* Organized Category Navigation
* Fast Content Loading

Data Synchronization

* Firebase Firestore Integration
* Automatic Content Synchronization
* Offline Content Availability
* Background Sync Scheduling

Architecture

The application follows MVVM architecture.

Layers

Data Layer

* Firestore Service
* Repository Pattern
* Sync Scheduler

Domain Layer

* Business Logic
* Data Models

Presentation Layer

* SwiftUI Views
* ViewModels
* State Management

Technologies Used

* SwiftUI
* Swift
* Firebase Firestore
* MVVM
* Repository Pattern
* Async Data Synchronization
* Swift Package Manager

Project Structure
Data
├── FirestoreService
├── Repository
└── SyncScheduler

Models
├── Bhajan
└── Category

ViewModels
├── MainViewModel
├── LyricsViewModel
└── SublistViewModel

Views
├── SplashView
├── MainView
├── SublistView
└── LyricsView

Screenshots

Splash Screen
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-06-08 at 21 28 53" src="https://github.com/user-attachments/assets/7700c8f8-af18-44d9-8089-7cbafa437964" />

Category Listing
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-06-08 at 21 28 57" src="https://github.com/user-attachments/assets/8642b303-779e-4af7-8394-057bd7c3e3e0" />


Bhajan List
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-06-08 at 21 29 06" src="https://github.com/user-attachments/assets/ecd22c43-7397-4397-a885-357dbbd58543" />

Lyrics Screen
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-06-08 at 21 29 23" src="https://github.com/user-attachments/assets/a50aee96-8340-4218-89ba-77b9acfcd345" />

Shearing Screen
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-06-08 at 21 29 00" src="https://github.com/user-attachments/assets/17c7a221-c1ab-4a4d-a1f7-7f9a18418993" />

Dashboard Screen
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-06-08 at 21 29 33" src="https://github.com/user-attachments/assets/885eedd7-d7ce-48a3-b959-6d51d320afef" />


Use Case
This application was developed to provide devotees with easy access to devotional content and bhajan lyrics through a modern mobile experience.

Author

Mayur Rokade

iOS Developer | SwiftUI | Firebase | MVVM
