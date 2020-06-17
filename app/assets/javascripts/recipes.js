$(document).on('turbolinks:load', function(){

  $(function(){

  //querySelectorでfile_fieldを取得
  var file_field = document.querySelector('input[type=file]')
  //fileが選択された時に発火するイベント
  $('#recipe_image').change(function(){
    //選択したfileのオブジェクトをpropで取得
    var file = $('input[type="file"]').prop('files')[0];
    //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
    var fileReader = new FileReader();
    //読み込みが完了すると、srcにfileのURLを格納
    fileReader.onloadend = function() {
      var src = fileReader.result
      var html= `<div class="preview-content">
                   <div class="image-content">            
                     <img src="${src}" >
                   </div>
                   <div class="lower-box">
                      <div class="delete-box" id="delete_btn">
                        削除する
                      </div>
                   </div>
                 </div>`
      //image_box__container要素の前にhtmlを差し込む
      $('.preview-content').remove();
      $('.img-field').before(html);
    }
    fileReader.readAsDataURL(file);

    $(document).on('click', '.delete-box', function() {
      $('.preview-content').remove();
      $('#recipe_image').val("");

    });

    // $(document).on('click', '.update-box', function() {
    //   $('#recipe_image').trigger("click")
    //   $('.preview-content').remove();
    // });
    
  });


});
});

$(document).on('turbolinks:load', function(){
$(function(){
  $('.dropdwn li').hover(function(){
      $("ul", this).slideDown();
  }, function(){
      $("ul.dropdwn_menu",this).slideUp();
  });
});

$(function(){
  $('#comments').hover(function(){
    $('.comment-select').show();
  });
});

$(function(){
  $('.comment-select__write').on('click',function(){
    $('.comment-fields').show();
  });
});
});
