# gulp-rev-replace-stream
[![NPM version][https://badge.fury.io/js/gulp-rev-replace-stream.png]][https://npmjs.org/package/gulp-rev-replace-stream]

> rev-replace-stream plugin for [gulp](https://github.com/wearefractal/gulp)

## Usage

First, install `gulp-rev-replace-stream` as a development dependency:

```shell
npm install --save-dev gulp-rev-replace-stream
```

Then, add it to your `gulpfile.js`:

```javascript
$ = require('gulp-load-plugins')()

// optimize
gulp.task 'optimize', function() {

  jsFilter     = $.filter('src/**/*.js');
  cssFilter    = $.filter('src/**/*.css');
  userefFilter = $.useref.assets();

  gulp.src('src/index.html', {base: 'src'})
    .pipe(userefFilter)
    .pipe(jsFilter)
    .pipe($.uglify())
    .pipe(jsFilter.restore())
    .pipe(cssFilter)
    .pipe($.minifyCss())
    .pipe(cssFilter.restore())
    .pipe(userefFilter.restore())
    .pipe($.useref())
    .pipe($.buffer())
    .pipe($.if(/^((?!(index\.html)).)*$/, $.rev()))
    .pipe($.revReplaceStream())
    .pipe(gulp.dest('dist'))
    .pipe($.size())
}

gulp.src("./src/*.ext")
	.pipe(rev-replace-stream({
		msg: "Hello Gulp!"
	}))
	.pipe(gulp.dest("./dist"));
```

## API

### revReplaceStream()

TODO: add instrutions.

## License

[MIT License](http://en.wikipedia.org/wiki/MIT_License)
