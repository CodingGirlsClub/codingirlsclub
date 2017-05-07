/* 
 Project - Learn Education Template
 */

$(document).ready(function () {
    
    //preloader

// site preloader -- also uncomment the div in the header and the css style for #preloader
$(window).load(function(){
	$('#preloader').fadeOut('slow',function(){$(this).remove();});
});

// search form toggle
$(".search-toggle a").click(function(){
    $(".search-form").slideToggle();
});
    //nav hover dropdown
    $('.js-activated').dropdownHover({
        instantlyCloseOthers: false,
        delay: 0
    }).dropdown();
    //parallax
    $.stellar();
    //courses carousel
    $("#item-slider").owlCarousel({
    loop:true,
    margin:0,
    nav:false,
    responsive:{
        0:{
            items:1
        },
        600:{
            items:3
        },
        1000:{
            items:4
        }
    }
});
    //courses carousel
    $(".testi-slider").owlCarousel({
    loop:true,
    margin:0,
    nav:false,
    responsive:{
        0:{
            items:1
        },
        600:{
            items:1
        },
        1000:{
            items:1
        }
    }
});
    //video carousel
    $(".video-slider").owlCarousel({
    loop:true,
    margin:0,
    nav:false,
    responsive:{
        0:{
            items:1
        },
        600:{
            items:1
        },
        1000:{
            items:1
        }
    }
});

});
