$(document).on('turbolinks:load', function() {
    function toggleForm(pk) {
        var currentRow = '.js-content-' + pk,
            currentForm = '.js-form-' + pk;

        $('.form-container').not(currentForm).addClass('hidden');
        $('.content-container').not(currentRow).removeClass('hidden');

        $(currentRow).toggleClass('hidden');
        $(currentForm).toggleClass('hidden');
    }

    function keepRow($row) {
        var values = [];
        $row.find('.pseudo-link').each(function() {
            values.push($(this).text());
        });
        return values;
    }

    function fillRow($row, data) {
        $row.find('.pseudo-link').each(function(i) {
           $(this).text(data[i]);
        });
    }

    $('.route-stations-grid .pseudo-link, .route-stations-grid .button-column a').on('click', function(e) {
        e.preventDefault();
        var pk = $(this).closest('tr').data('pk');
        toggleForm(pk);
    });

    $('.route-stations-grid button').on('click', function(e) {
        e.preventDefault();
        var pk = $(this).closest('tr').data('pk'),
            submitPath = $(this).data('ajax-path'),
            $currentRow = $('.js-content-' + pk),
            $form = $(this).closest('form'),
            currentValues = keepRow($currentRow);

        $form.find('.text-danger').remove();

        if (typeof submitPath !== 'undefined') {
            $.ajax({
                url: submitPath,
                dataType: 'json',
                data: $form.serialize(),
                method: 'PUT'
            }).done(function(data) {
                console.log(data);
                fillRow($currentRow, [data.position, data.arrival_time, data.departure_time]);
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
            fillRow($currentRow, currentValues);
            toggleForm(pk);
        }
    });
});
