

## 📄 **ADBConnector - ADB Wireless Manager for macOS**
<p>
  <img src="https://github.com/Spiritman021/ADBConnector/blob/main/ADBConnector/Assets.xcassets/AppIcon.appiconset/1024.png?raw=true" alt="ADBConnector Logo" width="150"/>
</p>

ADBConnector is a simple and efficient macOS utility that helps Android developers **pair** and **connect** their devices over Wi-Fi using ADB (Android Debug Bridge) — without needing to touch the terminal every time!

Skip the repetitive `adb pair` and `adb connect` commands — manage everything with a sleek UI.

---

### 🚀 **Features**
- 🔗 **Pair Android Devices Wirelessly** with IP and pairing code.
- 📡 **Connect Devices** over Wi-Fi effortlessly.
- 🎨 Lightweight macOS native app built with SwiftUI.

---

### 🖥️ **App Preview**
<img src="https://github.com/Spiritman021/ADBConnector/blob/main/screenshots/screen1.png?raw=true" alt="ADBConnector Screenshot" width="700"/>

---

### ⚙️ **Requirements**
- macOS 14.6 or later
- ADB installed via Homebrew or Android Studio SDK  
  (`/opt/homebrew/bin/adb` path assumed)
- Android device with **Wireless Debugging** enabled

---

### 🔧 **Installation**
1. Clone the repository:
   ```bash
   git clone https://github.com/Spiritman021/ADBConnector.git
   ```

2. Open `ADBConnector.xcodeproj` in Xcode.

3. Ensure ADB is installed and accessible at:
   ```
   /opt/homebrew/bin/adb
   ```

4. Build & Run the project.

---

### 📡 **How to Use**
1. Enable **Wireless Debugging** on your Android device.
2. Enter the **Pairing IP:Port** and **Pair Code**.
3. Click **Pair Device**.
4. Enter the **Connect IP:Port** and click **Connect Device**.
5. Monitor ADB responses in the Status Log.

The app remembers your last inputs for faster reconnections!

---

### 🛠️ **Customization**
If your ADB path is different, update the following in `ContentView.swift`:

```swift
process.launchPath = "/your/custom/path/adb"
```

---

### 🤝 **Contributing**
Feel free to fork this repo, suggest improvements, or submit pull requests!

---

### 📄 **License**
You’re free to use, modify, and distribute this software.

---

### 🙌 **Credits**
Developed by [Vishal Anand](https://github.com/Spiritman021)  

---

## 🚀 *Happy Wireless Debugging!*
