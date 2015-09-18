# Karma configuration
# Generated on Fri Oct 17 2014 13:15:07 GMT-0400 (EDT)

module.exports = (config) ->
  config.set

    # base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '.'


    # frameworks to use
    # available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['jasmine', 'browserify']


    # list of files / patterns to load in the browser
    files: [
      'spec/spec_helper.coffee'
      'spec/**/*_spec.coffee'
    ]


    # list of files to exclude
    exclude: []


    # preprocess matching files before serving them to the browser
    # available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors:
      'spec/**/*.coffee': ['browserify']

    browserify:
      extensions: ['.coffee', '.mustache', '.jade']

    # test results reporter to use
    # possible values: 'dots', 'progress'
    # available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: [
        'html'
        'mocha'
    ]


    # web server port
    port: 9876


    # enable / disable colors in the output (reporters and logs)
    colors: true


    # level of logging
    # possible values:
    # - config.LOG_DISABLE
    # - config.LOG_ERROR
    # - config.LOG_WARN
    # - config.LOG_INFO
    # - config.LOG_DEBUG
    logLevel: config.LOG_INFO


    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: true
    autoWatchBatchDelay: 500

    # start these browsers
    # available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['PhantomJS']


    # Continuous Integration mode
    # if true, Karma captures browsers, runs the tests and exits
    singleRun: false
