# SocialLoginDemoUsingFirebase-ObjC
A Demo using Firebase to intergate Facebook Login and Google Login written in Objective-C.

## Configure the .plist file
Find the .plist file in the Supporting File folder in your XCode Project.
1. Right-click your .plist file and choose "Open As Source Code"
2. Copy and paste the followin XML sinppet into the body of your file
```<dict>...</dict>```
```code
<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeRole</key>
			<string></string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>com.googleusercontent.apps.679494112960-0ln6fvrqu4v0s7ht2vci1mjtk5s5kp1t</string>
			</array>
		</dict>
		<dict>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>fb1286656404776431</string>
			</array>
		</dict>
	</array>
	<key>FacebookAppID</key>
	<string>1286656404776431</string>
	<key>FacebookDisplayName</key>
	<string>LoginDemo</string>
	<key>LSApplicationQueriesSchemes</key>
	<array>
		<string>fbapi</string>
		<string>fb-messenger-api</string>
		<string>fbauth2</string>
		<string>fbshareextension</string>
	</array>
```

## Add the google configuration file to your project
Drag the GoogleService-Info.plist you just downloaded into the root of your XCode Project.

## Screen
<div align="center">
  <img src="https://github.com/jhsiao21/SocialLoginDemoUsingFirebase-ObjC/blob/master/screen.jpg"> 
  </div>


