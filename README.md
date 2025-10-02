# 📊 Instagram Dashboard – Flutter + FastAPI  

🚀 **Golden Card Task Project** – A centralized dashboard that scrapes data from Instagram public profiles and displays real-time rankings, built with **Flutter (frontend)** and **FastAPI (backend)**.  

---

## ✨ Features
- 🔎 Scrapes Instagram public profiles using `instaloader`  
- 📈 Collects:
  - Username / Profile Name  
  - Followers  
  - Following  
  - Posts Count  
- 🏆 Dashboard with real-time rankings by followers  
- 🔄 Auto-refresh support  
- 🔍 Sorting & filtering (frontend)  
- 🌐 Frontend built with **Flutter Web**  
- ⚡ Backend powered by **FastAPI**  

---

## 📂 Project Structure
instagram-dashboard/
- ├── golden_task/ # Flutter app (UI dashboard)
- └── backend/ # FastAPI app (API + Instagram scraper)

---

## 🖥️ Running Backend (FastAPI)
1. Go to backend folder  
   ```bash
   cd backend
2. (Optional) Create virtual environment
   ```bash
   python -m venv venv
   source venv/bin/activate   # Mac/Linux
   venv\Scripts\activate      # Windows
3. Install dependencies
   ```bash
   pip install -r requirements.txt
4. Run the server
   ```bash
   uvicorn main:app --reload
5. API will be available at:
  - Root → http://127.0.0.1:8000/
  - Profiles endpoint → http://127.0.0.1:8000/profiles

---

## 🌐 Running Frontend (Flutter Web)
1. Go to frontend folder
  ```bash
  cd golden_task
```
2. Install packages
  ```bash
  flutter pub get
```
3. Run app in browser
   ```bash
   flutter run -d chrome

---

## 👨‍💻 Tech Stack
- Frontend: Flutter Web
- Backend: FastAPI, Instaloader
- Languages: Python, Dart

---

## 🚀 How It Works
1. Backend scrapes Instagram profile data (followers, following, posts).
2. Data is exposed via REST API (/profiles).
3. Frontend fetches this API and displays rankings in a clean dashboard.
