# 🌌 SpaceHub

## Overview & Vision

SpaceHub brings together data from multiple open space APIs — NASA, ISS, space news sources, and more — into one customizable and inspiring experience. Users open the app to see NASA’s Photo of the Day, track the position of the ISS, read fresh space news, view asteroids passing near Earth, and build their own collection of favorite discoveries.

They can customize the dashboard, like and save items, search missions, rearrange tiles, comment on events, and return to content even offline — all in one place, without noise, purely for the joy of observing the cosmos. The goal is to create a functional product and a showcase of scalable Flutter architecture using BLoC, GoRouter, Firebase, and modular features.

## 🚧 Project Status

SpaceHub is currently in **early development**. This is a personal side project developed for personal use and shared openly for anyone who may find it useful or interesting.

## ✨ Planned Features

### 🔐 Authentication

- Firebase email/password login
- Persistent user sessions
- Storing user metadata in Firestore

### 🏠 Customizable Dashboard

- Drag-and-drop cards
- NASA Astronomy Picture of the Day
- ISS real-time location
- Near-Earth Objects overview
- Space weather index
- Upcoming launches

### 📰 News Feed

- Articles from space-related public APIs
- Smooth transitions to detailed screens
- Pull-to-refresh and infinite scrolling

### 🔎 Search

- Search across news and missions
- Debounced input
- Unified navigation to details

### 🧵 Real-Time Interactions

- Likes
- Comments
- Saved items
- Firestore streams

### 📱 Deep Links (Planned)

- Support for `/detailed/{id}`
- Integration with push notifications

### 🗺 Map Features (Planned)

- ISS marker & trajectory
- Basic clustering
- Space overlays

## 🧱 Tech Stack

- Flutter
- BLoC state management
- GoRouter with ShellRoute
- Firebase Auth / Firestore / Storage
- Dio for networking
- Feature-based project architecture
- Custom UI Kit (internal package)

## ⚖️ License

Released under the **MIT License**.
