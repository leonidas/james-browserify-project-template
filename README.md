# Deprecated

Please use [gulp-project-template](https://github.com/leonidas/gulp-project-template).

Project template for James.js and Browserify

## Getting started
    git clone git@github.com:rikukissa/james-browserify-project-template.git
    npm install
    bower install
    james watch httpd
    iexplore http://localhost:9002

## Technology choices

* [James](https://github.com/leonidas/james.js)
* [Browserify](https://github.com/substack/node-browserify)
* [CoffeeScript](https://github.com/jashkenas/coffee-script)
* Static [Jade](https://github.com/visionmedia/jade) templates
* [Stylus](https://github.com/learnboost/stylus)
* [UglifyJS](https://github.com/mishoo/UglifyJS2)
* [Bower](http://bower.io/)

## Layout

* server: all server-side code
* client: all client-side code
  * coffee
  * jade
  * stylus
* public: static files

## Branches
* __angular__
    * contains a version with AngularJS and a template app
