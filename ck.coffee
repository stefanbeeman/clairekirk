require('zappa') 8080, ->
    @use 'bodyParser', 'static'
    @enable 'default layout', 'minify'
    
    @stylus '/ck.css': '''
        body
            color: white
            background-color: black
            -webkit-touch-callout: none
            -webkit-user-select: none
            -khtml-user-select: none
            -moz-user-select: none
            -ms-user-select: none
            user-select: none
        
        div
            position: relative
        
        body
            overflow: hidden
            margin: 0px
        
        #scroll
            overflow: hidden
            width: 0px
            height: 0px
            z-index: 0
        
        #screens
            position: absolute
            height: 0px
            width: 20000em
        
        .screen
            height: 0px
            width: 0px
            float: left
            line-height: 714px
            font-size: 20px
            color: white
            text-align: center
        
        #nav
            position: fixed
            width: 100%
            left: 0px
            top: 24px
            z-index: 1
        
        #nav_inner
            height: 48px
            width: 768px
            background-color: white
            margin: auto
            
        .nav_item
            color: black
            display: inline-block
            float: left
            height: 48px
            line-height: 48px
            text-align: center
            width: 96px
            cursor: pointer
    '''
    
    @client '/ck.js': ->
        jQuery(document).ready ($) ->
            layout = ->
                w = $(window).width()
                h = $(window).height()
                $('#scroll, .screen').css('width', w)
                $('#scroll, #screens, .screen').css('height', h)
                $('#scroll').scrollable(
                    keyboard: true
                    circular: true
                )

            $(window).resize layout
            
            $('.nav_item').click ->
                scroll = $('#scroll').data('scrollable')
                target = parseInt( $(this).attr('href') )
                scroll.seekTo(target)
            
            init = ->
                layout()
            
            init()

    @view main: ->
        @title = 'ClaireKirk Studios'
        @stylesheet = '/ck'
        @scripts = ['/zappa/zappa', 'https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min', 'http://cdn.jquerytools.org/1.2.7/all/jquery.tools.min', '/ck']
        div id: 'nav', ->
            div id: 'nav_inner', ->
                span class: 'nav_item', href: '6', -> 'Amelia'
                span class: 'nav_item', href: '0', -> 'Main'
                span class: 'nav_item', href: '1', -> 'Work'
                span class: 'nav_item', href: '2', -> 'Store'
                span class: 'nav_item', href: '3', -> 'TBA'
                span class: 'nav_item', href: '4', -> 'Gallery'
                span class: 'nav_item', href: '5', -> 'Info'
                span class: 'nav_item', href: '6', -> 'Dan'
        div id: 'scroll', ->
            div id: 'screens', ->
                div class: 'screen', id: 'main', -> 'MAIN'
                div class: 'screen', id: 'work', -> 'WORK'
                div class: 'screen', id: 'store', -> 'STORE'
                div class: 'screen', id: 'tba', -> 'TBA'
                div class: 'screen', id: 'gallery', -> 'GALLERY'
                div class: 'screen', id: 'info', -> 'INFO'
                div class: 'screen', id: 'danmelia', -> 'DANMELIA'

    @get '/': ->
        @render 'main'
