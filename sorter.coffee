#!/usr/bin/env coffee

argv = require('optimist').argv
fs = require 'fs'
glob = require 'glob'
_ = require 'underscore'

tvTemp = '../tv_temp/'
movieTemp = '../movie_temp/'

showPattern = ///
  s\d{2}
  ///i

lftpPattern = 'lftp-pget-status'

films = []
shows = []
downloading = []


processFiles = (_files) ->
  for file in _files
    if file[-16..-1] is lftpPattern
      downloading.push file[0..-18]

    else if showPattern.test file
      shows.push file
    else
      films.push file

  shows = scrubPendingFiles shows
  films = scrubPendingFiles films

  do moveFiles

scrubPendingFiles = (_array) ->
  _.difference _array, downloading


moveFiles = () ->
  for show in shows
    copy show, tvTemp + show.split('/').pop()
    fs.rename show, tvTemp + show.split('/').pop()

  for movie in films
    fs.rename movie, movieTemp + movie.split('/').pop()


copy = (_src, _dest) ->
  fs.createReadStream( _src ).pipe fs.createWriteStream( _dest )


processFiles argv._
# console.log argv._

# fs.createReadStream( 'files/mud.2012.1080p.bluray.x264-sparks.mkv' ).pipe(
#   fs.createWriteStream( 'movie_temp/mud.2012.1080p.bluray.x264-sparks.mkv' )
# )

