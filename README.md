# Rock-Paper-Scissors

![Static Badge](https://img.shields.io/badge/C%2B%2B-%2300599C?style=for-the-badge&logo=cplusplus)
![Static Badge](https://img.shields.io/badge/Qt-orange?style=for-the-badge&logo=qt)
![Static Badge](https://img.shields.io/badge/MQTT-yellow?style=for-the-badge&logo=mqtt)
![Static Badge](https://img.shields.io/badge/CMake-cyan?style=for-the-badge&logo=cmake)



## Description

This project was developed using Qt Creator. It is a desktop Rock-Paper-Scissors game where the player competes against an AI opponent.

The application is designed for users who own an ESP32 device. It includes a settings menu that allows users to customize the theme, configure the buttons used to select Rock, Paper, or Scissors, and track game statistics such as the number of matches won by the player and the AI.

## Set Up

### Requirements

Before running the project, make sure you have the following software installed:

- Qt Creator
- Qt 6.2
- A C++ compiler compatible with Qt (MinGW/MSVC on Windows)
- ESP32 device (optional, required only for hardware interaction)
- MQTT broker 

### Installation

1. Clone the repository:

```bash
git clone https://github.com/Marc-Borrell/rock-paper-scissors.git
```

2. Open the project in Qt Creator.

3. Configure the project kit and compiler if prompted.

4. Build the project by selecting **Build > Build Project**.

5. Run the application by clicking the **Run** button in Qt Creator.

### ESP32 Configuration

If you want to use the game with an ESP32 device:

1. Connect the ESP32 to your computer.
2. Configure the communication settings in the application.
3. Select the desired buttons and theme from the settings menu.
4. Start the game and play against the AI.

## Features

- Play Rock, Paper, Scissors against an AI.
- Customizable button mapping.
- Theme selection.
- Match statistics tracking.
- ESP32 integration support.

## Technologies Used

- Qt Creator
- Qt Quick (QML)
- C++
- ESP32
- MQTT

## DEMO

Main screen<br>

<img width="794" height="630" alt="image" src="https://github.com/user-attachments/assets/0de155cc-9275-4d79-aace-eaf469455922" />

Victory screen<br>

<img width="797" height="636" alt="image" src="https://github.com/user-attachments/assets/5ec44dfb-a01c-4a0e-83c1-8d78d3b8b5e7" />

Tie screen<br>

<img width="796" height="639" alt="image" src="https://github.com/user-attachments/assets/22285b79-19be-4ff8-a6f8-05c70b3a6b76" />

Settings screen<br>

<img width="794" height="631" alt="image" src="https://github.com/user-attachments/assets/5cc2e611-fdad-4406-8050-d0091da1cb86" />

Settings screen(2)<br>

<img width="788" height="395" alt="image" src="https://github.com/user-attachments/assets/d7920022-a214-4fa3-babf-e288374c7b46" /> <br>
You need to introduce your device MAC + the button name to select which button to use in each element.






