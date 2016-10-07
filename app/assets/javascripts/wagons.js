$(document).on('turbolinks:load', function() {
    var $wagon_type = $('#wagon_type'),
        $wagon_place = $('.wagon-place');

    function switchWagonFields(wagon_type) {
        $wagon_place.hide();
        $wagon_place.each(function() {
            if ($(this).attr('rel').split('|').includes(wagon_type)) $(this).show();
        });
    }

    switchWagonFields($wagon_type.val());

    $wagon_type.on('change', function() {
        switchWagonFields($(this).val());
    });
});
