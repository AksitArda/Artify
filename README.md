# Artify - Wallpaper Sharing App

![App Gif](https://github.com/AksitArda/Artify/blob/main/Screenshots/Project.gif?raw=true)

##Demo Video
![Demo Video](https://github.com/AksitArda/Artify/blob/main/Screenshots/Demo%20Record.mp4)

## Project Description

Artify is a mobile application built with Flutter and a backend powered by Express.js.

## Technologies

- **Frontend**: Flutter (Dart)
- **Backend**: Express.js (Node.js)
- **Database**: MongoDB

## API Endpoints

| Method | URL          | Description                          |
| ------ | ------------ | ------------------------------------ |
| POST   | /login       | Logs in the user                     |
| POST   | /register    | Register the user                    |
| POST   | /favorites   | Retrieves user's favorite wallpapers |
| GET    | /images      | Get all images                       |
| GET    | /image/:slug | Get image                            |

## Environment Variables

Create a `.env` file for the backend with the following structure:

```
PORT=4001
MONGODB_URI=your_database_url
```
## Database Struct
![Database Photos](https://github.com/AksitArda/Artify/blob/main/Screenshots/Database%20Photos.png?raw=true)
![Database User](https://github.com/AksitArda/Artify/blob/main/Screenshots/Database%20User.png?raw=true)

## Screenshots
![Screenshot 1](https://github.com/AksitArda/Artify/blob/main/Screenshots/Screenshot1.png?raw=true)
![Screenshot 2](https://github.com/AksitArda/Artify/blob/main/Screenshots/Screenshot2.png?raw=true)
![Screenshot 3](https://github.com/AksitArda/Artify/blob/main/Screenshots/Screenshot3.png?raw=true)
![Screenshot 4](https://github.com/AksitArda/Artify/blob/main/Screenshots/Screenshot4.png?raw=true)
![Screenshot 5](https://github.com/AksitArda/Artify/blob/main/Screenshots/Screenshot5.png?raw=true)
