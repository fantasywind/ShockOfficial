'use strict'

angular.module('shockApp')
  .service 'Uploadphoto', () ->
    # AngularJS will instantiate a singleton by calling "new" on this function
    _uploadPools = []

    class FileStatus
      constructor: (@file, @queue)->
        @status = @WAIT
        @src = null

      upload: ->
        fd = new FormData()
        fd.append 'file', @file

        @status = @UPLOADING

        $.ajax
          url: '/api/photo'
          type: 'POST'
          data: fd
          dataType: 'json'
          processData: false
          contentType: false
          error: (xhr, status, msg)=>
            @status = @ERROR
            console.error "Upload photo error: #{msg}"
            @queue.next()
          success: (resp)=>
            if resp.status is @RESPONSE_OK
              @status = @SUCCESS
              @thumb120 = resp.thumb
              @origin = resp.src
              @filename = resp.name
              @photo_id = resp.photo_id
            else
              @status = @ERROR
            @queue.eachFinish.call @
            @queue.next()

      RESPONSE_OK: 'ok'
      WAIT: 'wait'
      UPLOADING: 'uploading'
      SUCCESS: 'success'
      ERROR: 'error'

    class UploadQueue
      constructor: (options)->
        {files, @eachFinish, @done} = options

        @_cursor = 0
        @status = @WAIT
        @files = []

        for file in files
          @files.push new FileStatus file, @

      start_upload: ->
        return false if @status is @FINISH

        @status = @UPLOADING
        @files[@_cursor].upload()

      next: ->
        if @_cursor is @files.length - 1
          @status = @FINISH
          @done.call @ if typeof @done is 'function'
        else
          @_cursor += 1
          @files[@_cursor].upload()

      FINISH: 'finish'
      UPLOADING: 'uploading'
      PAUSE: 'pause'
      WAIT: 'wait'

    @uploadFiles = (files, eachFinish, done)->
      return false if files.constructor isnt FileList

      queue = new UploadQueue
        files: files
        eachFinish: eachFinish or ->
          console.log "Upload photo #{@queue._cursor + 1} / #{@queue.files.length}"
        done: done or ->
          console.log "Uploaded #{@files.length} photo(s)"

      _uploadPools.push queue
      return queue

    return @