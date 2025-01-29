# Artify - Wallpaper Sharing App

## Project Description

Artify is a mobile application built with Flutter and a backend powered by Express.js.

## Technologies

- **Frontend**: Flutter (Dart)
- **Backend**: Express.js (Node.js)
- **Database**: MongoDB

## API Endpoints

| Method | URL           | Description                          |
| ------ | ------------- | ------------------------------------ |
| POST   | /login        | Logs in the user                     |
| POST   | /register     | Register the user                    |
| POST   | /favorites    | Retrieves user's favorite wallpapers |
| GET    | /images       | Get all images                       |
| GET    | /images/:slug | Get image                            |

## Environment Variables

Create a `.env` file for the backend with the following structure:

```
PORT=4001
MONGODB_URI=your_database_url
```
