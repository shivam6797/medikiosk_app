# MediKiosk 🩺 - Flutter Clinic Appointment App

MediKiosk is a modern Flutter-based clinic appointment booking app that allows patients to login via OTP, view a list of available doctors, book appointments, and manage their upcoming bookings — all within a clean and responsive UI.

---

## 🔍 Project Overview

This app was developed as part of a **Flutter Developer Assessment Task** assigned by **Nihin Media K.K.**, with the objective of evaluating skills in:

- Clean UI/UX implementation
- State management using BLoC
- Persistent storage handling
- Modular coding structure
- Real-world app-like logic simulation (e.g. booking flow)

---

## 🧠 Why This Project (Boot Reason)

> "After working in a service-based company (Accedom IT Pvt. Ltd.), I wanted to build a **complete, production-grade Flutter application** from scratch — with real app features, clean architecture, and scalable state management — to demonstrate my hands-on experience and professional growth as a Flutter Developer."

This app became the perfect **learning + showcasing project** for:

- Exploring BLoC pattern for large-scale apps
- Building responsive & adaptive UI
- Theme toggling (light/dark mode)
- Navigation & argument handling
- Shared Preferences usage

---

## ✨ Features Implemented

- ✅ OTP-based Login Simulation (via SharedPreferences)
- ✅ Light & Dark Theme Support (with toggle switch)
- ✅ Animated Splash Screen (Lottie-based)
- ✅ Doctor Listing (Bloc-powered, filter online doctors)
- ✅ Book Appointment Flow:
  - Select Doctor → Select Slot → Confirm Booking
- ✅ View Booked Appointments (My Appointments)
- ✅ Delete/Cancel Appointments
- ✅ Real-Time Doctor Status Tracking (with snackbar alerts)
- ✅ App-wide inactivity wrapper for session handling
- ✅ Fully responsive UI (mobile-friendly)

---

## 🖼 Screenshots

<table>
  <tr>
    <td align="center"><img src="https://github.com/user-attachments/assets/9c6852ad-1c48-4cf9-b0ee-71a23b4fc692" width="250" /></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/61a9d3e8-9219-4f4b-8cdf-7f3437d0697e" width="250" /></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/2f6a67e0-8033-46cc-bb5a-934d37eb3efe" width="250" /></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/cc9c226b-fc77-4af7-8d31-c74b8f745569" width="250" /></td>    
  </tr>
  <tr>
     <td align="center"><img src="https://github.com/user-attachments/assets/b206d457-fb15-418c-bf80-d8afba6bdffc" width="250" /></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/469fd93f-3af0-4644-9978-822ff5062fa2" width="250" /></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/0c48ae11-7b3d-4a5c-83f6-55bf520e1a04" width="250" /></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/0c489991-63ff-4a51-836b-97f6d283fa1f" width="250" /></td>
  </tr>
   <tr>
     <td align="center"><img src="https://github.com/user-attachments/assets/41875eb7-7ce7-46f0-b35e-6116e0a1f2aa" width="250" /></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/56fe48d1-7811-4dac-8864-977bd631e4bf" width="250" /></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/7e0f3f25-3025-4296-b519-36891a2369ba" width="250" /></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/ee70786f-a331-4d8b-8852-f25df734cbd7" width="250" /></td>
  </tr>
   <tr>
     <td align="center"><img src="https://github.com/user-attachments/assets/9600a8f0-d38a-457e-a9fa-e812f384c78a" width="250" /></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/a033b1d3-d140-4e16-86f6-1814ccd57b86" width="250" /></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/5882e1a9-900c-4f1b-abd9-76a84ac1046d" width="250" /></td>
  </tr>
</table>

## 🛠 Build & Run Instructions

> Based on the task assignment requirements.

### 📦 Prerequisites

- Flutter 3.32.4 or above
- Android Studio or VSCode with Flutter plugin
- Dart SDK

### 📁 Steps to Build & Run:

1. **Clone the repo**

```bash
git clone https://github.com/yourusername/medikiosk_flutter_app.git
cd medikiosk_flutter_app

2. Install dependencies
flutter pub get

3. Run the app
flutter run

4. Build APK:
flutter build apk --release

### 📁 Project Structure

lib/
│
├── app/                 # App routes, theme, entry point
├── core/
│   ├── constants/       # App colors, sizes, etc.
│   ├── widget/          # Inactivity wrapper, reusable widgets
│   └── utils/           # System UI helper , inactive_services
│
├── features/
│   ├── auth/            # Login logic (bloc, screen)
│   ├── doctor/          # Doctor listing (bloc, model, UI)
│   ├── booking/         # Slot booking, appointments (bloc, model, UI)
│  
│
└── main.dart            # Entry point

🤝 Acknowledgements
Thanks to Nihin Media K.K. for this practical assignment.

Lottie animations from LottieFiles

Inspired by real-world appointment UX patterns (Practo, ZocDoc)

📬 Contact
Shivam Singh
📍 Agra, India
📧 shivampratap6797@gmail.com
📱 +91-9084589402
🔗 LinkedIn | GitHub







