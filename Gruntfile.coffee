module.exports = ( grunt ) ->

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    coffee:
      compile:
        expand: true
        flatten: true
        cwd: "#{ __dirname }/src/"
        src: [ '*.coffee' ]
        dest: 'dist/'
        ext: '.js'

    uglify:
      options:
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      build:
        src: 'dist/<%= pkg.name %>.js'
        dest: 'dist/<%= pkg.name %>.min.js'

    watch:
      coffee:
        files: 'src/*.coffee'
        tasks: [ 'coffee:compile' ]


  # Default task(s).
  grunt.registerTask 'default', [
    'coffee'
    'uglify'
    ]

