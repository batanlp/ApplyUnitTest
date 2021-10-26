# mvldev-assignment-7fc65c81
IOS Developer - Nguyen Ba Tan

## 1. General information

Language: Swift 5.0 <br />
Xcode: 12.5 <br />
Deployment target: iOS 11.0 <br />
Architect model: MVVVM <br />

Ref API:
- Get Geocode information
https://aqicn.org/json-api/doc/#api-Geolocalized_Feed-GetGeolocFeed
- Get Air Auality information
https://www.bigdatacloud.com/geocoding-apis/free-reverse-geocode-to-city-api

### 2. Guideline

#### Install Cocoapods

> sudo gem install cocoapods

#### Install pod for project

> pod install

#### Emulate GPS location on iOS Simulator

Run project on simulator -> click GPS icon -> Select GPS file to simulate GPS

![alt text](https://i.imgur.com/1qwQb91.png)

If want to change default GPS location, open GPS.gpx file and change value as you want


#### How to use applicaton

Due to lack of time, application only supports some basic function, some edge cases can not work.

- Start application, enable Location Services to get location
- Marker will appear at center of the map. Move map action will change Marker coordinate.
- When "set" button (at bottom-right screen) is clicked. Point A & B is set by sequentially. When both point is set -> will move to result screen and reset both point A & B
- When "Set" button is clicked. Coordinate will save to local cache.
- Icon history will appear when have saved point.
- Demo https://www.youtube.com/watch?v=-vHRo-JC3h8

### 3. Other

- Due to this is simple and small project, I don't use Alamorefire to make project lighter.
- I don't prefer to use RxSwift due to
   + Apple released Combine have the same function as RxSwift. More, Combine have better performance and use fully abilities of ARC.
   + RxSwift is hard for debug.
   + RxSwift is quite difficult to learn and apply. This fact makes it difficult to attract new specialists to the ongoing project, especially at later stages.
