# RickMortyApp
This project is to design and develop an iOS application using Swift

# Rick and Morty iOS Application  

### **Project Objective**  
The goal of this project is to design and develop an iOS application using **Swift**. The application interacts with the **Rick and Morty API**, retrieves paginated data, and displays it in a table view. This project demonstrates a balance between **UIKit** and **SwiftUI**, showcasing best practices for clean, maintainable, and scalable code.

---

## **Features**  

### **1. Character List Screen**  
- Displays a paginated list of characters, loading **20 characters** per page.
- Each list item includes:  
  - **Name**  
  - **Image**  
  - **Species**  
- **Filtering**: Users can filter the list by character status:  
  - **Alive**  
  - **Dead**  
  - **Unknown**  

### **2. Character Details Screen**  
- Provides a detailed view of a selected character, showing:  
  - **Name**  
  - **Image**  
  - **Species**  
  - **Status**  
  - **Gender**  

---

## **Technical Details**  

- **Language**: Swift  
- **Frameworks**:  
  - **UIKit**: Used for the table view.  
  - **SwiftUI**: Used for custom views and smaller, reusable components (e.g., Character rows).  
- **Architecture**: MVVM (Model-View-ViewModel)  
- **Networking**: A lightweight, custom networking layer to fetch data from the Rick and Morty API without using third-party dependencies.  
- **Pagination**: Implemented with lazy loading, fetching new pages as the user scrolls.  

---

## **Code Highlights**  

1. **Clean, Maintainable Code**:  
   - Proper separation of concerns with a clean MVVM architecture.  
   - `UITableView` is managed using a `UIViewControllerRepresentable` wrapper to bridge UIKit with SwiftUI.  
   - Reusable SwiftUI components for modularity.  

2. **Custom Networking Layer**:  
   - A `NetworkingManager` class handles API requests and error handling, ensuring separation of network logic from UI components.

3. **Filtering Implementation**:  
   - An enum-based filtering mechanism allows dynamic filtering based on character status.  
   - Custom SwiftUI buttons serve as tabs for easy selection.  

4. **No Storyboards or XIBs**:  
   - The entire UI is built programmatically, ensuring flexibility and control over the UI.

---

## **Key Files and Structure**  

```
├── Utilities  
│   ├── NetworkingManager.swift  
│   ├── Constants.swift  
├── Extensions  
│   ├── Color.swift  
│   ├── PreviewProvider.swift  
├── Services  
│   ├── CharactersDataService.swift  
│   ├── CharacterImageService.swift  
├── Models  
    ├── CharacterResponseModel.swift  
│   ├── CharacterModel.swift  
│   ├── CharacterDetailModel.swift  
│   ├── PageInfoModel.swift 
    ├── LocationModel.swift  
├── Core  
│   ├-- Components
│        ├── TableView
│            ├── UITableViewWrapper  
│            ├── CharacterTableViewCell.swift  
│        ├── CharacterImage  
│            ├── CharacterImageView.swift  
│            ├── CharacterImageViewModel.swift
│            ├── CharacterImageView.swift
│        ├── CustomTab  
│            ├── CustomCharacterTabView.swift  
│
├── Launch  
│   ├── LaunchView.swift  
│ 
├── Home  
│   ├── ViewModels.swift  
│       ├── HomeViewModel.swift  
│   ├── Views.swift  
│        ├── HomeView.swift  
│        ├── CharacterRowView.swift        
│
├── Detail  
│   ├── Views.swift  
│       ├── CharacterDetailView.swift  
```

---

## **Usage Instructions**  

1. **Clone the Repository**:  
   Clone the project repository to your local machine.  

2. **Build and Run**:  
   Open the project in Xcode and run it on an iOS Simulator or a physical device running **iOS 17** or later.

---

## **Conclusion**  

This project demonstrates a professional approach to iOS development using **Swift**, blending **UIKit** and **SwiftUI** effectively. The clean architecture, pagination, and filtering capabilities reflect best practices in app design and implementation.  

