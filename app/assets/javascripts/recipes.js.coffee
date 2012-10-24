$("#recipe_body").bind "keyup", ->
    $.ajax({
        url:  "/recipes/preview",
        data: { "recipe[body]": $(this).val() },
        dataType: "html",
    }).done (html)->
        $("#preview").html(html)
