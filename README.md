# An ActionScript Library implementing the OAuth 1.0 Protocol [![Build Status](https://travis-ci.org/jschaedl/as3-oauth.svg)](https://travis-ci.org/jschaedl/as3-oauth)

An ActionScript 3 library for making authenticated web service request based on the OAuth 1.0 protocol. This library is implemented according to the [OAuth 1.0 Sspecification](https://tools.ietf.org/html/rfc5849).

## Overview

This library is built for use with in Flash/Flex/AIR projects to facilitate communication with OAuth 1.0 services. It provides mechanisms to authenticate against OAuth 1.0 servers using all standard authentication and authorization workflows.

### Features

The ActionScript OAuth 1.0 Library supports the following features...

* [x] ability to [fetch temporary credentials](https://tools.ietf.org/html/rfc5849#section-2.1)
* [x] ability to [authorize a resource owner](https://tools.ietf.org/html/rfc5849#section-2.2) 
* [x] ability to [fetch token credentials](https://tools.ietf.org/html/rfc5849#section-2.3) 
* [x] ability to [make authenticated requests](https://tools.ietf.org/html/rfc5849#section-3) 
* [ ] provide an OAuthRequestHelper implementing an event based request and response mechanism (to be done)
* [ ] provide an OAuthHTTPService for using it in a mxml file (to be done)
* [ ] parse an oauth response into a fully typed object (to be done)

### Dependencies

* [as3-crypto](https://github.com/jschaedl/as3-crypto)

## Reference

### Installation

The easy way to use this library, is to simply drop in the SWC (or the source) found under ```bin``` folder into your projects ```libs``` folder, along with the appropriate dependencies.

If you use Maven for dependency management, make sure as3-crypto (com.hurlant.as3-crypto) is available in your local maven repository. To install a file in your local maven repository use the following command:

```
mvn install:install-file -DgroupId=com.hurlant -DartifactId=as3-crypto -Dversion=1.0 -Dpackaging=swc -Dfile=libs/as3-crypto.swc
```  

Now you can install as3-oauth with the following Maven command:

```
mvn clean install -Dmaven.test.skip=true
```

And after adding the following dependency description to you ```pom.xml```:

```
<dependency>
	<groupId>org.janschaedlich.oauth</groupId>
	<artifactId>as3-oauth</artifactId>
	<version>1.0</version>
</dependency>
```

you can use this library in your project like the following paragraph demonstrates.

<!---
### Usage

...

### Demo

For a demo project using this library and an example Maven configuration have a look [here]().

### Documentation

You can find the full ASDocs for the project [here]().
--->

### Further Development

#### How to contribute
If you find bugs or want to enhance some functionality, please fork the master branch, fix the bug you found or add your enhancements and make a pull request. Please commit your changes in tiny steps and add a detailed description for every commit. 

<!---Please make sure that all changes be accompanied by passing unit tests.--->

#### Unit Tests
This library was built using a testdriven development approach and is therefore test covered. To run the units tests under folder ```src/test``` it is necessary that you have a FlashPlayer executable in your ```PATH```. 

You can use the ```getflashplayer.sh``` ShellScript to download and place a current FlashPlayer executable in your projects directory.

```
sh getflashplayer.sh 'http://download.macromedia.com/pub/flashplayer/installers/archive/fp_11.7.700.225_archive.zip'
``` 
Now run the tests with:

```
mvn clean test -Dflex.flashPlayer.command=Flash\ Player\ Debugger.app/Contents/MacOS/Flash\ Player\ Debugger
```

## Author

[Jan Schädlich](https://github.com/jschaedl)

<!---
## Acknowledgments

* Thanks to the [Travis-CI Actionscript Demo Project](https://github.com/Larusso/travis-CI-actionscript-demo) for providing the getflashplayer.sh ShellScript
--->

## License

The ActionScript OAuth 1.0 Library is licensed under the [MIT License](http://opensource.org/licenses/MIT).