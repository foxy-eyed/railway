$(document).on('turbolinks:load', function() {
    function toggleForm(pk) {
        var container = '.js-container-' + pk,
            trigger = '.js-trigger-' + pk;

        $('.form-container').not(container).addClass('hidden');
        $('.pseudo-link').not(trigger).removeClass('hidden');

        $(trigger).toggleClass('hidden');
        $(container).toggleClass('hidden');
    }

    $('.railway-stations-grid .pseudo-link').on('click', function() {
        var pk = $(this).closest('tr').data('pk');
        toggleForm(pk);
    });

    $('.railway-stations-grid button').on('click', function(e) {
        e.preventDefault();
        var pk = $(this).closest('tr').data('pk'),
            submitPath = $(this).data('ajax-path'),
            $form = $(this).closest('form'),
            $trigger = $('.js-trigger-' + pk),
            currentVal = $trigger.text();

        $form.find('.text-danger').remove();

        if (typeof submitPath !== 'undefined') {
            $.ajax({
                url: submitPath,
                dataType: 'json',
                data: $form.serialize(),
                method: 'PUT'
            }).done(function(data) {
                $trigger.text(data.title);
                toggleForm(pk);
            }).fail(function(jqXHR) {
                var errors = [];
                $.each(jqXHR.responseJSON, function(field, error) {
                    errors.push(error);
                });
                var $errorMsg = $('<p>' + errors.join('<br/>') + '</p>').addClass('text-danger');
                $errorMsg.appendTo($form);
            });
        } else {
            $trigger.text(currentVal);
            toggleForm(pk);
        }
    });
});
