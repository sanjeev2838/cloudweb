
$(document).on("click","#submit_button", function(e) {

    var intRegex = /^\d+$/;
   var count =  $("#count").val();
    if(!intRegex.test(count)) {
        alert("Age Count Field must be numeric")
        e.preventDefault()
    }

    for (i=0; i < count;){

      var age = $("#age"+i).val()
        if(!intRegex.test(age)) {
            alert("Age Field must be numeric")
            e.preventDefault()
        }
       i++
    }


});