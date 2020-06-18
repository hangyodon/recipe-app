$(document).on('turbolinks:load', function(){

  $(function(){

  //querySelectorでfile_fieldを取得
  var file_field = document.querySelector('input[type=file]')
  //fileが選択された時に発火するイベント
  $('#report_image').change(function(){
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
    $('.img-field label').text('画像を変更する');

    $(document).on('click', '.delete-box', function() {
      $('.preview-content').remove();
      $('#report_image').val("");
      $('.img-field label').text('画像を選択する');

    });

    
  });


});
});