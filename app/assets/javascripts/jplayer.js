$(window).bind('load', function() {
    window.jplayer = $('<div id="jp_container_1"><a href="#" class="jp-play">Play</a><a href="#" class="jp-pause">Pause</a></div>');
    $(window.jplayer).jPlayer({
        ready: function(event) {
            $(this).jPlayer("setMedia", {
                title: "Hush Hush",
                mp3: "",
                oga: "",
                m4a: ""
            });
            // $(this).jPlayer('play');
        },
        swfPath: "/assets",
        supplied: "mp3,oga,m4a"
    });
});