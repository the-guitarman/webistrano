//new_deployment


jQuery(function($) {
    $.fn.applyCheckboxSelectors = function() {        
        $(this).find('.checkbox-selector.select-all').click(function(e){
            $('input[type=checkbox]').attr('checked', 'checked');
            return false;
        });
        $(this).find('.checkbox-selector.deselect-all').click(function(e){
            $('input[type=checkbox]').removeAttr('checked');
            return false;
        });
    };
    
    $('#new_deployment').applyCheckboxSelectors();
});