$(function() {
    $("#demo").dragend({
        afterInitialize: function() {
            this.container.style.visibility = "visible";
        },
        onSwipeEnd: function() {
            var first = this.pages[0],
                last = this.pages[this.pages.length - 1];

            $(".prev, .next").removeClass("deactivated");
            $(".nav li").removeClass("active");

            if (first === this.activeElement) {
                $(".prev").addClass("deactivated")
            };

            if (last === this.activeElement) {
                $(".next").addClass("deactivated")
            }

            $(".nav li").eq(this.page).addClass("active");

        }
    });

    $(".prev").click(function() {
        $("#demo").dragend("right");
    });

    $(".next").click(function() {
        $("#demo").dragend("left");
    });

    $(".nav").click(function() {
        var page = $(event.target).data("page");

        $("#demo").dragend({
            scrollToPage: page
        });

        $(event.target).addClass("active");

    })

});

var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-219062-10']);
_gaq.push(['_trackPageview']);
