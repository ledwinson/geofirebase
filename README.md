# firebasegeo
Firebase4 and Geofire for storing user location sample IOS swift

1. clone or download project
2. cd to FireBaseandGeoFire folder and execute pod install
3. now open FireBaseandGeoFire.xcworkspace in xcode.
# set up Firebase.
1. Login to firebase console
2. Create a project in Firebase and download  GoogleService-Info.plist
3. Go to Authentication and enable email/password login
4. Create a test user test@gmail.com/password
5.copy the downloaded GoogleService-Info.plist top your project
6. Change the Build Identifier in xcode as thew same value used in Firebase console.

# compile and run

7. Compile the project. If you get an error 'FirebaseDatabase/FirebaseDatabase.h' file not found, then  
select FirebaseDatabase.framework from pods and link it to Geofire as shown here: https://stackoverflow.com/questions/47129318/how-to-use-geofire-with-swift-to-store-location-from-one-simulator-and-then-show

8. After executing the project and everything goes well you can see the location styored in firebase for hthe test user logged in.




